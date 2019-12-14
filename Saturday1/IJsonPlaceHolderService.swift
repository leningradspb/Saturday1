//
//  IJsonPlaceHolderService.swift
//  Saturday1
//
//  Created by Eduard Sinyakov on 11/30/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import Foundation
var dataTask: URLSessionDataTask?
let session = URLSession(configuration: .default)
let url = "https://jsonplaceholder.typicode.com/todos"
let urlUsers = "https://jsonplaceholder.typicode.com/users"

protocol IJsonPlaceHolderService {
	func loadUsers(_ completion: @escaping (UserResult) -> Void)
	func loadTodos(_ completion: @escaping (TodosResult) -> Void)

}

extension IJsonPlaceHolderService {


	func loadUsers(_ completion: @escaping (UserResult) -> Void) {

		let mainUrl = URL(string: urlUsers)

			guard let urlString = mainUrl else {return}

			dataTask = session.dataTask(with: urlString) { (data, response, error) in

				if let error = error {
					completion(UserResult.failure(ServiceError.serviceError(error as NSError)))
					return
				} // end ifletError

				guard (response  as? HTTPURLResponse) != nil  else {
					completion(.failure(ServiceError.noResponse))
					return
				}

				if let data = data,
					let response = response  as? HTTPURLResponse,
				response.statusCode == 200 {
		
					do {
						let object = try JSONDecoder().decode([User].self, from: data)
						DispatchQueue.main.async {
							completion(UserResult.success(object))
						}
					} catch {
						DispatchQueue.main.async {
							UserResult.failure(ServiceError.cantDecode(error))
						}
					}

				} else {
					UserResult.failure(ServiceError.noData)
				}

			}
			dataTask?.resume()



	} // endOfFuncUser


	func loadTodos(_ completion: @escaping (TodosResult) -> Void) {

		let mainUrl = URL(string: url)

			guard let urlString = mainUrl else {return}

			dataTask = session.dataTask(with: urlString) { (data, response, error) in

				if let error = error {
					//			DispatchQueue.main.async {
					//				comoletion(.failure(error as NSError))
					//			}
					return
				} // end ifletError

				if let data = data,
					let response = response  as? HTTPURLResponse,
				response.statusCode == 200 {
					do {
						let object = try JSONDecoder().decode([Todo].self, from: data)
						DispatchQueue.main.async {
							completion(TodosResult.success(object))
						}
					} catch {
						DispatchQueue.main.async {
							print("errror")
						}
					}

				} else {
					print("error")
				}

			}
			dataTask?.resume()



	} // endOfFuncUser

}
