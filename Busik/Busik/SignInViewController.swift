//
//  ViewController.swift
//  Busik
//
//  Created by Kanstantin Venger on 5/31/22.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    public var CtxManager: ContextManager!;
    var _userRepository: UserRepository!;
    var _localityRepository: LocalityRepository!;
    var _roureRepository: RouteRepository!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TODO: remove db initialization to erlier executed function if it appears
        let ctx = ContextRetriever.RetrieveContext();
        CtxManager = ContextManager(context: ctx);
        _userRepository = UserRepository(contextManager: CtxManager);
        _localityRepository = LocalityRepository(contextManager: CtxManager);
        _roureRepository = RouteRepository(contextManager: CtxManager);
        let dataSeeder = DataSeeder(ctxManager: CtxManager);
        
        //ATTENTION: uncomment to get add test data to db if needed
        //But do it only once on each device
        //dataSeeder.SeedUsers()
        //dataSeeder.SeedLocalities();
        //dataSeeder.SeedRoutes();
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        if (UserDefaults.standard.string(forKey: "password") != passwordTextField.text!) ||
            (UserDefaults.standard.string(forKey: "username") != emailTextField.text!) {
            passwordTextField.text = "Wrong password or name"
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "MainMenuStoryboard")
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        
        present(secondVC, animated: true, completion: nil)
    }
    
    @IBAction func signUpButoonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "SignUpStoryboard")
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
        
        present(secondVC, animated: true, completion: nil)
    }
}

