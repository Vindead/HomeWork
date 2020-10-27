//
//  ViewController.swift
//  Lesson 1
//
//  Created by Kirill Bubnov on 28/10/2020.
//  Copyright © 2020 Kirill Bubnov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLogin: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func entranseButton(_ sender: Any) {
        
        guard let loginInput = textLogin.text,
            let passwordInput = textPassword.text
            else{
                
                return
        }
       print(loginInput + " " + passwordInput)
    }
     
}

