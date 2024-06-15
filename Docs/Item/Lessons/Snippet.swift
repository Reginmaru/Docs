//
//  Snippet.swift
//  Docs
//
//  Created by Regin Maru on 14/05/2024.
//

import Foundation
import SwiftUI
struct SnippetView: View {
    let content: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            colorIn().background(Color(uiColor: .systemGray6))
        }.onTapGesture {
            UIPasteboard.general.string = content
            // Trigger haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred(intensity: 200)
        }
    }
    
    func colorIn() -> some View {
        let view: AnyView = AnyView(
            ScrollView(.horizontal) {
                VStack(alignment: .leading) { // Aligned to leading for a paragraph-like layout
                    ForEach(content.components(separatedBy: "\n"), id: \.self) { line in
                        self.renderLine(line)
                    }
                }.padding()
            }
            
        )
        return view
    }
    
    private func renderLine(_ line: String) -> some View {
        HStack(spacing: 0) { // Adjusted spacing between words
            let words = splitStringWithSpaces(line)
                .filter { !$0.isEmpty }
                .map { renderWord($0) }
                .reduce(Text("")) { (result, next) in
                    return result + next
                }
            
            words
        }
    }
    
    private func renderWord(_ word: String) -> Text {
        return Text(word)
            .foregroundColor(self.calcWordColor(word))
            .font(Font.custom("SpaceMono-Regular", size: 12))
    }
    
    private func calcWordColor(_ word: String) -> Color {
        switch word {
        case let word where swiftKeywords.contains(word):
            // funcs
            return Color(uiColor: .systemPink)
        case let word where word.first?.isUppercase ?? false:
            // Capitalized words
            return Color(uiColor: .systemTeal)
        case let x where specialSymbols.contains { x.contains($0) }:
            return Color(uiColor: .systemOrange)
        default:
            // Normal text
            return colorScheme == .dark ? .white : .black
        }
    }
    let specialSymbols = ["(", ")", ".", "{", "}", "()", "{}"]
    let swiftKeywords: [String] = [
        "let", "var",
        "class", "struct", "enum", "protocol", "extension", "typealias",
        "if", "else", "switch", "case", "default", "fallthrough", "for", "while", "repeat", "in", "guard", "defer",
        "func", "throws", "throw", "try", "try?", "try!", "return",
        "private", "fileprivate", "internal", "public", "open", "static", "class",
        "weak", "unowned", "mutating",
        "nil", "Optional", "Optional?", "Optional!",
        "in", "return",
        "do", "try", "catch", "throw",
        "as", "is",
        "Any", "AnyObject", "Self",
        "true", "false",
        "import", "type", "super", "self", "@discardableResult", "#selector", "@escaping", "@autoclosure"
    ]
    
}

func Snippet() -> Item {
    
    let title: String = "Code Snippets"
    
    let desc: AnyView = AnyView(
        ScrollView {
            VStack {
                Text("Create the Snippet View passing in whatever string to want to parse.")
                    .doc()
                Text("Check for \\ in the code string, you need to add another so it says string.")
                    .doc()
                Text("Added a copy to clipboard as well.")
                    .doc()
                SnippetView(content: SnippetCode.snippetView)
                Text("We need to split the code vertically first and add a horizontal scroll to fit the page.")
                    .doc()
                SnippetView(content: SnippetCode.colorIn)
                Text("Pass in each line to regexed.")
                    .doc()
                SnippetView(content: SnippetCode.renderLine)
                Text("Here is the regex I used. It is important to note that the reason I didn't use the string splitter on ' ' was before then it will erase the space from the string.")
                    .doc()
                SnippetView(content: SnippetCode.regex)
                Text("Create the view for each word in the code.")
                    .doc()
                SnippetView(content: SnippetCode.renderWord)
                Text("Here is the logic behind the coloring in.")
                    .doc()
                SnippetView(content: SnippetCode.calc)
                
            }
        }
    )
    
    return Item(title: title, desc: desc)
}

