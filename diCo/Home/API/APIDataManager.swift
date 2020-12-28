//
//  APIDataManager.swift
//  smartDict
//
//  Created by Nathan Tuala on 6/29/20.
//  Copyright © 2020 Nathan Tuala. All rights reserved.
//

import Foundation

struct Meaning {
    let definition: String
    let example:String
    let synonyms:[String]
    
    init(json:[String:Any])
    {
        if let definition = json["definition"] as? String
        {
            self.definition = definition
        }else
        {
            self.definition = "Missing Definition"
        }
        if let example = json["example"] as? String
        {
            self.example = example
        }else {
            self.example = "Missing Example"
        }
        if let synonyms = json["synonyms"] as? [String]
        {
            self.synonyms = synonyms
        }else{
            self.synonyms = ["Empty"]
        }
        
    }
}

struct Meanings{
    let partOfSpeech:String
    let audio:String
    let meanings:[Meaning]
    //let word:String
    
    init(json:[String:Any], audio:String)
    {
        self.audio = audio
        if let partOfSpeech = json["partOfSpeech"] as? String{
            self.partOfSpeech = partOfSpeech
        }else {self.partOfSpeech = "Missing part of speech"}
        if let definitions = json["definitions"] as? [Any]
        {
            var meanings:[Meaning] = []
            for definition in definitions
            {
                if let def = definition as? [String:Any]
                {
                    let meaning = Meaning(json:def)
                    meanings.append(meaning)
                }
            }
            self.meanings = meanings
        }else
        {
            self.meanings = []
        }
    }
}
struct MyDict{
    let word:String
    let audio:String
    init(word:String, audio:String)
    {
        self.audio = audio
        self.word = word
    }
}
struct Word {
    let word: String
    let audio: String
    let date: Double
    let frequency: Int
    let meanings: [MMeaning]
    init (word: String, audio: String, date: Double, frequency: Int, json:[Any]) {
        self.word = word
        self.audio = audio
        self.date = date
        self.frequency = frequency
        var meanings : [MMeaning] = []
        
        for j_meaning in json {
            if let meaning = j_meaning as? [String:Any] {
                let mmeaning = MMeaning(json:meaning)
                meanings.append(mmeaning)
            }
        }
        self.meanings = meanings
    }
}
struct Definition {
    let definition: String
    let example: String
    init (json : [String: Any]) {
        if let definition = json["definition"] as? String {
            self.definition = definition
        }else {
            self.definition = "Empty"
        }
        if let example = json["example"] as? String {
            self.example = example
        }else {
            self.example = "Empty"
        }
    }
}
struct MMeaning {
    let definitions: [Definition]
    let partOfSpeech: String
    let synonyms: [String]
    init (json : [String : Any]) {
        if let partOfSpeech = json["PartOfSpeech"] as? String {
            self.partOfSpeech = partOfSpeech
        }else {
            self.partOfSpeech = "Empty"
        }
        if let synonyms = json["Synonyms"] as? [Any] {
            var t_synonyms: [String] = []
            for ele in synonyms {
                if let pot_synonym = ele as? String {
                    t_synonyms.append(pot_synonym)
                    print(pot_synonym)
                }
            }
            self.synonyms = t_synonyms
        }else {
            //print("Not being called")
            self.synonyms = []
        }
        if let j_definitions = json["Definitions"] as? [Any] {
            var definitions: [Definition] = []
            for definition in j_definitions {
                if let t_definition = definition as? [String: Any] {
                    let f_definition = Definition(json: t_definition)
                    definitions.append(f_definition)
                }
            }
            self.definitions = definitions
        }else {
            self.definitions = []
        }
    }
}


