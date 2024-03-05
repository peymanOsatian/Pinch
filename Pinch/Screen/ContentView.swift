//
//  ContentView.swift
//  Pinch
//
//  Created by Peyman Osatian on 2024-03-03.
//

import SwiftUI

struct ContentView: View {
    // MARK: -PROPERTY
    //: in property animation ro dar halate khamosh ejad mikone
    @State private var isAnimating : Bool = false
    //
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset :CGSize = .zero
    
    
    
    
    // MARK: -FUNCTION
    func resetImageSate() {
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    // MARK: -CONTENT
    var body: some View {
        NavigationView{
            ZStack{
             // MARK: -PAGE IMAGE
                //: shows image (modify)
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2,y: 2)
                // taghir opacity animation az halate false be true 
                    .opacity(isAnimating ? 1 :0 )
                    .offset(x:imageOffset.width, y:imageOffset.height)
                    .scaleEffect(imageScale)
                // MARK: -1. TAP GESTURE
                // in code baes mishe ba double click ro ax zoom beshe
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }else {
                           resetImageSate()
                        }
                    })
                // MARK: 2.-DARG GESTURE
                    .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.linear(duration: 1)){
                                imageOffset = value.translation
                            }
                        }
                        .onEnded{ _ in
                            if imageScale <= 1 {
                               resetImageSate()
                                
                            }
                        }
                    )
            }//:ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            //: ejraye animation khamosh roshan
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            })
            //: end animation
        }//: NAVIGATION
        .navigationViewStyle(.stack)
       
    }
}

#Preview {
    ContentView()
}
 
