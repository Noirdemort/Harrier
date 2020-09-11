//
//  ViewController.swift
//  Harrier
//
//  Created by Noirdemort on 10/09/20.
//  Copyright © 2020 Noirdemort. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.username.text = ""
		self.password.text = ""
		self.cryptoSalt.text = ""
		self.initVector.text = ""
	}
	
	@IBOutlet weak var username: UITextField!

	@IBOutlet weak var password: UITextField!
	
	@IBOutlet weak var cryptoSalt: UITextField!
	
	@IBOutlet weak var initVector: UITextField!
	
	
	@IBAction func authorize(_ sender: Any) {
		
		guard let cryptoKey = self.password.text else { return }
		
		if let _ =  authenticateUser(password: cryptoKey){
			self.performSegue(withIdentifier: "authSegue", sender: nil)
		}
		
	}
	
	
	@IBAction func setUpAccount(_ sender: Any){
		self.performSegue(withIdentifier: "resetSegue", sender: nil)
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier ?? "" == "authSegue" {
			let destination = segue.destination as! IntelViewController
			var translator = Translator(cryptoKey: self.password.text!,
									plainSalt: self.cryptoSalt.text!,
									initVector: self.initVector.text!)
			translator.loadAndDraft(filePath: translator.filePath)
		
			destination.translator = translator
		}
		
	}
	
	
}

