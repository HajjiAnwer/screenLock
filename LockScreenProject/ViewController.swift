//
//  ViewController.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare.

import UIKit
import Toast_Swift

class ViewController: UIViewController {
    
    @IBOutlet weak var enterPasscodeLabel: UILabel!
    @IBOutlet weak var faceIdButton: ButtonPasscode!
    @IBOutlet weak var viewOfButton: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonEnter: ButtonPasscode!
    @IBOutlet var placeholders: [PasscodePlaceholder] = [PasscodePlaceholder]()
    @IBOutlet weak var deleteButton: ButtonPasscode!
    @IBOutlet weak var cancelButton: ButtonPasscode!
    @IBOutlet weak var button0: ButtonPasscode!
    @IBOutlet weak var button9: ButtonPasscode!
    @IBOutlet weak var button8: ButtonPasscode!
    @IBOutlet weak var button7: ButtonPasscode!
    @IBOutlet weak var button6: ButtonPasscode!
    @IBOutlet weak var button5: ButtonPasscode!
    @IBOutlet weak var button4: ButtonPasscode!
    @IBOutlet weak var button3: ButtonPasscode!
    @IBOutlet weak var button2: ButtonPasscode!
    @IBOutlet weak var button1: ButtonPasscode!
    @IBOutlet weak var viewOfButtonToTop: NSLayoutConstraint!
    @IBOutlet weak var timerLabelToTopConstrainte: NSLayoutConstraint!
    var passcode : String = ""
    var timer = Timer()
    var timerIsRunning = false
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPasscode()
        deleteButton.isEnabled = false
        cancelButton.isEnabled = false
        buttonEnter.isEnabled = false
        timerLabel.isHidden = true
    }
    
    func checkPasscode() {
        if PasscodeManager.shared.hasPasscode {
            cancelButton.setTitle("Cancel", for: .normal)
            buttonEnter.isHidden = false
        } else {
            cancelButton.setTitle("Save", for: .normal)
            buttonEnter.isHidden = true
            buttonEnter.isEnabled = false
            enterPasscodeLabel.text = "create your passcode"
            enterPasscodeLabel.textColor = .black
        }
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @objc func updateTimer() {
        PasscodeManager.shared.second += 1
        PasscodeManager.shared.minute = PasscodeManager.shared.second / 60 % 60
        if PasscodeManager.shared.minute < 4 {
            timerLabel.text = timeString(time: TimeInterval(PasscodeManager.shared.second))
        } else {
            PasscodeManager.shared.second = 00
            PasscodeManager.shared.minute = 00
            timerLabel.text = "00:00:00"
            enableScreen()
        }
    }
    
    func enableScreen(){
        timerLabel.isHidden = true
        viewOfButtonToTop.constant = 24
        _ = viewOfButton.subviews.map { sub in
            if let sub = sub as? ButtonPasscode {
                sub.isEnabled = true
            }
        }
        faceIdButton.isEnabled = true
        enterPasscodeLabel.text = "Enter passcode"
        enterPasscodeLabel.textColor = .black
        timerLabel.isHidden = true
        timer.invalidate()
        PasscodeManager.shared.limitRetry = 0
        deleteButton.isEnabled = false
        cancelButton.isEnabled = false
        buttonEnter.isEnabled = false
    }
    
    
    func disablePasscodeScreen() {
        timerLabelToTopConstrainte.constant = 15
        viewOfButtonToTop.constant = 50
        _ = viewOfButton.subviews.map { sub in
            if let sub = sub as? ButtonPasscode {
                sub.isEnabled = false
            }
        }
        faceIdButton.isEnabled = false
        enterPasscodeLabel.text = "Passcode screen will be locked 4 min"
        enterPasscodeLabel.textColor = .red
        timerLabel.isHidden = false
        runTimer()
    }
    
    func animatePlaceholders (passcodee : String) {
        if PasscodeManager.shared.passcodeActive{
            passcode.append(passcodee)
            placeholders[passcode.count - 1].animateState(.active)
            deleteButton.isEnabled = true
            cancelButton.isEnabled = true
            buttonEnter.isEnabled = true
            print(passcodee.count)
        } else {
            return
        }
    }
    
    @IBAction func button1DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button1.tagButton)
            print(passcode)
        }
        
    }
    
    @IBAction func button2DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button2.tagButton)
            print(passcode)
        }
    }
    
    @IBAction func button3DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button3.tagButton)
            print(passcode)
        }
    }
    
    @IBAction func button4DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button4.tagButton)
            print(passcode)
        }
    }
    
    @IBAction func button5DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button5.tagButton)
            print(passcode)
        }
    }
    
    @IBAction func button6DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button6.tagButton)
            print(passcode)
        }
    }
    
    @IBAction func button7DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button7.tagButton)
            print(passcode)
        }
    }
    
    @IBAction func button8DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button8.tagButton)
            print(passcode)
        }
        
    }
    
    @IBAction func button9DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button9.tagButton)
            print(passcode)
        }
    }
    
    @IBAction func button0DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < 8 {
            animatePlaceholders(passcodee: button0.tagButton)
        }
    }
    
    @IBAction func deleteButton(_ sender: ButtonPasscode) {
        if passcode.count > 0 {
            placeholders[passcode.count - 1] .animateState(.inactive)
            passcode.removeLast()
            print(passcode)
            if passcode.count == 0 {
                deleteButton.isEnabled = false
                cancelButton.isEnabled = false
                buttonEnter.isEnabled = false
                enterPasscodeLabel.text = "Enter passcode"
                enterPasscodeLabel.textColor = .black
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: ButtonPasscode) {
        let data = Data(passcode.utf8)
        if PasscodeManager.shared.hasPasscode {
            passcode.removeAll()
            deleteButton.isEnabled = false
            cancelButton.isEnabled = false
            buttonEnter.isEnabled = false
            enterPasscodeLabel.text = "Enter passcode"
            enterPasscodeLabel.textColor = .black
            placeholders.forEach { (placeholder) in
                placeholder.animateState(.inactive)
            }
        } else {
           let status = KeychainService.shared.save(key: "passcode", data: data)
            if status == noErr {
                placeholders.forEach { (placeholder) in
                    placeholder.animateState(.inactive)
                }
            }
        }
    }
    
    @IBAction func buttonEnterDidTapped(_ sender: ButtonPasscode) {
        if PasscodeManager.shared.passcode == passcode {
            enterPasscodeLabel.text = "Success"
            enterPasscodeLabel.textColor = .black
            print("success")
        } else {
            PasscodeManager.shared.limitRetry += 1
            if PasscodeManager.shared.limitRetry < 4 {
                enterPasscodeLabel.text = "Invalid passcode"
                enterPasscodeLabel.textColor = .red
                for index in 0 ... (passcode.count - 1) {
                    placeholders[index].animateState(.error)
                }
            } else {
                print("you have passed the retry limit")
                disablePasscodeScreen()
                for index in 0 ... (passcode.count - 1) {
                    placeholders[index].animateState(.inactive)
                }
            }
        }
    }
    
}

