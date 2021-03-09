//
//  SecondViewController.swift
//  BoxingTimerV2.0
//
//  Created by Sergey on 03.03.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()

    }
    

    var initialDescriptor: RoundDescriptor? = nil
    
    
    func start(nextRoundNum: Int? = nil){
        displayedDescriptor = initialDescriptor!
        roundCount += 1
        roundCountLabel.text = "Раунд \(roundCount) из \(initialDescriptor!.roundNum)"
        
        if let nextRoundNum = nextRoundNum{
            displayedDescriptor.roundNum = nextRoundNum
        }
        
        if displayedDescriptor.roundNum > 0{
            startFightTimer()
        }
        else{
            finish()
        }
    }
    
    
    func finish(){
        
    }
    
    
    //MARK: UI
    var displayedDescriptor = RoundDescriptor(roundNum: 0, fightTime: 0, relaxTime: 0)
    
    
    @IBOutlet weak var roundTimeLabel: UILabel!
    
    
    @IBOutlet weak var roundCountLabel: UILabel!
    
    
    @IBOutlet weak var fighftOrRelaxLabel: UILabel!
    
    
    @IBOutlet var backgroundView: UIView!
    
    
    var roundCount = 0
    
    
    //MARK: FIGHT
    var fightTimer: Timer? = nil
    
    func startFightTimer(){
        fightTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fightTimerHandler), userInfo: nil, repeats: true)
    }
    
    
    func fightUIConstruct() {
        backgroundView.backgroundColor = UIColor.systemOrange
        fighftOrRelaxLabel.text = "Бой"
    }
    
    
    @objc func fightTimerHandler(){
        fightUIConstruct()
        fightUIUpdate()
        
        if displayedDescriptor.fightTime > 0{
            
            displayedDescriptor.fightTime -= 1
        }else{
            fightTimer?.invalidate()
            startRelaxTimer()
        }
    }
    
    
    func fightUIUpdate() {
        roundTimeLabel.text = String(displayedDescriptor.fightTime)
    }
    
    
    
    //MARK: RELAX
    
    var timerRelax: Timer? = nil
    
    
    func startRelaxTimer(){
        timerRelax = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(relaxTimerHandler), userInfo: nil, repeats: true)
    }
    
    
    func relaxUIConstruct() {
        backgroundView.backgroundColor = UIColor.gray
        fighftOrRelaxLabel.text = "Отдых"
    }
    
    
    @objc func relaxTimerHandler(){
        relaxUIConstruct()
        if displayedDescriptor.relaxTime >= 0{
            relaxUIUpdate()
            
            displayedDescriptor.relaxTime -= 1
        }else{
            timerRelax?.invalidate()
            start(nextRoundNum: self.displayedDescriptor.roundNum - 1)
        }
    }
    
    
    func relaxUIUpdate() {
        roundTimeLabel.text = String(displayedDescriptor.relaxTime)
    }
}
