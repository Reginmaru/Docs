//
//  ContentView.swift
//  Docs
//
//  Created by Regin Maru on 04/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var items: [Item] = addItems()
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    ItemView(item: item)
                }
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("Reginmaru's Docs")
                        .docBoldTitle()
                }
            }
        } detail: {
            Text("Docs")
                .doc()
        }
    }
}

#Preview {
    ContentView()
}
