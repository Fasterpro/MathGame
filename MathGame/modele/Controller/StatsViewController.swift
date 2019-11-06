//
//  StatsViewController.swift
//  MathGame
//
//  Created by Martin Ménard on 2019-09-25.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

import UIKit

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal

        return formatter
    }()
}
extension Double{
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

class StatsViewController: UIViewController {

    var game = Game()
    var savegame = SaveGame()
    let formatter = NumberFormatter()

    @IBOutlet weak var lastScore: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var modeGame: UILabel!
    @IBOutlet weak var timePlay: UILabel!
    @IBOutlet weak var answerOperator: UILabel!
    @IBOutlet weak var avgByAnswer: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var wrongAnswer: UILabel!
    @IBOutlet weak var pourcentOfGoodAnswer: UILabel!
    @IBOutlet weak var answerPerMin: UILabel!
    @IBOutlet weak var challengeCheck: UILabel!

    var test = 0.00
    var wrongOperator = 0.00
    var pourcent = 0.00
    var reppermin = 0.00


    @IBAction func resetHighScore() {
        savegame.ErasehighScore()
        highScore.text = ("\(savegame.gameHighScore)")
    }

    override func viewDidLoad() {
        scoreanswer()
        lastScore.text  = game.scorepts.formattedWithSeparator
        answerOperator.text = ("\(game.answerOperation)")
        gameend()
        test = Double(game.timecountUp) / game.goodAnswer
        reppermin = 60 / test
        avgByAnswer.text = NSString(format: "%.2f", test) as String
        answerPerMin.text = NSString(format: "%.2f", reppermin) as String
        correctAnswer.text = NSString(format: "%.0f", game.goodAnswer) as String
        wrongOperator = Double(game.answerOperation) - game.goodAnswer
        wrongAnswer.text = NSString(format: "%.0f", wrongOperator) as String
        pourcent = Double(game.goodAnswer) / Double(game.answerOperation) * 100
        pourcentOfGoodAnswer.text = NSString(format: "%.2f", pourcent) as String
        savegame.reloadhighScore()
        highScore.text = savegame.gameHighScore.formattedWithSeparator

        if Double(game.scorepts) >= savegame.gameHighScore { // ERREUR DOUBLE SI infini mode temps et operation
            savegame.gameHighScore = Double(game.scorepts)
            highScore.text = NSString(format: "%.0f", savegame.gameHighScore) as String
            savegame.savehighScore()
    }
        nogame()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StatsToMenuData" {
        let successVCG = segue.destination as! ViewController
        successVCG.game = game
        }
    }

    func scoreanswer() {
        game.scoreGame2()

    }
    func gameend() {
        if game.gamedone == true {
            timePlay.text = NSString(format: "%.2f", game.timecountUp) as String
        }
        else {
            timePlay.text = NSString(format: "%.0f", game.timegame) as String
        }
    }
    func nogame() {
        if game.answerOperation == 0 {
            timePlay.text = " "
            lastScore.text  = " "
            answerOperator.text = " "
            avgByAnswer.text = " "
            answerPerMin.text = " "
            correctAnswer.text = " "
            wrongAnswer.text = " "
            pourcentOfGoodAnswer.text = " "
    }
    }
} // End Code
