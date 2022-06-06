import FirebaseFirestoreSwift
import UIKit
struct userData: Hashable,Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var birthday: String
    var country:String
    var gender:String
    var coin:Int
    var joinDate:String
    init(){
        name=""
        email=""
        birthday=""
        country=""
        gender=""
        coin=0
        joinDate=""
    }
}
