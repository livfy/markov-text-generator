let START = "START"

typealias transitionMatrix = [String: [String]]

class TextGenerator {
    var transitions: transitionMatrix = [:]

    init(fromTextSource textSource: String) {
        let tokenizedText = textSource.split(separator: "\n").map {
            $0.split(separator: " ").map {
                String($0).lowercased()
            }
        }

        for sentence in tokenizedText {
            let markedSentence = [START] + sentence
            for index in 0..<sentence.count {
                let state = markedSentence[index]
                let next = markedSentence[index + 1]

                transitions[state, default: []].append(next)
            }
        }
    }

    func predictNextWord(fromWord word: String) -> String? {
        let nextStates = transitions[word]
        return nextStates?.randomElement()
    }

    func makeSentence() -> String? {
        var state = START
        var sentence = ""

        while true {
            guard let nextWord = predictNextWord(fromWord: state) else {
                return sentence.isEmpty ? nil : sentence
            }

            sentence.append(contentsOf: " " + nextWord)
            state = nextWord
        }
    }
}
