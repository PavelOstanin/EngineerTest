//
//  UserListViewController.swift
//  EngineerTest
//
//  Created by Pavel Ostanin on 6/4/19.
//  Copyright © 2019 pavel.ostanin. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    let userDataSource = UsersDataSource()
    
    var users: [User?] {
        return userDataSource.users
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        userDataSource.delegate = self
        userDataSource.loadMoreUsers()
    }

}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.setup(with: users[indexPath.row])
        return cell
    }
    
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > users.count - 5 {
            userDataSource.loadMoreUsers()
        }
    }
    
}

extension UserListViewController: UsersDataSourceDelegate {
    
    func didUpdateUsers() {
        usersTableView.reloadData()
    }
    
}
