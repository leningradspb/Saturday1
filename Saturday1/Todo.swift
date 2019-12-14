//
//  Users.swift
//  Saturday1
//
//  Created by Eduard Sinyakov on 11/30/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import Foundation

struct Todo: Decodable {
	var userId: Int
	var id: Int
	var title: String
	var completed: Bool
}
