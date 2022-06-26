//
//  userProfile.swift
//  final
//
//  Created by 1+ on 2022/6/7.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
struct userProfilePage: View {
    @Binding var viewController:Int
    @State private var name=""
    @State private var email=""
    @State private var birthday=""
    @State private var gender=""
    @State private var photoURL=""
    @State private var country=""
    @State private var joindate=""
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                List{
                    HStack{
                        VStack(spacing:10){
                            HStack{
                                Text("暱稱:")
                                Spacer()
                                Text("\(name)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.purple)
                            }
                            HStack{
                                Text("e-mail:")
                                Spacer()
                                Text("\(email)")
                            }
                            HStack{
                                Text("性別:")
                                Spacer()
                                Text("\(gender)")
                                    .foregroundColor(gender == "男生♂️" ? Color.blue : Color.red)
                            }
                            HStack{
                                Text("國家:")
                                Spacer()
                                Text("\(country)")
                            }
                            HStack{
                                Text("生日:")
                                Spacer()
                                Text("\(birthday)")
                            }
                            HStack{
                                Text("加入日期:")
                                Spacer()
                                Text("\(joindate)")
                            }
                        }
                        Spacer()
                        AsyncImage(url: URL(string: photoURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(width: 100, height: 150)
                        .cornerRadius(20)
                        
                    }
                    
                }
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
            }
        }
        .onAppear(perform: {
            if let user = Auth.auth().currentUser {
                let db = Firestore.firestore()
                let documentReference = db.collection("userdatas").document("\(user.uid)")
                documentReference.getDocument { document, error in
                    guard let document = document,document.exists,
                    var data = try? document.data(as: userData.self)
                    else {return}
                    name=data.name
                    email=data.email
                    birthday=data.birthday
                    gender=data.gender
                    photoURL=data.photoURL
                    country=data.country
                    joindate=data.joinDate
                }
                  
            }
        })
        
    }
}
/*
struct userProfile_Previews: PreviewProvider {
    static var previews: some View {
        userProfile()
    }
}
*/
