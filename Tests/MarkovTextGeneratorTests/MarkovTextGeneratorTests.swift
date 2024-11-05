import Testing

@testable import MarkovTextGenerator

@Test func buildTransitionsFromSentenceWithSingleSample() async throws {
    let sentence = [
        "A cat watched patiently",
        "My cat wanted some milk",
    ]

    let generator = TextGenerator(withSampleSizeOf: 1)
    generator.buildTransitions(fromSentences: sentence)

    let expectedTransitions = [
        ["a"]: ["cat"],
        ["watched"]: ["patiently"],
        ["cat"]: ["watched", "wanted"],
        ["my"]: ["cat"],
        ["some"]: ["milk"],
        ["wanted"]: ["some"],
    ]

    let expectedStartingTokens = [["a"], ["my"]]

    #expect(generator.transitions == expectedTransitions)
    #expect(generator.startingTokens == expectedStartingTokens)
}

@Test func buildTransitionsFromSentenceWithMultipleSamples() async throws {
    let sentence = [
        "A cat watched patiently",
        "My cat wanted some milk",
    ]

    let generator = TextGenerator(withSampleSizeOf: 2)
    generator.buildTransitions(fromSentences: sentence)

    let expectedStartingTokens = [["a", "cat"], ["my", "cat"]]

    for tokens in generator.transitions.keys {
        #expect(tokens.count == 2)
    }

    #expect(generator.startingTokens == expectedStartingTokens)
}

@Test func makeASentence() async throws {
    let sentences = [
        "The cat ran down some stairs",
        "A mouse sprinted to get away from the cat",
        "My cat wanted some milk",
        "A cat watched patiently",
    ]

    let generator = TextGenerator(withSampleSizeOf: 2)
    generator.buildTransitions(fromSentences: sentences)

    let sentence = generator.makeSentence()
    
    #expect(sentence != nil)
}
