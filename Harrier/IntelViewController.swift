//
//  IntelViewController.swift
//  Harrier
//
//  Created by Noirdemort on 10/09/20.
//  Copyright © 2020 Noirdemort. All rights reserved.
//

import UIKit

class IntelViewController: UIViewController {

	var translator: Translate? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.intelTableView.delegate = self
		self.intelTableView.dataSource = self
		self.intelTableView.allowsMultipleSelection = true
		self.intelTableView.allowsSelection = true
	}
	
	
	@IBOutlet weak var intelTableView: UITableView!
	
	
	@IBAction func createHuntInstance(_ sender: Any) {
		
		self.performSegue(withIdentifier: "huntSegue", sender: nil)
	}
	
	
	@IBAction func logOut(_ sender: Any) {
		
		if let translable = translator {
			translable.saveAndDeploy(hunts: translable.HuntingParty, filePath: translable.filePath)
		}
		
		self.navigationController?.popViewController(animated: true)
	
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destination = segue.destination as! HunterViewController
		destination.cudableDelegate = self
		destination.hunt = sender as? Hunt
	}
	
	
	
}


extension IntelViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let hunt = self.translator?.HuntingParty[indexPath.row]
		self.performSegue(withIdentifier: "huntSegue", sender: hunt)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		if editingStyle == .delete {

			// remove the item from the data model
			self.removeHunt(hunt: self.translator!.HuntingParty[indexPath.row])

			// delete the table view row
			self.intelTableView.deleteRows(at: [indexPath], with: .fade)

		}
	}
}


extension IntelViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let translated = self.translator else { return 0 }
		return listHunt(translator: translated).count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "codeNameCell", for: indexPath) as! CodeNameCell
		cell.codeName.text = translator!.HuntingParty[indexPath.row].codename
		return cell
	}
	

}


extension IntelViewController: CUDable {
	
	func addHunt(hunt: Hunt) {
		saveHunt(translator: &translator!, hunt: hunt)
		self.intelTableView.reloadData()
	}
	
	func editHunt(hunt: Hunt, name: String="", quickNotes: String="", specialNotes: String = "") {
		updateHunt(translator: &translator!, hunt: hunt, name: name, quickNotes: quickNotes, specialNotes: specialNotes)
		self.intelTableView.reloadData()
	}
	
	func removeHunt(hunt: Hunt) {
		deleteHunt(translator: &translator!, hunt: hunt)
		self.intelTableView.reloadData()
	}
	
	
}


class CodeNameCell: UITableViewCell {
	
	@IBOutlet weak var codeName: UILabel!
	
}
