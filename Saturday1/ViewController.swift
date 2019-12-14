//
//  ViewController.swift
//  Saturday1
//
//  Created by Eduard Sinyakov on 11/30/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private var dataTask: URLSessionDataTask?
	let session = URLSession(configuration: .default)

	let networkFunctions = JsonPlaceholderService()

	private var todos = [Todo]()
	private var users = [User]()

	private var tvvm = [TabelviewViewModel]()

	let tableView = UITableView()

	var safeArea: UILayoutGuide!

	let dispatchGroup = DispatchGroup()
	//let firstQueue = DispatchQueue(label: "First", qos: .utility, attributes: .concurrent)
	//let secondQueue = DispatchQueue(label: "Second", qos: .utility, attributes: .concurrent)
	

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = .green
		safeArea = view.layoutMarginsGuide
		setupTableView()

		dispatchGroup.enter()

			//sleep(5)
			self.loadUsers { (users) in
			switch users {
			case .success(let result):
				self.users = result
				print(result)
			case.failure(_):
				self.users = []
			}
				self.dispatchGroup.leave()
			}
		 // endOfLoadUsers
		dispatchGroup.enter()


			//sleep(5)
			self.loadTodos { (todos) in
			switch todos {
			case .success(let result):
				self.todos = result
				print(result)
			case.failure(_):
				self.todos = []
			}
				self.dispatchGroup.leave()
			}//endofLoadTodos

		dispatchGroup.notify(queue: .main) {
			for todo in self.todos {
//				TabelviewViewModel(name: <#T##String#>, title: <#T##String#>)
//				self.titleArray.append(todo.title)
				for user in self.users {
//					self.nameArray.append(user.name)
					if todo.userId == user.id {
						self.tvvm.append(TabelviewViewModel(name: user.name, title: todo.title))
					}
				}
			}
			self.tableView.reloadData()

		}
		//	self.dispatchGroup.notify(queue: self.firstQueue, work: DispatchWorkItem(block: {}))
		} // endViewDidLoad

	func setupTableView() {
	   view.addSubview(tableView)
	   tableView.translatesAutoresizingMaskIntoConstraints = false
	   tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
	   tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
	   tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	   tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

	tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.delegate = self
		tableView.dataSource = self
	 }






} //endOfClass



extension ViewController: IJsonPlaceHolderService {

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tvvm.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		//cell.textLabel?.text = String(todos[indexPath.row].id) + " " + users[indexPath.row].username
		cell.textLabel?.text = tvvm[indexPath.row].name + " " + tvvm[indexPath.row].title
		cell.textLabel?.tintColor = .red

		return cell

	}


}



