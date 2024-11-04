import Testing

@testable import MarkovTextGenerator

@Test func nextWord() async throws {
    let text = """
        The cat ran down some stairs.
        A mouse sprinted to get away from the cat.
        My cat wanted some milk.
        A cat watched patiently.
        """

    let generator = TextGenerator(fromTextSource: text)
    let predictedWord = generator.predictNextWord(fromWord: "mouse")
    #expect(predictedWord == "sprinted")
}
