//
//  SyllableSequence.swift
//  CMUDict
//
//  Created by Harlan Haskins on 1/3/25.
//

/// Represents a spoken syllable of a word.
public struct Syllable {
    /// The symbols that make up this syllable, almost always containing one vowel.
    public var symbols: [Symbol]
    
    /// The stress associated with this syllable's vowel.
    public var stress: Stress {
        symbols.first { $0.phoneme.kind == .vowel }?.stress ?? .unstressed
    }
}

/// Iterates over "syllables" in the pronunciation. This is not perfect, but it's a good
/// approximation of the breakup of a word by splitting on vowel boundaries.
struct SyllableSequence: Sequence {
    var symbols: [Symbol]
    struct Iterator: IteratorProtocol {
        var symbols: [Symbol]
        var index: Int = 0
        let lastVowelIndex: Int?
        
        init(symbols: [Symbol]) {
            self.symbols = symbols
            lastVowelIndex = symbols.lastIndex {
                $0.phoneme.kind == .vowel
            }!
        }
        
        mutating func next() -> Syllable? {
            if symbols.isEmpty || index >= symbols.endIndex {
                return nil
            }
            guard let lastVowelIndex else {
                index = symbols.endIndex
                return Syllable(symbols: symbols)
            }
            
            var syllableSymbols = [Symbol]()
            while index <= lastVowelIndex {
                let symbol = symbols[index]
                syllableSymbols.append(symbol)
                index += 1
                if symbol.phoneme.kind == .vowel {
                    break
                }
            }
            if index > lastVowelIndex {
                syllableSymbols.append(contentsOf: symbols[index...])
                index = symbols.endIndex
            }
            return Syllable(symbols: syllableSymbols)
        }
    }
    func makeIterator() -> Iterator {
        Iterator(symbols: symbols)
    }
}
