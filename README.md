# CMUDict

A Swift package for retrieving word pronunciations from the [CMU Pronouncing Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict).

## Usage

You can either request a single, primary pronunciation for a word:

```swift
if let pronunciation = Pronunciation(word: "hello") {
    print(Array(pronunciation.syllables))
}
```

Or all the alternate pronunciations of a word:

```swift
for pronunciation in Pronunciation.pronunciations(for: "perfect") {
    // will be executed twice
}
```

## Author

Harlan Haskins ([harlan@harlanhaskins.com](mailto:harlan@harlanhaskins.com))
