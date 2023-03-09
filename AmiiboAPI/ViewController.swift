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
    var amiiboList = [AmiiboForView] ()

    override func viewDidLoad() {
        view.backgroundColor = .white
        safeArea = view.safeAreaLayoutGuide
        setupTableView()
        
        let anonymousFunction = { (fetchedAmiiboList: [Amiibo]) in
            DispatchQueue.main.async {
                let amiiboForViewList = fetchedAmiiboList.map { amiibo in
                    return AmiiboForView(
                        name: amiibo.name,
                        gameSeries: amiibo.gameSeries,
                        imageUrl: amiibo.image,
                        count: 0)
                }
                self.amiiboList = amiiboForViewList
                self.tableView.reloadData()
            }
            
        }
        
        
        AmiiboAPI.shared.fetchAmiiboList(onCompletion: anonymousFunction)
        
    }
   
    // MARK: - 1. SetupView
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(AmiiboCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
        guard let amiiboCell = cell as? AmiiboCell else {
            return cell
        }
        
        amiiboCell.nameLabel.text = amiibo.name
        amiiboCell.gameSeriesLabel.text = amiibo.gameSeries
        amiiboCell.owningCountLabel.text = String(amiibo.count)
        if let url = URL(string: amiibo.imageUrl) {
            amiiboCell.imageIV.loadImage(from: url)
        }
        return cell
    }
    
    
}
// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            self.amiiboList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
            
        }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let countAction = UIContextualAction(style: .normal, title: "Count up") { (action, view, completionHandler) in
            
            let cuurentCoun = self.amiiboList[indexPath.row].count
            self.amiiboList[indexPath.row].count = cuurentCoun + 1
            
            if let cell = self.tableView.cellForRow(at: indexPath) as? AmiiboCell {
                cell.owningCountLabel.text = String(self.amiiboList[indexPath.row].count)
            }
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [countAction])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let amiibo = self.amiiboList[indexPath.row]
        let AmiiboDetailViewController = AmiiboDetailViewController()
        AmiiboDetailViewController.amiibo = amiibo
        self.present(AmiiboDetailViewController, animated: true)
    }
}

    

