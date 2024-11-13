typealias TransitionMatrix = [[String]: [String]]

public enum TextGenerationError: Error {
    case noStartingTokens
}

public class TextGenerator {
    var transitions: TransitionMatrix = [:]
    var startingTokens: [[String]] = []
    let sampleSize: Int

    init(withSampleSizeOf size: Int = 2) {
        self.sampleSize = size
    }

    /// Build transitions from a sentence.
    ///
    /// The sentence is segmented on spaces and lowercased
    /// before using to build the transitions.
    /// - Parameter sentence: A sentence.
    public func buildTransitions(fromSentence sentence: String) {
        let tokens = sentence.split(separator: " ").map {
            $0.lowercased()
        }

        for index in tokens.dropLast(sampleSize).indices {
            let token = Array(tokens[index..<index + sampleSize])
            // Collect starting tokens
            if index == 0 {
                startingTokens.append(token)
            }

            let nextToken = tokens[index + sampleSize]
            transitions[token, default: []].append(nextToken)
        }

    }

    func predictNextToken(from token: [String]) -> String? {
        return transitions[token]?.randomElement()
    }

    /// Make a sentence that sounds similar to the text source provided
    ///
    /// The generated sentence might be an exisiting sentence
    /// in the text source if the provided text source is too small
    ///
    /// - Parameters:
    ///
    /// - Throws: `TextGenerationError.noStartingTokens` if there is no starting tokens
    /// - Returns: Sentence generated using Markov process
    public func makeSentence() throws(TextGenerationError) -> String? {
        guard var state = startingTokens.randomElement() else {
            throw .noStartingTokens
        }

        var sentence = state.joined(separator: " ")
        while let nextToken = predictNextToken(from: state) {
            sentence.append(contentsOf: " " + nextToken)
            state = state.dropFirst() + [nextToken]
        }

        return sentence
    }
}
