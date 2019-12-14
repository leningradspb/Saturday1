//
//  NetworkFucntions.swift
//  Saturday1
//
//  Created by Eduard Sinyakov on 11/30/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import UIKit

typealias UserResult = Result<[User], ServiceError>
typealias TodosResult = Result<[Todo], ServiceError>
typealias DataResult = Result<Data, ServiceError>

class JsonPlaceholderService {

	private let decoder = JSONDecoder()
	private func fetchData(from url: URL,
						   _ completion: @escaping (DataResult) -> Void) {

//		let mainUrl = URL(string: urlUsers)
//
//		guard let urlString = mainUrl else {return}

		dataTask = session.dataTask(with: url) { (data, response, error) in

		if let error = error {
			completion(DataResult.failure(ServiceError.serviceError(error as NSError)))
			return
		} // end ifletError

		guard (response  as? HTTPURLResponse) != nil  else {
			completion(.failure(ServiceError.noResponse))
			return
		}

		if let data = data,
			let response = response  as? HTTPURLResponse,
		response.statusCode == 200 {
	}

	}
	}
}

extension JsonPlaceholderService: IJsonPlaceHolderService {



	func loadUsers(_ completion: @escaping (UserResult) -> Void) {
		let mainUrl = URL(string: urlUsers)

		guard let urlString = mainUrl else {return}

		fetchData(from: urlString) { dataResult in
			switch dataResult {

			case .success(let data):
				do {
					let object = try JSONDecoder().decode([User].self, from: data)
					DispatchQueue.main.async {
						completion(UserResult.success(object))
					}
				} catch {
					DispatchQueue.main.async {
						//UserResult.failure(ServiceError.cantDecode(error))
						completion(.failure(ServiceError.cantDecode(error)))
					}
				}
		
			case .failure(let error):
				completion(.failure(error))

			}
		}

	}

	func loadTodos(_ completion: @escaping (TodosResult) -> Void) {
		let mainUrl = URL(string: url)

		guard let urlString = mainUrl else {return}

		fetchData(from: urlString) { dataResult in
			switch dataResult {

			case .success(let data):
				do {
					let object = try JSONDecoder().decode([Todo].self, from: data)
					DispatchQueue.main.async {
						completion(TodosResult.success(object))
					}
				} catch {
					DispatchQueue.main.async {
						//UserResult.failure(ServiceError.cantDecode(error))
						completion(.failure(ServiceError.cantDecode(error)))
					}
				}

			case .failure(let error):
				completion(.failure(error))

			}
		}

	}


	
}
