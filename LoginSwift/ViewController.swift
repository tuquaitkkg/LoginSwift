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

class ViewController: UIViewController,  GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
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

    @IBAction func gmailAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutGmail(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().disconnect()
    }
}

