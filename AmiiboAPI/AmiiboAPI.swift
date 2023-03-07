//
//  AmiiboAPI.swift
//  AmiiboAPI
//
//  Created by Kresimir Ivanjko on 06.03.2023..
//

import Foundation


// MARK: - Fetch data

final class AmiiboAPI {
    
    static let shared = AmiiboAPI()
    func fetchAmiiboList(onCompletion: @escaping ([Amiibo]) -> ()) {
        let urlString = "https://amiiboapi.com/api/amiibo/"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard let data = data else {
                print("data was nil")
                return
            }
            
            guard let amiiboList = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("Couldnt decode JSON")
                return
            }
            onCompletion(amiiboList.amiibo)
            print(amiiboList.amiibo)
            
        }
        task.resume()
    }
}


// MARK: - Amiibo struct

struct AmiiboList: Codable {
    let amiibo: [Amiibo]
}

struct Amiibo: Codable {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: AmiiboRealase
    let tail: String
    
}

struct AmiiboRealase: Codable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}

/*
 "amiibo": [
     {
       "amiiboSeries": "Super Smash Bros.",
       "character": "Mario",
       "gameSeries": "Super Mario",
       "head": "00000000",
       "image": "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00000002.png",
       "name": "Mario",
       "release": {
         "au": "2014-11-29",
         "eu": "2014-11-28",
         "jp": "2014-12-06",
         "na": "2014-11-21"
       },
       "tail": "00000002",
       "type": "Figure"
 */
