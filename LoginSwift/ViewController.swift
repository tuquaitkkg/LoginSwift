//
//  ViewController.swift
//  LoginSwift
//
//  Created by DucLT on 6/5/17.
//  Copyright © 2017 DucLT. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginFacebook(_ sender: Any) {
        loginFacebook()
    }
    
    func loginFacebook() -> Void {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile,.email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                self.getInfoOfUserFacebook()
            }
        }
    }
    
    func getInfoOfUserFacebook() -> Void {
        let tokenString = AccessToken.current?.authenticationToken
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, gender, name, first_name, last_name, email, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            switch result {
            case .success(let value):
                print(value.dictionaryValue)
            case .failed(let error):
                print(error)
            }
        }
    }

}

