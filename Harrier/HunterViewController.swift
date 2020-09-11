//
//  HunterViewController.swift
//  Harrier
//
//  Created by Noirdemort on 10/09/20.
//  Copyright © 2020 Noirdemort. All rights reserved.
//

import UIKit

protocol CUDable: class {
	func addHunt(hunt: Hunt)
	func editHunt(hunt: Hunt, name: String, quickNotes: String, specialNotes: String)
	func removeHunt(hunt: Hunt)
}


class HunterViewController: UIViewController {

	var hunt: Hunt? = nil
	weak var cudableDelegate: CUDable? = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let h = hunt {
			self.codename.text = h.codename
			self.codename.isEnabled = false
			self.name.isEnabled = false
			self.quickNotes.isEditable = false
			self.specialNotes.isEditable = false
		}
		self.name.text = hunt?.name
		self.quickNotes.text = hunt?.quickNotes
		self.specialNotes.text = hunt?.specialNotes
		
    }
	
	
	@IBOutlet weak var isEditable: UISwitch!
    
	@IBOutlet weak var codename: UITextField!
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var quickNotes: UITextView!
	@IBOutlet weak var specialNotes: UITextView!

	@IBAction func changeEditingStatus(_ sender: UISwitch) {
		self.name.isEnabled = sender.isOn
		self.quickNotes.isEditable = sender.isOn
		self.specialNotes.isEditable = sender.isOn
	}
	
	
	@IBAction func save(_ sender: Any){
		
		if let hunting = hunt {
			
			self.cudableDelegate?.editHunt(hunt: hunting, name: self.name.text ?? "", quickNotes: self.quickNotes.text, specialNotes: self.specialNotes.text)
			
		} else {
			
			if self.codename.text?.isEmpty ?? true || self.name.text?.isEmpty ?? true {
				return
			}
			
			let newHunt = Hunt(codename: self.codename.text!, name: self.name.text!, quickNotes: self.quickNotes.text, specialNotes: self.specialNotes.text)
			self.cudableDelegate?.addHunt(hunt: newHunt)
		}
		
		self.navigationController?.popViewController(animated: true)
	}
	
	
	@IBAction func back(_ sender: Any){
		self.navigationController?.popViewController(animated: true)
	}

}
