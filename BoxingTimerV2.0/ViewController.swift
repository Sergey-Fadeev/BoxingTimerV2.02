//
//  ViewController.swift
//  BoxingTimerV2.0
//
//  Created by Sergey on 03.03.2021.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var PickerView: UIPickerView!

    @IBOutlet weak var relaxLabel: UILabel!
    @IBOutlet weak var timeRoundLabel: UILabel!
    @IBOutlet weak var roundCountLabel: UILabel!
    
    @IBAction func uwindToMainScreen(segue: UIStoryboardSegue){
        if segue.identifier == "unwindSegue"{
            viewDidLoad()
        }
    }
    
    var initialRoundDescriptor = RoundDescriptor(roundNum: 0, fightTime: 0, relaxTime: 0)
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let roundTimeValue =  self.PickerView.selectedRow(inComponent: 2)
        let relaxTimeValue = self.PickerView.selectedRow(inComponent: 1)
        let roundCountValue = self.PickerView.selectedRow(inComponent: 0)
        
        print(roundTimeValue)
        
        initialRoundDescriptor = RoundDescriptor(roundNum: roundsCount[roundTimeValue], fightTime:roundsTime[relaxTimeValue], relaxTime: relaxTime[roundCountValue])
        
        let dvc = segue.destination as! SecondViewController
        dvc.initialDescriptor = initialRoundDescriptor
    }
    
    
    func setupLabelText(){
        relaxLabel.textColor = UIColor.blue
        timeRoundLabel.textColor = UIColor.blue
        roundCountLabel.textColor = UIColor.blue
    }
    
    func setupPickerView(){
        PickerView.delegate = self
        PickerView.dataSource = self
        PickerView.selectRow(3, inComponent: 0, animated: false)
        PickerView.selectRow(5, inComponent: 1, animated: false)
        PickerView.selectRow(5, inComponent: 2, animated: false)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupLabelText()
    }
}



extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    var roundsCount: [Int] {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]}
    var roundsTime: [Int] {[5, 15, 30, 45, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360]}
    var relaxTime: [Int] {[15, 30, 45, 60, 90, 120, 150, 180]}
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return relaxTime.count
        case 1:
            return roundsTime.count
        default:
            return roundsCount.count        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(relaxTime[row])+" секунд"
        case 1:
            return String(roundsTime[row])+" секунд"
        default:
            if row >= 4{
                return String(roundsCount[row])+" раундов"
            }else if row == 0{
                return String(roundsCount[row])+" раунд"
            }else{
                return String(roundsCount[row])+" раунда"
            }
        }
    }
}

