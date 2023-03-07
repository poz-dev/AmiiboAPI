//
//  ViewController.swift
//  AmiiboAPI
//
//  Created by Kresimir Ivanjko on 06.03.2023..
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    var safeArea = UILayoutGuide()
    var amiiboList = [Amiibo] ()

    override func viewDidLoad() {
        view.backgroundColor = .white
        safeArea = view.safeAreaLayoutGuide
        setupTableView()
        
        let anonymousFunction = { (fetchedAmiiboList: [Amiibo]) in
            DispatchQueue.main.async {
                self.amiiboList = fetchedAmiiboList
                self.tableView.reloadData()
            }
            
        }
        
        AmiiboAPI.shared.fetchAmiiboList(onCompletion: anonymousFunction)
        
    }
   
    // MARK: - 1. SetupView
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }

}

    // MARK: - 2. UITableViewDataSource

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let amiibo = amiiboList[indexPath.row]
        cell.textLabel?.text = amiibo.name
        return cell
    }
    
    
}
