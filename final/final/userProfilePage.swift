//
//  userProfilePage.swift
//  final
//
//  Created by 1+ on 2022/6/1.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
struct userProfilePage: View {
    @Binding var viewController:Int
    @Binding var userMail:String
    @State private var nickname:String=""
    @State private var gender:String=""
    @State private var country:String="123"
    @State private var birthday = Date()
    @State private var screenWidth:CGFloat=UIScreen.main.bounds.width
    @State private var screenHeight:CGFloat=UIScreen.main.bounds.height
    var dateFormatter = DateFormatter()
    let genderSelect=["男生","女生"]
    let countrySelect=["台灣","美國","西台灣","苗栗國","天龍國"]
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                List {
                    
                        
                    
                    HStack{
                        Text("👤")
                        TextField("Enter your nickname", text: $nickname)
                            .autocapitalization(.none)
                    }
                    HStack{
                        Text("性別: \(gender)")
                        Spacer()
                        Picker(selection: $gender, label: Text("")) {
                            Text("男生").tag("男生")
                            Text("女生").tag("女生")
                        }.pickerStyle(SegmentedPickerStyle())
                            .frame(width: 120)
                    }
                    HStack{
                        Text("國家:")
                        Spacer()
                        Picker(selection: $country, label: Text("")) {
                            Text("台灣").tag("台灣")
                                .frame(width:screenWidth)
                            Text("美國").tag("美國")
                                .frame(width:screenWidth)
                            Text("西台灣").tag("西台灣")
                                .frame(width:screenWidth)
                            Text("苗栗國").tag("苗栗國")
                                .frame(width:screenWidth)
                            Text("天龍國").tag("天龍國")
                                .frame(width:screenWidth)
                            
                            
                        }
                    }
                    HStack{
                        Text("生日:")
                        Spacer()
                        Text(dateFormatter.string(from: birthday))
                    }
                    DatePicker("", selection: $birthday, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                }
            }.frame(width: screenWidth)
                .navigationTitle("  使用者資料設定")
                .navigationBarItems(leading:
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
                , trailing:
                Button{
                    if let user = Auth.auth().currentUser {
                        print(user.uid, user.email)
                        let db = Firestore.firestore()
                        var data = userData()
                        data.email=user.email ?? ""
                        data.id=user.uid
                        data.gender=gender
                        data.birthday=dateFormatter.string(from: birthday)
                        data.country=country
                        data.name=nickname
                        //data.name="11111"
                        do {
                            let documentReference = try db.collection("userdatas").document("\(user.uid)").setData(from: data)
                            
                        } catch {
                            print(error)
                        }
                    }
                    
                }label:{
                    HStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            .frame(width: 70, height: 30, alignment: .center)
                            .overlay(
                                Text("送出")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
                )
        }
        /*
         
         
         */
        
    }
}
//convert a SwiftUI view to an image
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
/*
struct userProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        userProfilePage()
    }
}
 */
