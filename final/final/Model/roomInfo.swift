//
//  roomInfo.swift
//  final
//
//  Created by 1+ on 2022/6/25.
//
import FirebaseFirestoreSwift
import FirebaseFirestore
struct roomInfo: Hashable,Codable, Identifiable {
    @DocumentID var id: String?
    var roomNum:Int
    var player1_ID:String
    var player2_ID:String
    var player3_ID:String
    var player4_ID:String
    var p1ready:Bool
    var p2ready:Bool
    var p3ready:Bool
    var p4ready:Bool
    init(){
        roomNum = Int.random(in: 1000000...9999999)
        player1_ID = ""
        player2_ID = ""
        player3_ID = ""
        player4_ID = ""
        p1ready = false
        p2ready = false
        p3ready = false
        p4ready = false
    }
}

class MyRoom: ObservableObject {
    @Published var roomData: roomInfo
    private var listener: ListenerRegistration?
    let allReady = NotificationCenter.default.publisher(for: Notification.Name("allReady"))
    let p2in = NotificationCenter.default.publisher(for: Notification.Name("p2in"))
    let p2out = NotificationCenter.default.publisher(for: Notification.Name("p2out"))
    let p3in = NotificationCenter.default.publisher(for: Notification.Name("p3in"))
    let p3out = NotificationCenter.default.publisher(for: Notification.Name("p3out"))
    let p4in = NotificationCenter.default.publisher(for: Notification.Name("p4in"))
    let p4out = NotificationCenter.default.publisher(for: Notification.Name("p4out"))
    let db = Firestore.firestore()
    init() {
        self.roomData = roomInfo()
    }
    func addRoomListener(){
       self.listener = self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").addSnapshotListener{
           snapshot, error in
           guard let snapshot = snapshot else { return }
           guard let room = try? snapshot.data(as: roomInfo.self) else { return }
           self.roomData = room
           if self.roomData.player2_ID != ""{
               NotificationCenter.default.post(name: Notification.Name("p2in"), object: nil)
           }
           else{
               NotificationCenter.default.post(name: Notification.Name("p2out"), object: nil)
           }
           if self.roomData.player3_ID != ""{
               NotificationCenter.default.post(name: Notification.Name("p3in"), object: nil)
           }
           else{
               NotificationCenter.default.post(name: Notification.Name("p3out"), object: nil)
           }
           if self.roomData.player4_ID != ""{
               NotificationCenter.default.post(name: Notification.Name("p4in"), object: nil)
           }
           else{
               NotificationCenter.default.post(name: Notification.Name("p4out"), object: nil)
           }
           if self.roomData.p1ready && self.roomData.p2ready && self.roomData.p3ready && self.roomData.p4ready{
               NotificationCenter.default.post(name: Notification.Name("allReady"), object: nil)
           }
           
        }
    }
    func removeRoomListener(){
        self.listener?.remove()
    }
    func getReady(user: Int){
        if user == 0 {
            self.roomData.p1ready = true
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p1ready": true], merge: true)
        }
        else if user == 1 {
            self.roomData.p2ready = true
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p2ready": true], merge: true)
        }
        else if user == 2 {
            self.roomData.p3ready = true
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p3ready": true], merge: true)
        }
        else if user == 3 {
            self.roomData.p4ready = true
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p4ready": true], merge: true)
        }
    }
    func cancelReady(user: Int){
        if user == 0 {
            self.roomData.p1ready = false
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p1ready": false], merge: true)
        }
        else if user == 1 {
            self.roomData.p2ready = false
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p2ready": false], merge: true)
        }
        else if user == 2 {
            self.roomData.p3ready = false
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p3ready": false], merge: true)
        }
        else if user == 3 {
            self.roomData.p4ready = false
            self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").setData(["p4ready": false], merge: true)
        }
    }
    func delRoom(){
        self.db.collection("rooms").document("\(self.roomData.roomNum)" ?? "").delete() { err in
            if let err = err {
                print("Error : \(err)")
            } else {
                print("successfully deleted!")
            }
        }
    }
}
