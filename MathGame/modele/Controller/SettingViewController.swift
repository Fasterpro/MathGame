//
//  SettingViewController.swift
//  MathGame
//
//  Created by Martin Ménard on 2019-09-25.
//  Copyright © 2019 Martin Ménard. All rights reserved.
//

// CRÉÉER UNE ERREUR SI ON MET LE MEME NOMBRE.. ou ADD 1...
import UIKit

class SettingViewController: UIViewController {

    // MARK: - VAR

    var savegame = SaveGame()
    var game = Game()

// MARK: - VIEW DID LOAD

    override func viewDidLoad() {
        savegame.reloadhighScore()
        SavedSettingsInTime()
        SwitchActivateData()
        switchPortraitLanscape()
        operatorselector()
        minSelector()
        maxSelector()
    }

// MARK: - OUTLET

    @IBOutlet weak var portraitLanscapeButton: UISegmentedControl!
    @IBOutlet weak var plusMinusMultiDivisionButton: UISegmentedControl!
    @IBOutlet weak var switchInfiniteTime: UISwitch!
    @IBOutlet weak var timeGameSelect: UILabel!
    @IBOutlet weak var operationSelect: UILabel!
    @IBOutlet weak var switchInfiniteAnswer: UISwitch!
    @IBOutlet weak var switchAVGmode: UISwitch!
    @IBOutlet weak var switchSDmode: UISwitch!
    @IBOutlet weak var switchPraticeOnly: UISwitch!
    @IBOutlet weak var avgSelect: UILabel!
    @IBOutlet weak var plusTimeOutlet: UIButton!
    @IBOutlet weak var plusOperatorOutlet: UIButton!
    @IBOutlet weak var plusAvgOutlet: UIButton!
    @IBOutlet weak var sliderLesson: UISlider!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!

    // MARK: - BUTTON AND OTHER

    @IBAction func portraitLandscapeGame(_ sender: Any) {
        switch portraitLanscapeButton.selectedSegmentIndex {
            case 0:
                game.modeOperationLanscape = false
            case 1:
                game.modeOperationLanscape = true
            default:
                break
            }
    }
 
    @IBAction func modeInfiniTime(_ sender: Any) {
        if switchInfiniteTime.isOn {
            game.switchTime = true
            plusTimeOutlet.isEnabled = false
            timeGameSelect.text = "Infini"
        } else {
            game.switchTime = false
            plusTimeOutlet.isEnabled = true
           timeSelection()
            convertTimeGame()
        }
    }

    @IBAction func modeInfiniAnswer(_ sender: Any) {
        if switchInfiniteAnswer.isOn {
            game.switchAnswer = true
            plusOperatorOutlet.isEnabled = false
            operationSelect.text = "infini"
        } else {
            game.switchAnswer = false
            plusOperatorOutlet.isEnabled = true
            operationSelector()
        }
    }

    @IBAction func plusMinusmultidivisionMix(_ sender: Any) {
        switch plusMinusMultiDivisionButton.selectedSegmentIndex {
           case 0:
                game.modePlus = true
                game.modeMinus = false
                game.modeMultiplication = false
                game.modeDivision = false
                game.modeAll = false
           case 1:
                game.modePlus = false
                game.modeMinus = true
                game.modeMultiplication = false
                game.modeDivision = false
                game.modeAll = false
            case 2:
                game.modePlus = false
                game.modeMinus = false
                game.modeMultiplication = true
                game.modeDivision = false
                game.modeAll = false
            case 3:
                game.modePlus = false
                game.modeMinus = false
                game.modeMultiplication = false
                game.modeDivision = true
                game.modeAll = false
            case 4:
                game.modePlus = false
                game.modeMinus = false
                game.modeMultiplication = false
                game.modeDivision = false
                game.modeAll = true
            default:
                break
            }
    }

    @IBAction func switchAvg(_ sender: Any) {
        if switchAVGmode.isOn{
            game.switchAvg = true
            avgSelector()
            plusAvgOutlet.isEnabled = true

            } else {
            game.switchAvg = false
            avgSelect.text = ""
            plusAvgOutlet.isEnabled = false
            }
    }

    @IBAction func switchSdMode(_ sender: Any) {
        if switchSDmode.isOn{
            game.switchSD = true
            } else {
            game.switchSD = false
            }
    }

