//
//  ViewController.swift
//  Tema10Ejercicio1
//
//  Created by DISEÑO on 2/12/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    //Componentes
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }
    
    //Funciones
    func goToPush() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        viewcontroller?.modalPresentationStyle = .overFullScreen
        self.present(viewcontroller ?? ViewController(), animated: true, completion: nil)
    }
    
    func configureAlert() {
        let alertController = UIAlertController(title: "Mensaje de error", message: "Email o contrasenia incorracto", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Acepta", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getUser() {
        let _ = Auth.auth().addStateDidChangeListener {
            auth, user in
            if user == nil {
                print("no login")
            } else {
                self.goToPush()
            }
        }
    }
    
    func loginWithFireBase(email: String,password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] authResult, error in guard let self = self else {return}
            if error != nil {
                self.configureAlert()
            } else {
                self.goToPush()
            }
        }
    }
    
    func registerWithFireBase(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in guard let self = self else {return}
            if error != nil {
                self.configureAlert()
            } else {
                self.goToPush()
            }
        }
    }
    
    func loginUser() {
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        loginWithFireBase(email: email, password: password)
    }
    
    func registerUser() {
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        registerWithFireBase(email: email, password: password)
    }

    @IBAction func btnLogin(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        registerUser()
    }
    
    
}

