//
//  AmiiboDetailViewController.swift
//  AmiiboAPI
//
//  Created by Kresimir Ivanjko on 09.03.2023..
//

import UIKit

class AmiiboDetailViewController: UIViewController {
    var amiibo: AmiiboForView?
    
    var safeArea: UILayoutGuide!
    let imageIV = CustomImageView()
    let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        safeArea = view.layoutMarginsGuide
        
        setupImage()
        setupNameLabel()
        setupData()
    }
    func setupImage() {
        view.addSubview(imageIV)
        
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        
        imageIV.contentMode = .scaleAspectFill
        imageIV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageIV.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageIV.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
        imageIV.heightAnchor.constraint(equalTo: imageIV.heightAnchor).isActive = true
    }
    
    func setupNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.topAnchor.constraint(equalTo: imageIV.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    func setupData() {
        if let amiibo = amiibo,
           let url = URL(string: amiibo.imageUrl)
        {
            imageIV.loadImage(from: url)
            nameLabel.text = amiibo.name
        }
    }
}
