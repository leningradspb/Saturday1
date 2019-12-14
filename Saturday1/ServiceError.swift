//
//  ServiceError.swift
//  Saturday1
//
//  Created by Eduard Sinyakov on 11/30/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import Foundation

enum ServiceError: Error {

	case serviceError(NSError)
	case noData
	case cantDecode(Error)
	case status200
	case noResponse
}
