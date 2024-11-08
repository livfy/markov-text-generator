typealias TransitionMatrix = [[String]: [String]]

class TextGenerator {
    var transitions: TransitionMatrix = [:]
    var startingTokens: [[String]] = []
    let sampleSize: Int

    init(withSampleSizeOf size: Int = 2) {
        self.sampleSize = size
    }

    /// Build transitions from sentence usually seperated as words
    /// Use this to avoid storing whole text source in memeory
    /// - Parameter sentences: List of sentences:
    func buildTransitions(fromSentences sentences: [String]) {
        for sentence in sentences {
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
    }

    func predictNextToken(from token: [String]) -> String? {
        guard let nextTokens = transitions[token] else {
            return nil
        }
        return nextTokens.randomElement()
    }

    func makeSentence() -> String? {
        guard var state = startingTokens.randomElement() else {
            return nil
        }

        var sentence = state.joined(separator: " ")

        while true {
            guard let nextWord = predictNextToken(from: state) else {
                return sentence.isEmpty ? nil : sentence
            }

            sentence.append(contentsOf: " " + nextWord)

            state = state.dropFirst() + [nextWord]
        }

        return nil
    }
}
