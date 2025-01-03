//
//  Pronunciation 2.swift
//  CMUDict
//
//  Created by Harlan Haskins on 1/3/25.
//

/// A structure representing the pronunciation of a given word, expressed as a sequence
/// of `Symbol`s.
/// These `Symbols` can be interpreted as a sequence of `Syllables` using the `syllables`
/// accessor.
public struct Pronunciation: Sendable, Equatable, Hashable {
    static let cmuDict = try! parseCMUDict()
    
    /// The symbols that make up the pronunciation of this word.
    public var symbols: [Symbol]
    
    /// Retrieves a list of all the pronunciations of a given word. Most have one or two
    /// possible pronunciations.
    public static func pronunciations(for word: some StringProtocol) -> [Pronunciation] {
        Self.cmuDict[word.lowercased()] ?? []
    }
    
    /// Retrieves the specific pronunciation of a given word, optionally choosing an alternate
    /// pronunciation if requested.
    public init?(word: String, alternate: Int? = nil) {
        guard let pronunciations = Self.cmuDict[word] else {
            return nil
        }
        let index = alternate ?? 0
        guard index < pronunciations.endIndex else {
            return nil
        }
        self = pronunciations[index]
    }
    
    /// Creates a `Pronunciation` with an array of `Symbol`s. Only use this if you are
    /// constructing a `Pronunciation` dynamically for a word that is not in the dictionary.
    public init(symbols: [Symbol]) {
        self.symbols = symbols
    }
    
    /// Interprets the symbols in the word by breaking on rough syllable boundaries (that is,
    /// breaking on vowel boundaries).
    public var syllables: some Sequence<Syllable> {
        SyllableSequence(symbols: symbols)
    }
}
