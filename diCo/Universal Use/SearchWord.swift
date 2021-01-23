//
//  SearchWord.swift
//  diCo
//
//  Created by Samsony Tuala on 1/16/21.
//  Copyright © 2021 lgdev. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Searcher {
    static var found: Bool!
    static var wordo: [Meanings]!
    
    static func searchWordOnLine (_ word : String){
       
        var ref:DatabaseReference?
        ref = Database.database().reference()
       
        
        let urll = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        let manager:MainDataManager = MainDataManager()
        var m_count = 1
        manager.getData(from: urll) { (results:[Meanings]) in
            
            var audio = ""
            
//            var results2: [Meanings]
            if(results.count > 0)
            {
                
                print(results)
//
             
                audio = results[0].audio
                ref?.child(word).child("Word").setValue(word)
                ref?.child(word).child("Audio").setValue(audio)
                ref?.child(word).child("Date").setValue(NSDate().timeIntervalSinceReferenceDate)
                ref?.child(word).child("Frequency").setValue(1)
                
//                let worObject = [
//                    "Word": word,
//                    "Audio":audio,
//                    "Date": NSDate().timeIntervalSinceReferenceDate,
//                    "Frequency": 1,
//                    "Meanings": results[0].meanings,
//
//
//
//                ] as [String : Any]
//
//                ref?.child(word).setValue(worObject)
                
//                print(worObject)
                
                for meaning in results
                {
                    //self.data.append(meani.partOfSpeech)
                    //self.data.append(meani.meanings[0].synonyms[0])
                    //print(self.data)
                    //print(meaning.partOfSpeech)
                    ref?.child(word).child("Meanings").child("\(m_count)").child("PartOfSpeech").setValue(meaning.partOfSpeech)
                    var d_count = 1
                    for definition in meaning.meanings
                    {
                        ref?.child(word).child("Meanings").child("\(m_count)").child("Definitions").child("\(d_count)").child("definition").setValue(definition.definition)
                        ref?.child(word).child("Meanings").child("\(m_count)").child("Definitions").child("\(d_count)").child("example").setValue(definition.example)
                        var s_count = 1;
                        for synonym in definition.synonyms
                        {
                            ref?.child(word).child("Meanings").child("\(m_count)").child("Synonyms").child("\(s_count)").setValue(synonym)
                            s_count = s_count+1
                        }
                        d_count = d_count+1
                    }
                    m_count = m_count + 1
                }
                
            }
        }
        //return manager.wordFound
    }
    
}
