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
    @IBOutlet weak var errorField: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    public var CtxManager: ContextManager!;
    var _userRepository: UserRepository!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = 20
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = UIColor.systemGreen.cgColor
        
        let ctx = ContextRetriever.RetrieveContext();
        CtxManager = ContextManager(context: ctx);
        _userRepository = UserRepository(contextManager: CtxManager);
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let login = emailTextField.text!
        let password = passwordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        if (login.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
            errorField.text = "Field can't be empty"
            return
        }
        if password != repeatPassword {
            errorField.text = "Different passwords"
            return
        }
        
        let user = _userRepository.GetUsersByLogin(login: login)

        if (user == nil) {
            errorField.text = "Fatal error"
            return
        }
        if(!user!.isEmpty){
            errorField.text = "User with this email already exists"
            return
        }
    
        _userRepository.AddUser(login: login, password: password)
        
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