func splitStringWithSpaces(_ input: String) -> [String] {
    // Regular expression to split by spaces while keeping the spaces
    let pattern = #"[()\[\]{}\s.]+"#
    let regex = try! NSRegularExpression(pattern: pattern)
    
    let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
    var result: [String] = []
    
    var currentIndex = input.startIndex
    for match in matches {
        if let range = Range(match.range, in: input) {
            // Add the space(s) before the match
            let spacesBefore = String(input[currentIndex..<range.lowerBound])
            if !spacesBefore.isEmpty {
                result.append(spacesBefore)
            }
            // Add the matched substring
            let matchedSubstring = String(input[range])
            result.append(matchedSubstring)
            currentIndex = range.upperBound
        }
    }
    
    // Add any remaining characters after the last match
    if currentIndex < input.endIndex {
        let remainingSubstring = String(input[currentIndex...])
        result.append(remainingSubstring)
    }
    
    return result
}

#Preview {
    Snippet().desc
}

class SnippetCode {
    static let snippetView: String = """
    struct SnippetView: View {
        let content: String
        @Environment(\\.colorScheme) var colorScheme
        var body: some View {
            VStack {
                colorIn().background(Color(uiColor: .systemGray6))
            }.onTapGesture {
                UIPasteboard.general.string = content
            }
        }
        
        // Rest of the code
    """
    
    static let colorIn: String = """
    func colorIn() -> some View {
        let view: AnyView = AnyView(
            ScrollView(.horizontal) {
                VStack(alignment: .leading) { // Aligned to leading for a paragraph-like layout
                    ForEach(content.components(separatedBy: "\\n"), id: \\.self) { line in
                        self.renderLine(line)
                    }
                }.padding()
            }
            
        )
        return view
    }
    """
    
    static let renderLine: String = """
    private func renderLine(_ line: String) -> some View {
        HStack(spacing: 0) { // Adjusted spacing between words
            let words = splitStringWithSpaces(line)
                .filter { !$0.isEmpty }
                .map { renderWord($0) }
                .reduce(Text("")) { (result, next) in
                    return result + next
                }
            
            words
        }
    }
    """
    
    static let renderWord: String = """
    private func renderWord(_ word: String) -> Text {
        return Text(word)
            .foregroundColor(self.calcWordColor(word))
            .font(Font.custom("Silkscreen-Regular", size: 12))
    }
    """
    
    static let calc: String = """
    private func calcWordColor(_ word: String) -> Color {
        switch word {
        case let word where swiftKeywords.contains(word):
            // funcs
            return Color(uiColor: .systemPink)
        case let word where word.first?.isUppercase ?? false:
            // Capitalized words
            return Color(uiColor: .systemTeal)
        case let x where specialSymbols.contains { x.contains($0) }:
            return Color(uiColor: .systemOrange)
        default:
            // Normal text
            return Color(uiColor: .systemGray6)
        }
    }
    let specialSymbols = ["(", ")", ".", "{", "}", "()", "{}"]
    let swiftKeywords: [String] = [
        "let", "var",
        "class", "struct", "enum", "protocol", "extension", "typealias",
        "if", "else", "switch", "case", "default", "fallthrough", "for", "while", "repeat", "in", "guard", "defer",
        "func", "throws", "throw", "try", "try?", "try!", "return",
        "private", "fileprivate", "internal", "public", "open", "static", "class",
        "weak", "unowned", "mutating",
        "nil", "Optional", "Optional?", "Optional!",
        "in", "return",
        "do", "try", "catch", "throw",
        "as", "is",
        "Any", "AnyObject", "Self",
        "true", "false",
        "import", "type", "super", "self", "@discardableResult", "#selector", "@escaping", "@autoclosure"
    ]
    """
    
    static let regex: String = """
    func splitStringWithSpaces(_ input: String) -> [String] {
        // Regular expression to split by spaces while keeping the spaces
        let pattern = #"[()\\[\\]{}\\s.]+"#
        let regex = try! NSRegularExpression(pattern: pattern)
        
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        var result: [String] = []
        
        var currentIndex = input.startIndex
        for match in matches {
            if let range = Range(match.range, in: input) {
                // Add the space(s) before the match
                let spacesBefore = String(input[currentIndex..<range.lowerBound])
                if !spacesBefore.isEmpty {
                    result.append(spacesBefore)
                }
                // Add the matched substring
                let matchedSubstring = String(input[range])
                result.append(matchedSubstring)
                currentIndex = range.upperBound
            }
        }
        
        // Add any remaining characters after the last match
        if currentIndex < input.endIndex {
            let remainingSubstring = String(input[currentIndex...])
            result.append(remainingSubstring)
        }
        
        return result
    }
    """
}
