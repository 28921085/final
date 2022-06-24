//
//  waitingRoomPage.swift
//  final
//
//  Created by 1+ on 2022/6/19.
//

import SwiftUI

struct waitingRoomPage: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    @State private var ready=[0,0,0,0]
    var body: some View {
        ZStack{
            Image("fog")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button{
                        //viewController=3
                    }label:{
                        HStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                                .frame(width: 70, height: 30, alignment: .center)
                                .overlay(
                                    Text("back")
                                        .foregroundColor(Color.white)
                                )
                        }
                    }
                }
                HStack{
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color.init(red: 0.7, green: 0.1, blue: 0.1))
                        .frame(width: screenWidth/2.1, height: screenHeight/2.25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.init(red: 1, green: 0, blue: 0))
                                    .frame(width: screenWidth/2.3, height: screenHeight/2.35)
                                .overlay(
                                    VStack{
                                        Text("replace by user photo")
                                        Text("name")
                                        Text("X kill")
                                        Button{
                                            ready[0] ^= 1
                                        }label:{
                                            Text("ready")
                                                .foregroundColor(ready[0] == 1 ? Color.green : Color.white)
                                        }
                                    }
                                )
                        )
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color.init(red: 0.1, green: 0.1, blue: 0.7))
                        .frame(width: screenWidth/2.1, height: screenHeight/2.25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.init(red: 0, green: 0, blue: 1))
                                    .frame(width: screenWidth/2.3, height: screenHeight/2.35)
                                .overlay(
                                    VStack{
                                        Text("replace by user photo")
                                        Text("name")
                                        Text("X win")
                                        Button{
                                            ready[1] ^= 1
                                        }label:{
                                            Text("ready")
                                                .foregroundColor(ready[1] == 1 ? Color.green : Color.white)
                                        }
                                    }
                                )
                        )
                }
                HStack{
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color.init(red: 0.1, green: 0.1, blue: 0.7))
                        .frame(width: screenWidth/2.1, height: screenHeight/2.25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.init(red: 0, green: 0, blue: 1))
                                    .frame(width: screenWidth/2.3, height: screenHeight/2.35)
                                .overlay(
                                    VStack{
                                        Text("replace by user photo")
                                        Text("name")
                                        Text("X win")
                                        Button{
                                            ready[2] ^= 1
                                        }label:{
                                            Text("ready")
                                                .foregroundColor(ready[2] == 1 ? Color.green : Color.white)
                                        }
                                    }
                                )
                        )
                    RoundedRectangle(cornerRadius: 7)
                        .fill(Color.init(red: 0.1, green: 0.1, blue: 0.7))
                        .frame(width: screenWidth/2.1, height: screenHeight/2.25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.init(red: 0, green: 0, blue: 1))
                                    .frame(width: screenWidth/2.3, height: screenHeight/2.35)
                                .overlay(
                                    VStack{
                                        Text("replace by user photo")
                                        Text("name")
                                        Text("X win")
                                        Button{
                                            ready[3] ^= 1
                                        }label:{
                                            Text("ready")
                                                .foregroundColor(ready[3] == 1 ? Color.green : Color.white)
                                        }
                                    }
                                )
                        )
                }
            }
        }
    }
}

struct waitingRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        waitingRoomPage()
    }
}
