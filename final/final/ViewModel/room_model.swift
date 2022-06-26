//
//  room_model.swift
//  final
//
//  Created by 1+ on 2022/6/25.
//

import SwiftUI

struct playerInfo: View {
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    @Binding var type:Int // 0 = killer else = human
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
                            Text("replace by user photo")
                            Text("name")
                            Text(type == 0 ?
                                 "X kill"
                                 : "X win")
                            Text("ready")
                                .foregroundColor(Color.white)
                        }
                    )
            )
    }
}

struct prev1: View{
    @State private var type:Int = 1
    var body: some View{
        playerInfo(type: $type)
    }
}
struct room_model_Previews: PreviewProvider {
    static var previews: some View {
        prev1()
    }
}
