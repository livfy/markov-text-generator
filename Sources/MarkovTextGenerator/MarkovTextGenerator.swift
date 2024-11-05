typealias transitionMatrix = [String: [String]]

class TextGenerator {
    var transitions: transitionMatrix = [:]
    var startingTokens: [String] = []

    /// Build transitions from sentence usually seperated as words
    /// Use this to avoid storing whole text source in memeory
    /// - Parameter sentences: List of sentences:
    func buildTransitions(fromSentences sentences: [String]) {
        for sentence in sentences {
            let tokens = sentence.split(separator: " ").map {
                $0.lowercased()
            }

            for (index, token) in tokens.dropLast().enumerated() {
                // Collect starting tokens
                if index == 0 {
                    startingTokens.append(token)
                }

                let nextToken = tokens[index + 1]
                transitions[token, default: []].append(nextToken)
            }
        }
    }

    func predictNextToken(from token: String) -> String? {
        let nextTokens = transitions[token]
        return nextTokens?.randomElement()
    }

    func makeSentence() -> String? {
        guard var state = startingTokens.randomElement() else {
            return nil
        }

        var sentence = ""

        while true {
            guard let nextWord = predictNextToken(from: state) else {
                return sentence.isEmpty ? nil : sentence
            }

            if nextWord == "." {
                sentence.append(nextWord)
            } else {
                sentence.append(contentsOf: " " + nextWord)
            }

            state = nextWord
        }
    }
}
