//
//  userProfilePage.swift
//  final
//
//  Created by 1+ on 2022/6/1.
//

import SwiftUI

struct userProfilePage: View {
    @Binding var viewController:Int
    @Binding var userMail:String
    @State private var nickname:String=""
    @State private var genderIndex:Int=0
    @State private var birthday = Date()
    var dateFormatter = DateFormatter()
    let genderSelect=["男生","女生"]
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                Button{
                    viewController=3
                }label:{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: 70, height: 30, alignment: .center)
                            .overlay(
                                Text("上一頁")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
                .onAppear(perform: {
                    dateFormatter.dateFormat = "y-MM-dd"
                })
                List {
                    HStack{
                        Text("👤")
                        TextField("Enter your nickname", text: $nickname)
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("性別")
                        Spacer()
                        Picker(selection: $genderIndex, label: Text("性別")) {
                            Text(genderSelect[0]).tag(0)
                            Text(genderSelect[1]).tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                            .frame(width: 100)
                    }
                    HStack{
                        Text("生日")
                        Spacer()
                        Text(dateFormatter.string(from: birthday))
                    }
                    DatePicker("生日", selection: $birthday, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Button {
                        
                    } label: {
                        Label("add phone", systemImage:
                            "plus.circle.fill")
                    }
                }
            }
        }
        /*
         
         
         */
        
    }
}
/*
struct userProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        userProfilePage()
    }
}
 */
