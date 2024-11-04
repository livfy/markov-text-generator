let START = "START"
let END = "END"

typealias markovChain = [String: [String]]

func buildMarkovChain(from textSource: String) -> markovChain {
    var chain: markovChain = [:]
    let tokenizedText = textSource.lowercased().split(separator: "\n").map {
        $0.split(separator: " ").map {
            String($0)
        }
    }

    for sentence in tokenizedText {
        let markedSentence = [START] + sentence + [END]
        for index in 0...sentence.count {
            let state = markedSentence[index]
            let next = markedSentence[index + 1]

            chain[state, default: []].append(next)
        }
    }

    return chain
}

class TextGenerator {
    let chain: markovChain

    init(fromTextSource textSource: String) {
        chain = buildMarkovChain(from: textSource)
    }

    func predictNextWord(fromWord word: String) -> String? {
        let nextStates = chain[word]
        return nextStates?.randomElement()
    }
}
