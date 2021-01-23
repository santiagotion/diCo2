//
//  MainDataManager.swift
//  smartDict
//
//  Created by Nathan Tuala on 6/29/20.
//  Copyright © 2020 Nathan Tuala. All rights reserved.
//

import Foundation

class MainDataManager {
    /*
     let items:[String] = ["Joohee, IL", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
     "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
     "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
     "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
     "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
     */
    let items:[String] = []
    
    var wordFound: Bool!
    
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index:IndexPath) -> String {
        return items[index.item]
    }
    
    func getData(from url: String, completion: @escaping ([Meanings])->()){
        
        var definitions:[Meanings] = []
        //print("Start")
        //print(url)
        if (URL(string: url) != nil) {
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
                
                guard let data = data, error == nil else{
                    
                    print("Something went wrong")
                    //Searcher.found = false
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                        //print("statusCode: \(httpResponse.statusCode)")
                    if (httpResponse.statusCode == 200) {
                        Searcher.found = true
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let j_array = json as? [Any]
                        {
                            for _array in j_array
                            {
                                var audio = "";
                                if let j_dictionary = _array as? [String:Any]
                                {
                                    if let phonetic = j_dictionary["phonetics"] as? [Any]
                                    {
                                        if phonetic.count > 0 {
                                            if let dict = phonetic[0] as? [String:Any]
                                            {
                                                if let sound = dict["audio"] as? String
                                                {
                                                    audio = sound
                                                }
                                            }
                                        }
                                    }
                                    if let mean_ = j_dictionary["meanings"] as? [Any]
                                    {
                                        for mean in mean_
                                        {
                                            if let aa = mean as? [String:Any]
                                            {
                                                //print("Hello")
                                                let definition = Meanings(json:aa,audio: audio)
                                                //print(definition.partOfSpeech)
                                                definitions.append(definition)
                                                //print(definitions[0].partOfSpeech)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }else {
                        Searcher.found = false
                    }
                }
                
                completion(definitions)
            })
            task.resume()
            //return definitions
        }
        
    } 
    
}
