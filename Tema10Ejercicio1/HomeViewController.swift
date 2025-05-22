//
//  HomeViewController.swift
//  Tema10Ejercicio1
//
//  Created by DISEÑO on 4/12/24.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getUser() {
        let _ = Auth.auth().currentUser?.email
    }
    
    func logOut() {
        try? Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnLogout(_ sender: Any) {
        logOut()
    }
}
