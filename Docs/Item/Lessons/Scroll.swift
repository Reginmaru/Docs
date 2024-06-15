//
//  Scroll.swift
//  Docs
//
//  Created by Regin Maru on 04/05/2024.
//

import Foundation
import SwiftUI

func scroll() -> Item {
    let title: String = "Create a Scroll"
    
    let desc: AnyView = AnyView(
        ScrollView {
            VStack{
                Text("Wrap your Views in a ScrollView like such.")
                    .doc()
                Text("\n.doc() standardises the Text Style.")
                    .doc()
                SnippetView(content:ScrollCode.code)
                Text("Feel free to swipe up and down! How exciting!")
                    .doc()
            }
        }
    )
    
    return Item(title: title, desc: desc)
}

class ScrollCode {
    static let code: String = """
    ScrollView {
        VStack{
            Text("Wrap your Views in a ScrollView like such.")
                .doc()
            Text("\\n.doc() standardises the Text Style.")
                .doc()
            SnippetView(content:ScrollCode.code)
            Image("scroll")
                .doc()
            Text("Feel free to swipe up and down! How exciting!")
                .doc()
        }
    }
    """
}
