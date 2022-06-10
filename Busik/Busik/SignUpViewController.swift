//
//  SignUpViewController.swift
//  Busik
//
//  Created by Tyoma on 7.06.22.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    public var CtxManager: ContextManager!;
    var _userRepository: UserRepository!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ctx = ContextRetriever.RetrieveContext();
        CtxManager = ContextManager(context: ctx);
        _userRepository = UserRepository(contextManager: CtxManager);
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if passwordTextField.text! != repeatPasswordTextField.text! { // TODO: make a better password check
            passwordTextField.text = "Different passwords"
            return
        }
        if(_userRepository.GetUsersByLogin(login: emailTextField.text!) == nil){
            emailTextField.text = "User with this email already exists"
            return
        }
        
        UserDefaults.standard.set(emailTextField.text!, forKey: "username")
        UserDefaults.standard.set(passwordTextField.text!, forKey: "password")
        self.dismiss(animated: true, completion: nil)
        
        _userRepository.AddUser(login: emailTextField.text!, password: passwordTextField.text!)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "MainMenuStoryboard")
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        
        present(secondVC, animated: true, completion: nil)
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "SignInStoryboard")
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        
        present(secondVC, animated: true, completion: nil)
    }
}
