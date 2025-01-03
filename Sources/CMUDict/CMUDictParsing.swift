//
//  CMUDictParsing.swift
//  Pronunciation
//
//  Created by Harlan Haskins on 1/3/25.
//

import Foundation

/// Parses a line in the form:
/// `word W ER1 D`
/// into a tuple of the word and its corresponding Pronunciation.
private func parseLine(_ line: String) -> (String, Pronunciation)? {
    guard let firstSpace = line.firstIndex(of: " ") else {
        return nil
    }
    var word = line[..<firstSpace]
    if let index = word.firstIndex(of: "(") {
        word = line[..<index]
    }
    let afterSpace = line.index(after: firstSpace)
    let rest = line[afterSpace...]
    var symbols = [Symbol]()
    for var symbol in rest.split(separator: " ") {
        if symbol.starts(with: "#") {
            break
        }
        if let index = symbol.firstIndex(of: "#") {
            symbol = symbol[..<index]
        }
        var stress = Stress.unstressed
        if let last = symbol.last {
            switch last {
            case "0", "1", "2":
                symbol.removeLast()
                stress = Stress(rawValue: last.wholeNumberValue!)!
            default:
                break
            }
        }
        guard let phoneme = Phoneme(rawValue: String(symbol)) else {
            print("unknown phoneme: \(symbol)")
            continue
        }
        symbols.append(Symbol(phoneme: phoneme, stress: stress))
    }
    return (String(word), Pronunciation(symbols: symbols))
}

/// Parses the entire CMUDict file in the module's bundle.
func parseCMUDict() throws -> [String: [Pronunciation]] {
    let file = Bundle.module.url(forResource: "cmudict", withExtension: "txt")!
    let contents = try Data(contentsOf: file, options: .mappedIfSafe)
    var pronunciations = [String: [Pronunciation]]()
    for line in contents.split(separator: 10) {
        let line = String(decoding: line, as: UTF8.self)
        guard let (word, pronunciation) = parseLine(line) else {
            print("failed to parse line: \(line)")
            continue
        }
        pronunciations[word, default: []].append(pronunciation)
    }
    return pronunciations
}
