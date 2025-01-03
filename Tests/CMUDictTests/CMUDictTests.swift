//
//  PronunciationTests.swift
//  Pronunciation
//
//  Created by Harlan Haskins on 1/3/25.
//

@testable import CMUDict
import Testing

@Test
func testPronunciations() throws {
    /// This test also make sure the pronunciation dictionary parses all the words and
    /// doesn't error.
    let pronunciation = try #require(Pronunciation(word: "syllable"))
    #expect(pronunciation.symbols == [
        Symbol(phoneme: .s),
        Symbol(phoneme: .ih, stress: .primary),
        Symbol(phoneme: .l),
        Symbol(phoneme: .ah),
        Symbol(phoneme: .b),
        Symbol(phoneme: .ah),
        Symbol(phoneme: .l)
    ])
    while true {}
}
