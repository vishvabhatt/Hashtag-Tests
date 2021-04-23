import UIKit

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

//var input = "#TaylorSwift#Swift The music industry BESTARTIST#GlobalStar"
//var input = "The 😀range of #hashtag🐶 should 👺 be 🇩🇪 #different#to this #hashtag🐮"
//var input = "#evermore#folklore#masterpiece"
//var input = " evermore#folklore#lover #reputation 1989 #red#fearless"
var input = "evermore#folklore#lover #reputation 1989 #red#fearless"
//var input = "#abc#de #fg"
let nsString = input as NSString
let regex = try NSRegularExpression(pattern: "#[a-z0-9]+", options: NSRegularExpression.Options.caseInsensitive)
let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.count)) as Array<NSTextCheckingResult>
let seperator = " "

for i in 0..<matches.count {
    let range = matches[i].range
    let matchString = nsString.substring(with: range) as String
    if let indexOf = input.index(of: matchString), input.distance(from: input.startIndex, to: indexOf) != 0 {
        let previousIndex = input.index(before: indexOf)
        if input[previousIndex] == " " {
            continue
        }
        input.insert(contentsOf: seperator, at: indexOf)
    }
}
print("Result: \(input)")
