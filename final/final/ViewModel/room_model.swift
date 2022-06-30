//
//  room_model.swift
//  final
//
//  Created by 1+ on 2022/6/25.
//

import SwiftUI
import FirebaseFirestoreSwift

struct playerInfo: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    @Binding var type:Int // 0 = killer else = human
    @Binding var ready:Bool
    @Binding var name:String
    @Binding var photoURL:String
    @Binding var language:String
    var body: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(type == 0 ?
                  Color.init(red: 0.7, green: 0.1, blue: 0.1)
                  : Color.init(red: 0.1, green: 0.1, blue: 0.7))
            .frame(width: screenWidth/2.1, height: screenHeight/2.35)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .fill(type == 0 ?
                          Color.init(red: 1, green: 0, blue: 0)
                          : Color.init(red: 0, green: 0.1, blue: 1))
                        .frame(width: screenWidth/2.3, height: screenHeight/2.5)
                    .overlay(
                        VStack{
                            AsyncImage(url: URL(string: photoURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: 100, height: 150)
                            .cornerRadius(20)
                            Text(name == "" ? (language == "English" ? "empty" : "空") : name)
                                .foregroundColor(name == "" ? Color.white : Color.yellow)
                            Spacer()
                            Text(language == "English" ? "ready" : "準備")
                                .foregroundColor(ready ? Color.green : Color.white)
                        }
                    )
            )
    }
}
/*
struct prev1: View{
    @State private var type:Int = 1
    @State private var t=true
    @State private var name="123456"
    @State private var url="https://firebasestorage.googleapis.com:443/v0/b/final-4fc3a.appspot.com/o/69ED3EF7-ACC6-4A7F-AF74-2E06525629C8.jpg?alt=media&token=cdc64b68-7353-4acb-a24e-1a28a0a0a514"
    @State private var url2=""
    var body: some View{
        playerInfo(type: $type,ready: $t,name:$name,photoURL: $url)
    }
}
struct room_model_Previews: PreviewProvider {
    static var previews: some View {
        prev1()
    }
}
*/
