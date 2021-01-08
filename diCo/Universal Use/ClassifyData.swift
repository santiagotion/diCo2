//
//  ClassifyData.swift
//  diCo
//
//  Created by Samsony Tuala on 1/8/21.
//  Copyright © 2021 lgdev. All rights reserved.
//

import Foundation

struct RecentlyClass {
    let word: String
    let audio: String
    let date: NSDate
    let meanings: [MMeaning]
    init (wordData: Word) {
        self.word = wordData.word
        self.audio = wordData.audio
        self.date = NSDate(timeIntervalSinceReferenceDate: wordData.date)
        self.meanings = wordData.meanings
    }
}
