//
//  BulletPoints.swift
//  Docs
//
//  Created by Regin Maru on 05/05/2024.
//

import Foundation
import SwiftUI

struct BulletList: View {
    let items: [String]

    var body: some View {
        ForEach(items, id: \.self) { item in
            HStack(alignment: .top, spacing: 5) {
                Image("bullet_list_point")
                    .docBullet()
                Text(item)
                    .doc()
            }
        }
    }
}
