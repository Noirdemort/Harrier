//
//  ResetViewController.swift
//  Harrier
//
//  Created by Noirdemort on 11/09/20.
//  Copyright © 2020 Noirdemort. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	
	@IBOutlet weak var oldPassword: UITextField!
	@IBOutlet weak var oldSalt: UITextField!
	@IBOutlet weak var oldIV: UITextField!
	@IBOutlet weak var newPassword: UITextField!
	@IBOutlet weak var cryptoSalt: UITextField!
	@IBOutlet weak var initializationVector: UITextField!
	
	
	@IBAction func setUpNewKeys(_ sender: Any){
		
		if newPassword.text?.isEmpty ?? true {
			return
		}
		
		if cryptoSalt.text?.isEmpty ?? true || cryptoSalt.text?.count != 8 {
			return
		}
		
		
		if initializationVector.text?.isEmpty ?? true || initializationVector.text?.count != 8  {
			return
		}
		
		
		do {
			
			
			let translating = Translator(cryptoKey: newPassword.text!,
										 plainSalt: cryptoSalt.text!,
										 initVector: initializationVector.text!)
			
			try newPassword.text!.sha3(.sha512).write(toFile: Translator.authPath,
													  atomically: true,
													  encoding: .utf8)

			
			if let password = oldPassword.text, let salt = oldSalt.text, let iv = oldIV.text {
				let translation = Translator(cryptoKey: password,
											 plainSalt: salt,
											 initVector: iv)
		
														  
				translating.saveAndDeploy(hunts: translation.HuntingParty, filePath: translating.filePath)
				
			} else {
				
				translating.saveAndDeploy(hunts: [], filePath: translating.filePath)
				
			}
			
			self.navigationController?.popViewController(animated: true)
			
		} catch {
			print(error.localizedDescription)
		}
		
	}
	
	
	@IBAction func goBack(_ sender: Any){
		self.navigationController?.popViewController(animated: true)
	}
	
}
