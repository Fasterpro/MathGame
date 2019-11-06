// MARK: - APPLICATION
//  GameViewController.swift
//  MathGame
//
//  Created by Martin Ménard on 2019-09-24.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//
//OBJECTIF
// - UIALERT Reset data
// refaire tous le design P1-
// game redirection vers Stats variable du nombre de temps total en ajoutant le temps dep ause etc.. a suivre
// Best Time sur 1 operations

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {

    // MARK: - VAR

    var savegame = SaveGame()
    var game = Game()
    var test = 0
    var backGroundGameImage = UIImage(named: "good")

    // MARK: - OUTLET

    @IBOutlet weak var finishGame: UIView!
    @IBOutlet weak var goodAnswer: UILabel!
    @IBOutlet weak var timeGame: UILabel!
    @IBOutlet weak var numberOfOperationDone: UILabel!
    @IBOutlet weak var firstNumber: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var secondNumber: UILabel!
    @IBOutlet weak var rep: UILabel!
    @IBOutlet weak var correctanswer: UILabel!
    @IBOutlet weak var repkeyboardsend: UILabel!
    @IBOutlet weak var correctOrWrongImage: UIImageView!
    @IBOutlet weak var gameisOver: UILabel!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var answerGameCountDown: UILabel!
    @IBOutlet weak var avgTimerCountDown: UILabel!
    @IBOutlet weak var operatorLanscapeStackView: UIStackView!
    @IBOutlet weak var lanscapeNumber1: UILabel!
    @IBOutlet weak var lanscapeNumber2: UILabel!
    @IBOutlet weak var goView: UIView!
    @IBOutlet weak var stackOperation: UIStackView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var operationLabelLandscape: UILabel!
    @IBOutlet weak var newHighScoreLabel: UILabel!
    @IBOutlet weak var goGame: UIButton!

    @IBAction func pausegame() {
        game.timerPause()
    }
    
     // MARK: - KEYBOARD OUTLET

    @IBAction func numbers(_ sender: UIButton) {
        answerLabel.text = answerLabel.text! + String(sender.tag)
    }
    
    @IBAction func backSpace(_ sender: UIButton) {
        answerLabel.text = ""
    }

    // MARK: - VIEWDIDLOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        savegame.reloadhighScore()
        viewLoadFormat()
        hiddenViewLoad()
        resetNewGame()
        answerGameCount()
    }

    func viewLoadFormat() {
        stackOperation.isHidden = true
        operatorLanscapeStackView.isHidden = true
        goView.isHidden = false
        correctOrWrongImage.isHidden = true
        answerLabel.isHidden = false
        rep.isHidden = true
        finishGame.isHidden = true
    }

    func hiddenViewLoad() {
        goView.alpha = 0.1
        goGame.alpha = 1.0
        answerLabel.text = "Appuyer sur GO pour débuter la partie!"
        answerLabel.font = answerLabel.font.withSize(15)
    }

    func resetNewGame() {
        game.resetNewGame()
        avgTimerCountDown.text = "0"
        game.scoreGame()
    }

    func answerGameCount() {
        game.answerVar = game.endGameDefault
        if game.switchAnswer == false {
            answerGameCountDown.isHidden = false
            answerGameCountDown.text = ("\(game.answerVar)")
        } else {
            answerGameCountDown.text = "♾"
        }
    }

    func conditionOperator() { //addition refactor
        if game.modeAll == true {
            if game.randomMode == 1 {
                modeAdditionCondition()
            }
            else if game.randomMode == 2 {
                modeMinusCondition()
            }
            else if game.randomMode == 3 {
                reloadANewOperationMultiplication()
            }
            else if game.randomMode == 4 {
                modeDivisionCondition()
            }
        }else {
            if game.modePlus == true {
                modeAdditionCondition()
            }
            if game.modeMinus == true {
                modeMinusCondition()
            }
            if game.modeMultiplication == true {
                reloadANewOperationMultiplication()
            }
            if game.modeDivision == true {
                modeDivisionCondition()
            }
        }
    }

  // MARK: - BUTTON GO GAME ACTION START GAME

    @IBAction func goGame(_ sender: Any) {
        startGameGoHide()
        game.statscurrentGame()
        operatorPortraitLanscape()
        TimeGame()
        avgTimerGame()
        game.timecountdown = game.timegame
        game.randomMode = Int.random(in: 1 ... 4)
        conditionOperator()
    }

    func startGameGoHide(){
        answerLabel.text = ""
        answerLabel.font = answerLabel.font.withSize(40)
        goView.isHidden = true
        goGame.isHidden = true
    }

    func operatorPortraitLanscape() {
        if game.modeOperationLanscape == true {
            operatorLanscapeStackView.isHidden = false
            stackOperation.isHidden = true
        } else {
            operatorLanscapeStackView.isHidden = true
            stackOperation.isHidden = false
        }
    }

    // MARK: - FUNC

    func reloadANewOperationMultiplication() {
        operationLabel.text = "x"
        operationLabelLandscape.text = "x"
        if game.switchPractice == true {
        game.hassard = Int.random(in: 1 ... 2)
            if game.hassard == 1 {
                multiplicationtextShow()
            } else {
                multiplicationtextShow2()
            }
        }else {
            game.randomNumber1Number2()
            textNumberShow() 
        }
    }

    func multiplicationtextShow() {
        game.number1 = game.lessonNum
        firstNumber.text = ("\(game.number1)")
        lanscapeNumber1.text = ("\(game.number1)")
        game.number2 = Int.random(in: game.minNum ... game.maxNum)
        secondNumber.text = ("\(game.number2)")
        lanscapeNumber2.text = ("\(game.number2)")
    }
    func multiplicationtextShow2() {
        game.number2 = game.lessonNum
        secondNumber.text = ("\(game.number2)")
        lanscapeNumber2.text = ("\(game.number2)")
        game.number1 = Int.random(in: game.minNum ... game.maxNum)
        firstNumber.text = ("\(game.number1)")
        lanscapeNumber1.text = ("\(game.number1)")
    }

    func newHighScore() {
        savegame.gameHighScore = UserDefaults.standard.double(forKey: "score")
        if Double(game.scorepts) <= savegame.gameHighScore {
            // erreur ici.. a double
        } else {
            savegame.gameHighScore = Double(game.scorepts)
        }
    }

    func EndGameRedirection() {
        ShowScore()
        performSegue(withIdentifier: "GameToStatsData", sender: Any?.self)
    }

    func endGame() {
        if game.answerOperation == game.endGameDefault {
            game.gamedone = true
            newHighScore()
            stackOperation.isHidden = true
            operatorLanscapeStackView.isHidden = true
            buttonSend.isHidden = true
            answerLabel.isHidden = true
            game.timerPause()
            finishGame.isHidden = false
            avgTimerCountDown.text = NSString(format: "%.1f", game.avgRythme) as String
            EndGameRedirection()
        }
    }

            // MARK: - TIMER CountDOWN

    func convertTimeGame() { //func  game coté modele aussi !!
           if game.timecountdown >= 60 {
                game.converterSectoMin()
                timeGame.text = ("\(game.minutes)" + " m " + ("\(game.secondes)") + " s")
              }
          }
    func convertTimeGamedeux() {
           if game.timecountUp >= 60 {
               game.converterSectoMin()
               timeGame.text = ("\(game.minutes)" + " m " + ("\(game.secondes)") + " s")
              }
          }

    @objc private func timerDidEnded() {
        game.timecountdown -= 0.01
        convertTimeGame()
        avgPro()
        if game.timecountdown <= 0 {
            game.gamedone = false
            newHighScore()
            buttonSend.isHidden = true
            answerLabel.isHidden = true
            gameisOver.text = ("\(test)"+"reponse par secondes ")
            timeGame.text = "0"
            finishGame.isHidden = false
            game.timerPause()
            avgTimerCountDown.text = NSString(format: "%.1f", game.avgRythme) as String
            EndGameRedirection()
        }
    }

    func timerGame() {
        game.timerInGame = Timer.scheduledTimer(timeInterval: 0.01, target: self,
        selector: #selector(timerDidEnded), userInfo: nil, repeats: true)
     }

        // MARK: - AVG TIMER FUNC PRO AVG

    func avgPro() {
            if game.switchAvg == false {
                if game.goodAnswer == 0 {
                 avgTimerCountDown.text = NSString(format: "%.1f", game.timecountUp) as String
                }
                    else if game.goodAnswer == 1 {
                    game.avgRythme = Double(Float(game.timecountUp) / Float(game.goodAnswer))
                                   avgTimerCountDown.text = NSString(format: "%.1f", game.avgRythme) as String


                }else if game.goodAnswer >= 2 {
                    game.avgRythme = Double(Float(game.timecountUp) / Float(game.goodAnswer))
                    avgTimerCountDown.text = NSString(format: "%.1f", game.avgRythme) as String
                }
        }
    }

        // MARK: - TIMER CountUP

    @objc private func timerUpCount() {
        game.timecountUp += 0.01
        avgPro()
        if game.switchTime == true {
            timeGame.text = NSString(format: "%.1f", game.timecountUp) as String
            convertTimeGamedeux()
        }else {
          timeGame.text = NSString(format: "%.1f", game.timecountdown) as String
        }
    }

     func timeUpGame() {
        game.timeCountGame = Timer.scheduledTimer(timeInterval: 0.01, target: self,
         selector: #selector(timerUpCount), userInfo: nil, repeats: true)
      }

          // MARK: - TIMER AVG TIME

    @objc private func timeravgtime() {
         game.timeAvgTot -= 0.01

        if game.timeAvgTot <= 0 {
            game.gamedone = true
            avgTimerCountDown.text = "0.00"
            newHighScore()
            buttonSend.isHidden = true
            answerLabel.isHidden = true
            game.goodAnswer = 1
            gameisOver.text = ("\(test)"+"reponse par secondes ")
            finishGame.isHidden = false
            game.timerPause()
            avgTimerCountDown.text = NSString(format: "%.1f", game.avgRythme) as String
            EndGameRedirection()
        } else {
            game.avgRythme = Double(game.timecountUp) / game.goodAnswer
            avgTimerCountDown.text = NSString(format: "%.1f", game.avgRythme) as String
        }

     }

     func timeAvgDown() {
         game.timeAvgDown = Timer.scheduledTimer(timeInterval: 0.01, target: self,
         selector: #selector(timeravgtime), userInfo: nil, repeats: true)
      }

        // MARK: - BUTTON

    func answerCall() {
        if game.switchAnswer == true {
            answerLabel.text = ""
            answerGameCountDown.text = "♾"
            game.answerOperation += 1
            game.addAnswer()
            numberOfOperationDone.text = ("\(game.answerOperation)")
            goodAnswer.text  = NSString(format: "%.0f", game.goodAnswer) as String
            game.randomMode = Int.random(in: 1 ... 4)
            conditionOperator()
        } else {
            answerLabel.text = ""
            game.addAnswer()
            numberOfOperationDone.text = ("\(game.answerOperation)")
            game.answerVar -= 1
            goodAnswer.text  = NSString(format: "%.0f", game.goodAnswer) as String
            answerGameCountDown.text = ("\(game.answerVar)")
            endGame()
            game.randomMode = Int.random(in: 1 ... 4)
            conditionOperator()
        }
    }

    var pourcent = 0.00

    func ShowScore() {
        game.avgRythme = Double(game.timecountUp) / game.goodAnswer
        game.apm = 60 / game.avgRythme
        pourcent = game.goodAnswer / Double(game.answerOperation) * 100
        game.scorepts = Double(pourcent) * Double(game.apm) * Double(game.goodAnswer)
        scoreLabel.text = NSString(format: "%.0f", game.scorepts) as String
    }

    func iftextempty() {
        wrongImage()
        correctanswer.text = "DAErreur no entry"
        suddenDeathMode()
        answerCall()
        ShowScore()
    }

    func elsegoodanswer() {
        game.timeAvgDown?.invalidate()
        avgTimerCountDown.text = NSString(format: "%.1f", game.avgtimemode) as String
        avgTimerGame()
        correctImage()
        correctanswer.text = "Correct"
        game.addGoodAnswer()
        answerCall()
        ShowScore()
    }

    func elsewronganswer() {
        wrongImage()
        correctanswer.text = "Erreur"
        suddenDeathMode()
        answerCall()
        ShowScore()
    }

    func loopAnswer() {
        let vermitalo = answerLabel.text!
        game.yourAnswer = Int(vermitalo) ?? 0
        repkeyboardsend.text = ("\(vermitalo)")
        rep.text = ("\(game.answer)")
        if answerLabel.text?.isEmpty ?? true {
            iftextempty()
            return

        } else {
            if game.answer == game.yourAnswer {
                elsegoodanswer()
        } else {
            elsewronganswer()
        }
        }
    }

    func plusmode() {
        game.answer = game.number1 + game.number2
        loopAnswer()
    }

    func minusmode() {
        game.answer = game.number1 - game.number2
        loopAnswer()
    }

    func multiplymode() {
        game.answer = game.number1 * game.number2
        loopAnswer()
    }

    func divisionmode() {
        game.answer = game.number1 / game.number2
        loopAnswer()
    }

    @IBAction func buttonResponse() {
        if game.modeAll == true {
            if game.randomMode == 1 {
                plusmode()
            }
            else if game.randomMode == 2 {
                minusmode()
            }
            else if game.randomMode == 3 {
                multiplymode()
            }
            else if game.randomMode == 4 {
                divisionmode()
            }
        }else {
        if game.modePlus == true {
            plusmode()
        }
        if game.modeMinus == true {
           minusmode()
        }
        if game.modeMultiplication == true {
           multiplymode()
        }
        if game.modeDivision == true {
            divisionmode()
            }
        }
    }

    // MARK: - Image Answer
    func imageConfig() { // ici refactorisé
        correctOrWrongImage.alpha = 1.0
        correctOrWrongImage.isHidden = false
        correctOrWrongImage.image = backGroundGameImage
    }

    func correctImage() {
        backGroundGameImage = #imageLiteral(resourceName: "goodanswer")
        imageConfig()
        UIView.animate(withDuration: 0.0, delay: 0.2, animations: {
            self.correctOrWrongImage.alpha = 0.0
         }){ (completed) in
        }
    }

    func wrongImage() {
        backGroundGameImage = #imageLiteral(resourceName: "badanswer")
        imageConfig()
        UIView.animate(withDuration: 0.0, delay: 0.8, animations: {
            self.correctOrWrongImage.alpha = 0.0
        }){(_ completed) in
        }
    }

 // MARK: - SEND DATA

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameToStatsData" {
            let successVCA = segue.destination as! StatsViewController
            successVCA.game = game
        } else if segue.identifier == "GameToSetting" {
            let successVCZ = segue.destination as! SettingViewController
            successVCZ.game = game
        }
    }

    func avgTimerGame() {
        if game.switchAvg == true {
            avgTimerCountDown.isHidden = false
            game.timeAvgTot = game.avgtimemode
            timeAvgDown()
            avgTimerCountDown.text = ("\(game.timeAvgTot)")
        } else {
          avgTimerCountDown.text = ("\(game.avgRythme)")
        }
    }

    func TimeGame() {
        if game.switchTime == false {
            timeGame.isHidden = false
            timerGame()
            timeUpGame()
            timeGame.text = ("\(game.timecountdown)")
        } else {
            timeUpGame()
            avgTimerCountDownRythme()
            timeGame.text = ("\(game.timecountUp)")
        }
    }

    func answerGameFinish() {
        if game.endGameDefault - game.answerOperation <= 0 {
            endGame()
        }
    }

    func suddenDeathMode() { // Timer Func!
        if game.switchSD == true {
            buttonSend.isHidden = true
            answerLabel.isHidden = true
            game.timerPause()
            // test = 20 / game.goodAnswer + 1
            finishGame.isHidden = false
            EndGameRedirection()
               }
    }

    func avgTimerCountDownRythme() {
        if game.goodAnswer <= 1 {
            avgTimerCountDown.text = ("\(game.timecountUp)")
        }else {
            game.avgRythme = (Double(Int(game.timecountUp)) / game.goodAnswer)
            avgTimerCountDown.text = ("\(game.avgRythme)")
        }
    }

    func modeMinusCondition() {
        operationLabel.text = "-"
        operationLabelLandscape.text = "-"
    if game.switchPractice == true {
          game.hassard = Int.random(in: 1 ... 2)
              if game.hassard == 1 {
                    game.randomNumber2minusNumber1()
                  game.number1 = game.lessonNum
                 textNumberShow()

              } else {
                    game.randomNumber2minusNumber1()
                  game.number2 = game.lessonNum
                  textNumberShow()
              }
          }else {
                game.randomNumber2minusNumber1()
                textNumberShow()
          }
        }

    func modeDivisionCondition() { // mode divison lesson...
        operationLabel.text = "÷"
        operationLabelLandscape.text = "÷"
        game.randomDivision = game.minNum
        game.number2 = Int.random(in: game.minNum ... game.maxNum)
        game.randomDivision = Int.random(in: game.minNum ... game.maxNum)
        game.number1 = game.number2 * game.randomDivision
        textNumberShow()
    }

    func modeAdditionCondition() {
        game.randomNumber1Number2()
        textNumberShow()
        operationLabel.text = "+"
        operationLabelLandscape.text = "+"
    }

    func textNumberShow() {
        firstNumber.text = ("\(game.number1)")
        lanscapeNumber1.text = ("\(game.number1)")
        secondNumber.text = ("\(game.number2)")
        lanscapeNumber2.text = ("\(game.number2)")
        }
    } // End Code
