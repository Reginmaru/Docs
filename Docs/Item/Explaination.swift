//
//  Explaination.swift
//  Docs
//
//  Created by Regin Maru on 05/05/2024.
//

import Foundation
import SwiftUI

struct explaination: View {
    @State var item: Item
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    item.desc
                }.frame(maxWidth:.infinity)
            }
        }
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

