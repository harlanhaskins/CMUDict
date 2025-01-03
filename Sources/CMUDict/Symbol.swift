import Foundation

/// A phoneme is the smallest unit of sound in the pronunciation of a word.
public enum Phoneme: String, CaseIterable, Sendable, Equatable, Hashable {
    /// The different kinds of phonemes that can be found in words.
    public enum Kind: String, CaseIterable, Sendable, Equatable, Hashable {
        case vowel, affricate, fricative, stop, aspirate, liquid, nasal, semivowel
    }
    
    case aa = "AA"
    case ae = "AE"
    case ah = "AH"
    case ao = "AO"
    case aw = "AW"
    case ay = "AY"
    case b = "B"
    case ch = "CH"
    case d = "D"
    case dh = "DH"
    case eh = "EH"
    case er = "ER"
    case ey = "EY"
    case f = "F"
    case g = "G"
    case hh = "HH"
    case ih = "IH"
    case iy = "IY"
    case jh = "JH"
    case k = "K"
    case l = "L"
    case m = "M"
    case n = "N"
    case ng = "NG"
    case ow = "OW"
    case oy = "OY"
    case p = "P"
    case r = "R"
    case s = "S"
    case sh = "SH"
    case t = "T"
    case th = "TH"
    case uh = "UH"
    case uw = "UW"
    case v = "V"
    case w = "W"
    case y = "Y"
    case z = "Z"
    case zh = "ZH"
    
    public var kind: Kind {
        switch self {
        case .aa, .ae, .ah, .ao, .aw, .ay, .eh, .er, .ey, .ow, .oy, .ih, .iy, .uh, .uw:
            .vowel
        case .b, .d, .g, .k, .p, .t:
            .stop
        case .ch, .dh, .f, .s, .sh, .th, .v, .z, .zh:
            .fricative
        case .hh:
            .aspirate
        case .jh:
            .affricate
        case .l, .r:
            .liquid
        case .m, .n, .ng:
            .nasal
        case .w, .y:
            .semivowel
        }
    }
}

/// The stress applied to the syllable (if it's a vowel). Non-vowels will always
/// be `unstressed`.
public enum Stress: Int, Sendable, Equatable, Hashable {
    case unstressed = 0
    case primary = 1
    case secondary = 2
}

/// A phoneme and its accompanying stress.
public struct Symbol: Sendable, Equatable, Hashable, CustomStringConvertible {
    public var phoneme: Phoneme
    public var stress: Stress
    
    public init(phoneme: Phoneme, stress: Stress = .unstressed) {
        self.phoneme = phoneme
        self.stress = stress
    }
    
    public var description: String {
        "\(phoneme.rawValue)\(phoneme.kind == .vowel ? "\(stress.rawValue)" : "")"
    }
}
