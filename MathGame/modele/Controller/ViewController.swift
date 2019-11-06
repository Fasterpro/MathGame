//
//  ViewController.swift
//  MathGame
//
//  Created by Martin Ménard on 2019-09-24.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var game = Game()
    var savegame = SaveGame()

    @IBOutlet weak var test: UILabel!

    @IBAction func unwindToMenu(segue:UIStoryboardSegue) {
    }

    override func viewDidLoad() {
        savegame.reloadhighScore()
     //  music.musicInGame()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuToSettingData" {
            let successVCD = segue.destination as! SettingViewController
            successVCD.game = game
            }else if  segue.identifier == "MenuToStats" {
                   let successVCD = segue.destination as! StatsViewController
                   successVCD.game = game
        }
    }
} // End Code
