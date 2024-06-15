//
//  ItemList.swift
//  Docs
//
//  Created by Regin Maru on 05/05/2024.
//

import Foundation

func addItems() -> [Item] {
    var items: [Item] = []
    items.append(scroll())
    items.append(fontStyle())
    items.append(CustomNavBack())
    items.append(Spotify())
    items.append(Notification())
    items.append(Snippet())
    return items
}
