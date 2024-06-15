//
//  CustomNavItems.swift
//  Docs
//
//  Created by Regin Maru on 05/05/2024.
//

import Foundation
import SwiftUI

func CustomNavBack() -> Item {
    let title: String = "Custom Nav Back"
    
    let desc: AnyView = AnyView (
        ScrollView{
            VStack {
                Text("Select a parent View which will be your Starting point in your link.")
                    .doc()
                Text("Create a NavigationLink(destination: \" destination \"){'label'}")
                    .doc()
                SnippetView(content: CustomNavBackCode.nav_link)
                Text("Create a View (destination).")
                    .doc()
                SnippetView(content: CustomNavBackCode.explain)
                Text("In this View there are several key points:")
                    .doc()
                BulletList(items: ["The presentationMode - This is the environment state at the point you go to the link you have created.", "BackButtonHidden - disables back button.", "BarItems - adds your custom one.", "dismiss() - action to send you back to starting point."])
                Text("The rest of the code is arbitrary.")
                    .doc()
            }
        }
        
    )
    
    return Item(title: title, desc: desc)
}

class CustomNavBackCode {
    static let nav_link: String = """
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
    """
    static let explain: String = """
    import Foundation
    import SwiftUI

    struct explaination: View {
        @State var item: Item
        @Environment(\\.presentationMode) var presentationMode: Binding<PresentationMode>
        var body: some View {
            VStack{
                ScrollView{
                    VStack{
                        item.desc
                    }.frame(maxWidth:.infinity)
                }
            }
            // This is added to create a custom navbar.
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
            .gesture(swipeToDismissGesture)
        }
        
        var swipeToDismissGesture: some Gesture {
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width > 50 { // Adjust threshold as needed
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
        }
        
        var btnBack: some View {
            HStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image("back_btn")
                            .resizable()
                            .frame(width:24, height:24)
                    }
                }
                Text(item.title)
                    .docBoldTitle2()
            }
        }
    }
    """
}
