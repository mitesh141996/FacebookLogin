//
//  ViewController.swift
//  demoFacebookLogin
//
//  Created by Mitesh pc on 18/04/18.
//  Copyright © 2018 Mitesh pc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class ViewController: UIViewController {

    @IBOutlet weak var btnLoginObj: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnLogin(_ sender: Any) {
      //Please add the FacebookAppID and FacebookDisplayName in info.plist
      let login = FaceBookLogin.shared
      login.loginButtonAction { (result) in
        switch result{
        case .success(let userDetail):
            print(userDetail)
        case .failure(let error):
            print(error)
        }
      }
    }
    
}

