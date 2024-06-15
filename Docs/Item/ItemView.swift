//
//  ItemView.swift
//  Docs
//
//  Created by Regin Maru on 05/05/2024.
//

import Foundation
import SwiftUI

struct ItemView: View {
    @State var item: Item
    
    var body: some View {
        NavigationLink(destination: explaination(item: item)) {
            eTitle(item: item)
        }
    }
}

@ViewBuilder
func eTitle(item: Item) -> some View {
    Text(item.title)
        .docBold()
}