    @IBAction func switchPratice(_ sender: Any) {
        if switchPraticeOnly.isOn{
            game.switchPractice = true
            sliderLesson.isEnabled = true
            sliderLesson.value = Float(Int(game.lessonNum))
            lessonLabel.text = ("\(game.lessonNum)")
        } else {
            game.switchPractice = false
            sliderLesson.isEnabled = false
            lessonLabel.text = ""
        }
    }

    @IBAction func lessonSliderValue(_ sender: Any) {
        game.lessonNum = Int(sliderOutlet.value)
        lessonLabel.text = ("\(game.lessonNum)")
    }

// MARK: - Default Value

    @IBAction func defaultvaluebutton() { // all false quand do a func to this in the modele
        game.secondButton = 1
        timeGameSelect.text = "30 secondes"
        game.operationButton = 1
        operationSelect.text = "10 opérations"
        switchInfiniteTime.isOn = false
        game.switchTime = false
        avgSelect.text = ""
        portraitLanscapeButton.selectedSegmentIndex = 0
        plusMinusMultiDivisionButton.selectedSegmentIndex = 0
        convertTimeGame()
        switchInfiniteAnswer.isOn = false
        game.switchAnswer = false
        switchAVGmode.isOn = false
        game.switchAvg = false
        switchSDmode.isOn = false
        game.switchSD = false
        game.switchPractice = false
    }

// MARK: - PREPARE FOR SEGUE

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingToGameData" {
            let successVC = segue.destination as! GameViewController
            successVC.game = game
        } else if segue.identifier == "SettingToMenuData" {
            let successVCC = segue.destination as! ViewController
            successVCC.game = game
        }
    }

// MARK: - FUNCTION
    
    func switchPortraitLanscape() {
        if game.modeOperationLanscape == true { portraitLanscapeButton.selectedSegmentIndex = 1
        } else {
            portraitLanscapeButton.selectedSegmentIndex = 0
        }
    }

    func operatorselector() {
        if game.modePlus == true {
            plusMinusMultiDivisionButton.selectedSegmentIndex = 0
        }else if game.modeMinus == true {
            plusMinusMultiDivisionButton.selectedSegmentIndex = 1
        }else if game.modeMultiplication == true {
            plusMinusMultiDivisionButton.selectedSegmentIndex = 2
        }else if game.modeDivision == true {
            plusMinusMultiDivisionButton.selectedSegmentIndex = 3
        }else if game.modeAll == true {
            plusMinusMultiDivisionButton.selectedSegmentIndex = 4
        }
    }

