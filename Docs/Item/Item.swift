//
//  Item.swift
//  Docs
//
//  Created by Regin Maru on 04/05/2024.
//

import Foundation
import SwiftUI
final class Item: Identifiable {
    var title: String
    var desc: AnyView
    
    init(title: String, desc: AnyView) {
        self.title = title
        self.desc = desc
    }
}
