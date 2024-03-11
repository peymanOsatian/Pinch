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
    @State private var isDrawerOpen : Bool = false
    
    
    
    
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
                Color.clear
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
                // MARK: -3.MAGNIFICATION
                    .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)){
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = value
                                } else if  imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                        .onEnded{ _ in
                            if imageScale > 5 {
                                imageScale = 5
                            } else if  imageScale <= 1{
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
            // MARK: -INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
                ,alignment : .top
            )
                
         // MARK: - CONTROLS
            .overlay(
                Group {
                    HStack{
                      // SCALE  DOWN
                        Button {
                            withAnimation(.spring()){
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale <= 1{
                                        resetImageSate()
                                    }
                                }
                            }
                        } label: {
                          ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // RESET
                        Button {
                          resetImageSate()
                        } label: {
                          ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // SCALE UP
                        Button {
                            withAnimation(.spring()){
                                if imageScale < 5 {
                                    imageScale += 1
                                    if imageScale > 5{
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                          ControlImageView(icon: "plus.magnifyingglass")
                        }
                        
                    }//: CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    
                }
                    .padding(.bottom, 30)
                , alignment: .bottom
            )
            // MARK: -DRAWER
            .overlay (
                HStack (spacing : 12){
                    // MARK: -DRAWER HANDLE
                    Image(systemName: isDrawerOpen ?  "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut){
                                isDrawerOpen.toggle()
                            }
                        })
                    
                    // MARK: -THUMBNAILS
                Spacer()
                } // : drawer
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width:260)
                    .padding(.top,UIScreen.main.bounds.height/12)
                    .offset(x: isDrawerOpen ? 20 : 215)
                , alignment:.topTrailing
                
                
            )
        }//: NAVIGATION
        .navigationViewStyle(.stack)
       
    }
}

#Preview {
    ContentView()
}
 
