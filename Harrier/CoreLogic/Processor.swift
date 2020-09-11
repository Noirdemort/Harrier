//
//  Processor.swift
//  Harrier
//
//  Created by Noirdemort on 10/09/20.
//  Copyright © 2020 Noirdemort. All rights reserved.
//

import Foundation
import CryptoSwift


func authenticateUser(password: String) -> String? {
	if try! String(contentsOfFile: Translator.authPath) == password.sha3(.sha512) {
		return password
	}
	
	return nil
}



func listHunt(translator: Translate) -> [Hunt] {
	return translator.HuntingParty
}


func getHunt(translator: Translate, codename: String) -> Hunt? {
	let hunt = translator.HuntingParty.first(where: { $0.codename == codename })
	return hunt
}


func saveHunt(translator: inout Translate, hunt: Hunt) {
	translator.addHunt(hunt: hunt)
}


func deleteHunt(translator: inout Translate, hunt: Hunt) {
	translator.deleteHunt(hunt: hunt)
}


func updateHunt(translator: inout Translate, hunt: Hunt, name: String, quickNotes: String, specialNotes: String){
	
	let finalName = name.isEmpty ? hunt.name : name
	let finalQuickNotes = quickNotes.isEmpty ? hunt.quickNotes : quickNotes
	let finalSpecialNotes = specialNotes.isEmpty ? hunt.specialNotes : specialNotes
	
	let hunted = Hunt(id: hunt.id, codename: hunt.codename, name: finalName, quickNotes: finalQuickNotes, specialNotes: finalSpecialNotes)
	
	translator.updateHunt(hunt: hunted)
}


