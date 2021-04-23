import UIKit

var hashTagString = "#TaylorSwift#Swift The music industry BESTARTIST#GlobalStarmega11"

let tagNameArray = hashTagString.components(separatedBy: " ")
var challengeTagArray = [String]()
for tag in tagNameArray {
    if tag.hasPrefix("#") {
        if (tag.replacingOccurrences(of: "#", with: "").count>1) {
            challengeTagArray.append(tag.replacingOccurrences(of: "#", with: ""))
        }
    }
}

if let regex = try? NSRegularExpression(pattern: "#[a-z0-9]+", options: .caseInsensitive)
{
    let string = hashTagString as NSString
    let hashTagArray : [String] = regex.matches(in: hashTagString, options: [], range: NSRange(location: 0, length: string.length)).map {
        string.substring(with: $0.range).replacingOccurrences(of: "#", with: "")}
    print("all hash tags in string \(hashTagArray)")

}
extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension String {
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        return Range(nsRange, in: self)
    }
}


var input = "#TaylorSwift#Swift The music industry BESTARTIST#GlobalStar"// the input string where we will find for the pattern
let nsString = input as NSString

let regex = try NSRegularExpression(pattern: "#[a-z0-9]+", options: NSRegularExpression.Options.caseInsensitive)
//matches will store the all range objects in form of NSTextCheckingResult
let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.count)) as Array<NSTextCheckingResult>
var seperator = " "
var hashTagArray = [(String,NSRange)]()
var newString = ""

var hashResultArray : [String] = []

for match in matches {
    let range = match.range
    let matchString = nsString.substring(with: match.range) as String
    hashTagArray.append((matchString,range))
    newString = nsString.replacingOccurrences(of: matchString, with: matchString + seperator , options: NSString.CompareOptions.caseInsensitive, range: range)
    print("Replace in Loop result: \(newString)")

}

for i in 0..<matches.count {
    if i == 0 {continue}
    let range = matches[i].range
    let matchString = nsString.substring(with: range) as String
    if let indexOf = input.index(of: matchString) {
        input.insert(contentsOf: seperator, at: indexOf)
    }
}
print("Replace result: \(input)")

for i in 0..<hashTagArray.count {
    if i == 0 {
        continue
    }
    if let indexOF = input.index(of: hashTagArray[i].0) {
        let beforeIndex = input.index(before: indexOF)
        let replaceString : String = " "
        input.insert(contentsOf: replaceString, at: indexOF)
        print("newString index \(indexOF) and string \(input[beforeIndex])")
    }
}


let text = "The 😀range of #hashtag🐶 should 👺 be 🇩🇪 #different#to this #hashtag🐮"

for textCharacters in text {
    print("textCharacters \(textCharacters)")
    if textCharacters == "#" {
        
    }
}

let nsText = text as NSString
let regexEmoji = try NSRegularExpression(pattern: "#[^[:punct:][:space:]]+", options: [])
for match in regexEmoji.matches(in: text, options: [], range: NSRange(location: 0, length: nsText.length)) {
    print(match.range)
    print(nsText.substring(with: match.range))
}
extension String {
    public func separate(withChar char : String) -> [String]{
    var word : String = ""
    var words : [String] = [String]()
    for chararacter in self {
        if String(chararacter) == char && word != "" {
            words.append(word)
            word = char
        }else {
            word += String(chararacter)
        }
    }
    words.append(word)
    return words
}

}
func resolveHashTags(text : String) -> NSAttributedString{
    var length : Int = 0
    let text:String = text
    let words:[String] = text.separate(withChar: " ")
    let hashtagWords = words.flatMap({$0.separate(withChar: "#")})
    let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)]
    let attrString = NSMutableAttributedString(string: text, attributes:attrs)
    for word in hashtagWords {
        if word.hasPrefix("#") {
                let matchRange:NSRange = NSMakeRange(length, word.count)
                let stringifiedWord:String = word

            attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
        }
        length += word.count
    }
    return attrString
}
print("resolveHashTags \(resolveHashTags(text: text))")

