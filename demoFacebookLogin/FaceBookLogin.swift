//
//  FaceBookLogin.swift
//  demoFacebookLogin
//
//  Created by Mitesh pc on 18/04/18.
//  Copyright © 2018 Mitesh pc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

enum CompletionHandlerenum {
    case success(userDetail) ,failure(Error)
}

class FaceBookLogin: NSObject {

    typealias CompletionHandler = (CompletionHandlerenum) -> ()

    static let shared = FaceBookLogin()

    var facebookUser : userDetail?
    
    func loginButtonAction(completionHandler:@escaping CompletionHandler){
        let login = FBSDKLoginManager()
        login.logOut()
        FBSDKProfile.setCurrent(nil)
        FBSDKAccessToken.setCurrent(nil)
        login.loginBehavior = FBSDKLoginBehavior.web
        login.logIn(withReadPermissions: ["public_profile", "email"], from: UIApplication.shared.keyWindow?.rootViewController, handler: {(result, error) in
            if error != nil {
                print("Error : \(String(describing: error))")
                completionHandler(CompletionHandlerenum.failure(error!))
            }
            else if (result?.isCancelled)! {
                
            }
            else {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, picture.type(large), email, name, id, gender"]).start(completionHandler: {(connection, result, error) -> Void in
                    if error != nil{
                        print("Error :\(error!)")
                    }else{
                        completionHandler(CompletionHandlerenum.success(userDetail.init(result: result as! NSDictionary)))
                        
                    }
                })
            }
        })
    }
}
class userDetail : NSObject{
    
    var email = ""
    var facebookID = ""
    var fname = ""
    var lname = ""
    var fullname = ""
    var imgProfile = ""
    
    init(result:NSDictionary){
        if let email = (result.value(forKey: "email") as? String){
            self.email = email
        }
        if let fbid = (result.value(forKey: "id") as? String){
            self.facebookID = fbid
        }
        if let name = (result.value(forKey: "name") as? String){
            self.fullname = name
        }
        if let picture :NSDictionary = result.value(forKey: "picture") as? NSDictionary{
            if let picdata = picture.value(forKey:"data"){
                if let pic : NSDictionary = picdata as? NSDictionary{
                    self.imgProfile = pic.value(forKey: "url") as! String
                }
            }
        }
    }
}
