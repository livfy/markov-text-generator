import Testing

@testable import MarkovTextGenerator

@Test func buildTransitionsFromSentence() async throws {
    let sentence = [
        "A cat watched patiently",
        "My cat wanted some milk",
    ]

    let generator = TextGenerator()
    generator.buildTransitions(fromSentences: sentence)

    let expectedTransitions = [
        "a": ["cat"],
        "watched": ["patiently"],
        "cat": ["watched", "wanted"],
        "my": ["cat"],
        "some": ["milk"],
        "wanted": ["some"],
    ]

    let expectedStartingTokens = ["a", "my"]

    #expect(generator.transitions == expectedTransitions)
    #expect(generator.startingTokens == expectedStartingTokens)
}

@Test func nextWord() async throws {
    let sentences = [
        "The cat ran down some stairs",
        "A mouse sprinted to get away from the cat",
    ]

    let generator = TextGenerator()
    generator.buildTransitions(fromSentences: sentences)
    let predictedWord = generator.predictNextToken(from: "mouse")
    #expect(predictedWord == "sprinted")
}

@Test func makeSentence() async throws {
    let sentences = [
        "The cat ran down some stairs",
        "A mouse sprinted to get away from the cat",
        "My cat wanted some milk",
        "A cat watched patiently",
    ]

    let generator = TextGenerator()

    generator.buildTransitions(fromSentences: sentences)

    let sentence = generator.makeSentence()
    
    print(sentence!)
    #expect(sentence != nil)
}
