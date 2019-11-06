//
//  SaveGame.swift
//  MathGame
//
//  Created by Martin Ménard on 2019-10-08.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

import Foundation

class SaveGame {

    var gameHighScore = 0.00
    
    func savehighScore() {
        UserDefaults.standard.set(gameHighScore, forKey: "score")
    }

    func reloadhighScore() {
        gameHighScore = UserDefaults.standard.double(forKey: "score")
    }
    func ErasehighScore() {
        gameHighScore = 0
        UserDefaults.standard.set(gameHighScore, forKey: "score")
    }
    
}
