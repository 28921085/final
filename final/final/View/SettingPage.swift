//
//  SettingPage.swift
//  final
//
//  Created by 1+ on 2022/6/30.
//

import SwiftUI

struct SettingPage: View {
    @Binding var language:String
    @Binding var viewController:Int
    var body: some View {
       
        VStack{
            Button{
                viewController = 3
                
            }label:{
                HStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.blue)
                        .frame(width: 70, height: 30, alignment: .center)
                        .overlay(
                            Text(language == "English" ? "back" : "返回")
                                .foregroundColor(Color.white)
                        )
                }
            }
            Text(language == "English" ? "Choose language" : "選擇語言")
            Picker(selection: $language, label: Text("")) {
                            Text("English").tag("English")
                            Text("繁體中文").tag("繁體中文")
                        }.pickerStyle(SegmentedPickerStyle())
                            .frame(width: 200)
        }
        
    }
}
//language == "English" ? "" : ""
/*
struct Page: View {
    @State private var language = "English"
    @State private var viewCountroller = 6
    var body: some View {
       
        SettingPage(language: $language, viewController: $viewCountroller)
        
    }
}


struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        Page()
    }
}

*/
