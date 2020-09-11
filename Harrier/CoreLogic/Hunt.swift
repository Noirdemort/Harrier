//
//  Hunt.swift
//  Harrier
//
//  Created by Noirdemort on 10/09/20.
//  Copyright © 2020 Noirdemort. All rights reserved.
//

import Foundation


struct Hunt: Codable, Identifiable {
	
	var id = UUID().uuidString
	var codename: String
	var name: String
	var quickNotes: String
	var specialNotes: String

}

