//
//  ViewController.swift
//  Concurrency
//
//  Created by Hamza Azhar on 2024-10-31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.fetchUserData()
    }
    
    private func initialSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let httpClient = AsyncAwaitHttpClient()
        let repository = AsyncAwaitRepository(asyncHttpRequesting: httpClient)
        self.viewModel = ViewModel(repository: repository)
        self.viewModel?.delegate = self
    }
    
    func fetchUserData() {
        Task {
            await self.viewModel?.fetchUsers()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.userModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.viewModel?.userModel[indexPath.row].name
        return cell
    }
    
    
}

extension ViewController: UserFetching {
    func usersFetched() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }
}

