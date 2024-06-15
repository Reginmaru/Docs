//
//  FontStyle.swift
//  Docs
//
//  Created by Regin Maru on 05/05/2024.
//

import Foundation
import SwiftUI

func fontStyle() -> Item {
    let title: String = "Add Font Style to Text"
    
    let desc: AnyView = AnyView(
        ScrollView {
            VStack{
                Text("Download .ttf files from anywhere or create your own, and drop them into your project.")
                    .doc()
                Text("I like to create a group 'project_fonts' and put them in there.")
                    .doc()
                Text("In Swift directories don't really matter so when refering to external files don't write the file references from the base App directory.")
                    .doc()
                Text("Add files to build phase under 'Copy bundle Resources'")
                    .doc()
                Image("add_to_build_phase")
                    .doc()
                Text("Click on your project, click on info, right click on table and add row.")
                    .doc()
                Image("add_to_info")
                    .doc()
                Text("Click on 'Fonts provided by application', add fonts.")
                    .doc()
            }
        }
    )
    
    return Item(title: title, desc: desc)
}