func SwitchActivateData() {
    if game.switchTime == true {
        switchInfiniteTime.isOn = true
        plusTimeOutlet.isEnabled = false
         timeGameSelect.text = "Infini"

    } else {
        switchInfiniteTime.isOn = false
        plusTimeOutlet.isEnabled = true
        timeSelection()
        convertTimeGame()
    }

    if game.switchAnswer == true {
        switchInfiniteAnswer.isOn = true
        operationSelect.text = "infini"
        plusOperatorOutlet.isEnabled = false

    } else {
        switchInfiniteAnswer.isOn = false
        plusOperatorOutlet.isEnabled = true
        operationSelector()
    }
 
    if game.switchAvg == true {
        switchAVGmode.isOn = true
        avgSelector()
        plusAvgOutlet.isEnabled = true

        } else {
        switchAVGmode.isOn = false
        avgSelect.text = ""
        plusAvgOutlet.isEnabled = false
        
        }

    if game.switchSD == true {
        switchSDmode.isOn = true
        } else {
            switchSDmode.isOn = false
        }

    if game.switchPractice == true {
        switchPraticeOnly.isOn = true
        sliderLesson.isEnabled = true
        sliderLesson.value = Float(Int(game.lessonNum))
        lessonLabel.text = ("\(game.lessonNum)")
       
    } else {
        switchPraticeOnly.isOn = false
        sliderLesson.isEnabled = false
        lessonLabel.text = ""
        
    }
    }

    func random(nnn:Int) -> Int {
          return Int(arc4random_uniform(UInt32(2)))
    }

    func SavedSettingsInTime() {
        convertTimeGame()
    }

    func convertTimeGame() {
        if game.timegame >= 60 {
            game.minutes = Int((game.timegame / 60)) % 60
            game.secondes = (Int(game.timegame) % 60)
          
           }
       }

    func timeSelection() {
        if game.secondButton == 1 {
            timeGameSelect.text = "30 secondes"
            game.timegame = 30
        }
        if game.secondButton == 2 {
            timeGameSelect.text = "1 minute"
            game.timegame = 60
        }
        if game.secondButton == 3 {
            timeGameSelect.text = "2 minutes"
            game.timegame = 120
        }
        if game.secondButton == 4 {
            timeGameSelect.text = "5 minutes"
            game.timegame = 300
        }
        if game.secondButton == 5 {
            timeGameSelect.text = "10 minutes"
            game.timegame = 600
        }
        if game.secondButton == 6 {
            timeGameSelect.text = "30 minutes"
            game.timegame = 1800
        }
        if game.secondButton == 7 {
            timeGameSelect.text = "1 heure"
            game.timegame = 3600
            game.secondButton = 0
        }
    }

    func operationSelector() {
        if game.operationButton == 1 {
            operationSelect.text = "10 opérations"
            game.endGameDefault = 10
        }
        if game.operationButton == 2 {
            operationSelect.text = "20 opérations"
            game.endGameDefault = 20
        }
        if game.operationButton == 3 {
            operationSelect.text = "50 opérations"
            game.endGameDefault = 50
        }
        if game.operationButton == 4 {
            operationSelect.text = "100 opérations"
            game.endGameDefault = 100
        }
        if game.operationButton == 5 {
            operationSelect.text = "1000 opérations"
            game.endGameDefault = 1000
            game.operationButton = 0
        }

    }

    func avgSelector() {
        if game.avgButton == 1 {
            avgSelect.text = "1 sec / rep"
            game.avgtimemode = 1
        }
        if game.avgButton == 2 {
            avgSelect.text = "2 sec / rep"
            game.avgtimemode = 2
        }
        if game.avgButton == 3 {
            avgSelect.text = "3 sec / rep"
            game.avgtimemode = 3
        }
        if game.avgButton == 4 {
            avgSelect.text = "5 sec / rep"
            game.avgtimemode = 5
        }
        if game.avgButton == 5 {
            avgSelect.text = "7 sec / rep"
            game.avgtimemode = 7
        }
        if game.avgButton == 6 {
            avgSelect.text = "10 sec / rep"
            game.avgtimemode = 10
        }
        if game.avgButton == 7 {
            avgSelect.text = "20 sec / rep"
            game.avgtimemode = 20
        }
        if game.avgButton == 8 {
            avgSelect.text = "30 sec / rep"
            game.avgtimemode = 30
        }
        if game.avgButton == 9 {
            avgSelect.text = "60 sec / rep"
            game.avgtimemode = 60
            game.avgButton = 0
        }
    }

    func minSelector() {
        if game.minButton == 1 {
            minLabel.text = "2"
            game.minNum = 2
        }
        if game.minButton == 2 {
            minLabel.text = "10"
            game.minNum = 10
        }
        if game.minButton == 3 {
            minLabel.text = "100"
            game.minNum = 100
        }
        if game.minButton == 4 {
            minLabel.text = "1000"
            game.minNum = 1000
            game.minButton = 0
        }

    }

    func maxSelector() {
        if game.maxButton == 1 {
            maxLabel.text = "12"
            game.maxNum = 12
        }
        if game.maxButton == 2 {
            maxLabel.text = "20"
            game.maxNum = 20
        }
        if game.maxButton == 3 {
            maxLabel.text = "50"
            game.maxNum = 50
        }
        if game.maxButton == 4 {
            maxLabel.text = "100"
            game.maxNum = 100
        }
        if game.maxButton == 5 {
            maxLabel.text = "1000"
            game.maxNum = 1000
        }
        if game.maxButton == 6 {
            maxLabel.text = "10000"
            game.maxNum = 10000
            game.maxButton = 0
        }
    }

    //MARK: - BUTTON
    
    @IBAction func timeGameButton(_ sender: Any) {
        game.upSecond()
        timeSelection()
    }

    @IBAction func operationGameButton(_ sender: Any) {
        game.upOperation()
        operationSelector()
    }

    @IBAction func avgSelectButton(_ sender: Any) {
        game.upAvg()
        avgSelector()
    }

    @IBAction func minPlusButton(_ sender: Any) {
        game.upMin()
        minSelector()
    }

    @IBAction func maxPlusButton(_ sender: Any) {
        game.upMax()
        maxSelector()
    }
} //end code
