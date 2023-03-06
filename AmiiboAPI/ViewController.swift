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
    let amiiboList = ["Zelda", "Link", "Navi"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        
        setupView()
        
        AmiiboAPI.shared.fetchAmiiboList()
        
        
    }
    
    // MARK: - 1. SetupView
    
    func setupView() {
        view.addSubview(tableView)
        
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
        let name = amiiboList[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    
}
