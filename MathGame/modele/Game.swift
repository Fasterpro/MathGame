//
//  Game.swift
//  MathGame
//
//  Created by Martin Ménard on 2019-09-24.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

import Foundation

class Game { // Variable
    var secondButton = 1
    var operationButton = 1
    var avgButton = 1
    var minButton = 1
    var maxButton = 1
    var pourcent = 0.00
    
    var answer = 0 // answer in game
    var yourAnswer = 0 // send your answer value
    var endGameVar = 30 // value off answer operation
    var answerOperation = 0
    var clicendGame = 0
    
   //DuringGame
    var number1 = 0
    var number2 = 0
    
    //TimerGame
    var timerInGame: Timer?
    var timeCountGame: Timer?
    var timecountdown: Float = 0
    var timecountUp: Float = 0.00
    var timeAvgDown: Timer?
    var timeAvgTot: Float = 0
    var timeInterval = 0 // in future update
    
    //DefaultSettings
    var defaultselectRangeMin = 0
    var selectRangeMax = 0
    var defaultTimeGame = 0
    var defaultmode = ""
    
    //Settings
    var gamedone = false
    var operation = ""
    var modePlus = true
    var modeMinus = false
    var modeMultiplication = false
    var modeDivision = false
    var modeAll = false
    var modeOperationLanscape = false
    var modeAverageKillGame = false
    var modeKillGame = false
    var modeMix = false
    var portraitLanscape = true
    
    // SETTINGS VARIABLE
    var timegame: Float = 60.000
    var endGameDefault: Int = 30
    var answerVar: Int = 0
    var minNum: Int = 2
    var maxNum: Int = 10
    var avgtimemode:Float = 5.0
    var switchTime = false
    var switchAnswer = false
    var switchAvg = false
    var switchSD = false
    var switchPractice = false
    
    //Stats
    var pourcentOfAnswer = 0.0000 // in future update
    var goodAnswer = 0.00          // super calcul
    var badAnswer = 0
    var averagetime = 0
    var scorepts = 0.00
    var avgStoreData = 0
    var answerGameStoreData = 0
    var apm = 0.00
    var avgRythme = 0.00
    var hassard = 0
    var lessonNum = 6
    var ptstime = 0.00
    var minplaypts = 0.00
    var randomMode = 0
    var randomDivision = 0
    
    //new var time test
    var minutes = 0
    var secondes = 0

    // STORE SAUVEGARDE
    var point = 0
    var superNum = 0
}

extension Game {
    func timerPause() { //OK
        timerInGame?.invalidate()
        timeCountGame?.invalidate()
        timeAvgDown?.invalidate()
    }
    
}
// Func
extension Game {
    
    func addAnswer() { //OK
        answerOperation += 1
    }

    func addGoodAnswer() { //OK
        goodAnswer += 1
    }
    
    func statscurrentGame() { //OK
         answerVar = endGameDefault
         answerOperation = 0
         goodAnswer = 0
         
     }
}

extension Game { // NewGame
   
    func resetNewGame() { //OK
        scorepts = 0
        avgRythme = 0
        timecountUp = 0
        goodAnswer = 0
    }
    
    func randomNumber1Number2() { //OK
        number1 = Int.random(in: minNum ... maxNum)
        number2 = Int.random(in: minNum ... maxNum)
    }
    
    func randomNumber2minusNumber1() { //OK
        number2 = Int.random(in: minNum ... maxNum)
        number1 = Int.random(in: number2 ... maxNum)
    }
    
    
    func randomNumber12() {
    hassard = Int.random(in: 1 ... 2)
    
    if hassard == 1 {
        number1 = lessonNum
        number2 = Int.random(in: minNum ... maxNum)
    } else {
        number2 = lessonNum
        number1 = Int.random(in: minNum ... maxNum)
    }
    }
    
    func randomNumberDivision() {
        randomDivision = maxNum
        number2 = Int.random(in: minNum ... randomDivision)
    }

    func converterSectoMin() { //OK
        minutes = Int((timecountdown / 60)) % 60
        secondes = (Int(timecountdown) % 60)
    }

    func scoreGame() { //OK
        if goodAnswer == 0 {
            pourcentOfAnswer = 0.000001
        }else if goodAnswer == 1 {
            scorepts = 1
        } else {
        apm = 60 / avgRythme
        pourcentOfAnswer = Double(goodAnswer) / Double(answerOperation)
        scorepts = Double(pourcentOfAnswer) * Double(apm) * Double(goodAnswer)
        scorepts *= 100
    }
    }
    func scoreGame2() {
    avgRythme = Double(timecountUp) / goodAnswer
         apm = 60 / avgRythme
         pourcent = goodAnswer / Double(answerOperation) * 100
         scorepts = Double(pourcent) * Double(apm) * Double(goodAnswer)
    }
    func upSecond() {
                   secondButton += 1
               }

               func upOperation() {
                   operationButton += 1
               }

               func upAvg() {
                   avgButton += 1
               }

    func upMin() {
    minButton += 1
    }
    
    func upMax() {
    maxButton += 1
    }
    
} // End Code
