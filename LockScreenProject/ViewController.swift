//
//  ViewController.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/3/20.
//  Copyright © 2020 spare.

import UIKit
import Toast_Swift

class ViewController: UIViewController {
    
    @IBOutlet weak var viewOfPlaceholders6Degits: UIView!
    @IBOutlet weak var viewOfPlaceholders4Degits: UIView!
    @IBOutlet weak var viewOfplaceholders8degits: UIView!
    @IBOutlet weak var enterPasscodeLabel: UILabel!
    @IBOutlet weak var faceIdButton: ButtonPasscode!
    @IBOutlet weak var viewOfButton: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonEnter: ButtonPasscode!
    @IBOutlet var placeholders4degits: [PasscodePlaceholder] = [PasscodePlaceholder]()
    @IBOutlet var placeholders6degits: [PasscodePlaceholder] = [PasscodePlaceholder]()
    @IBOutlet var placeholders8degits: [PasscodePlaceholder] = [PasscodePlaceholder]()
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
    var confirmedPasscode : String = ""
    var timer = Timer()
    var timerIsRunning = false
    var arrayTagButton = [String]()
    var confirmed = false
    var placeholder : [PasscodePlaceholder] = [PasscodePlaceholder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        randomizeButton()
        checkPasscode()
        disableButtons()
        timerLabel.isHidden = true
    }
    
    func randomizeButton(){
        arrayTagButton = [button0.tagButton,button1.tagButton,button2.tagButton,button3.tagButton,button4.tagButton,button5.tagButton,button6.tagButton,button7.tagButton,button8.tagButton,button9.tagButton]
        _ = viewOfButton.subviews.map { (sub)  in
            if let sub = sub as? ButtonPasscode {
                if sub.tag != 10 {
                    let index = Int(arc4random_uniform(UInt32(arrayTagButton.count)))
                    sub.setTitle(arrayTagButton[index], for: .normal)
                    sub.tagButton = arrayTagButton[index]
                    arrayTagButton.remove(at: index)
                }
            }
        }
    }
    
    func enableButtons() {
        deleteButton.isEnabled = true
        cancelButton.isEnabled = true
        buttonEnter.isEnabled = true
    }
    
    func disableButtons() {
        deleteButton.isEnabled = false
        cancelButton.isEnabled = false
        buttonEnter.isEnabled = false
    }
    
    func checkPasscode() {
        if PasscodeManager.shared.hasPasscode {
            if (PasscodeManager.shared.passcode != ""){
                if PasscodeManager.shared.passcode.count == 4 {
                    viewOfPlaceholders4Degits.isHidden = false
                    viewOfPlaceholders6Degits.isHidden = true
                    viewOfplaceholders8degits.isHidden = true
                    placeholder = placeholders4degits
                } else if PasscodeManager.shared.passcode.count == 6 {
                    viewOfPlaceholders4Degits.isHidden = true
                    viewOfPlaceholders6Degits.isHidden = false
                    viewOfplaceholders8degits.isHidden = true
                    placeholder = placeholders6degits
                } else if PasscodeManager.shared.passcode.count == 8 {
                    viewOfPlaceholders4Degits.isHidden = true
                    viewOfPlaceholders6Degits.isHidden = true
                    viewOfplaceholders8degits.isHidden = false
                    placeholder = placeholders8degits
                }
            }
            cancelButton.setTitle("Cancel", for: .normal)
            buttonEnter.isHidden = false
        } else {
            placeholder = placeholders8degits
            viewOfPlaceholders4Degits.isHidden = true
            viewOfPlaceholders6Degits.isHidden = true
            cancelButton.setTitle("Save", for: .normal)
            buttonEnter.isHidden = true
            buttonEnter.isEnabled = false
            enterPasscodeLabel.text = "create your passcode"
            enterPasscodeLabel.textColor = .black
        }
        print(placeholder.count)
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
    }
    
    func timeString(time:TimeInterval) -> String {
        return String(format:"%02i:%02i:%02i", Int(time) / 3600, Int(time) / 60 % 60, Int(time) % 60)
    }
    
    @objc func updateTimer() {
        PasscodeManager.shared.second += 1
        PasscodeManager.shared.minute = PasscodeManager.shared.second / 60 % 60
        if PasscodeManager.shared.minute < 1 {
            timerLabel.text = timeString(time: TimeInterval(PasscodeManager.shared.second))
        } else {
            PasscodeManager.shared.second = 00
            PasscodeManager.shared.minute = 00
            timerLabel.text = "00:00:00"
            passcode = ""
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
        disableButtons()
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
            confirmed ? (confirmedPasscode.append(passcodee)) : (passcode.append(passcodee))
            confirmed ? (placeholder[confirmedPasscode.count - 1].animateState(.active)) : (placeholder[passcode.count - 1].animateState(.active))
            enableButtons()
        }
    }
    
    @IBAction func button1DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button1.tagButton)
        }
        
    }
    
    @IBAction func button2DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button2.tagButton)
        }
    }
    
    @IBAction func button3DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button3.tagButton)
        }
    }
    
    @IBAction func button4DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button4.tagButton)
        }
    }
    
    @IBAction func button5DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button5.tagButton)
        }
    }
    
    @IBAction func button6DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button6.tagButton)
        }
    }
    
    @IBAction func button7DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button7.tagButton)
        }
    }
    
    @IBAction func button8DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button8.tagButton)
        }
        
    }
    
    @IBAction func button9DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button9.tagButton)
        }
    }
    
    @IBAction func button0DidTapped(_ sender: ButtonPasscode) {
        if passcode.count < placeholder.count {
            animatePlaceholders(passcodee: button0.tagButton)
        }
    }
    
    @IBAction func deleteButton(_ sender: ButtonPasscode) {
        if passcode.count > 0 {
            placeholder[passcode.count - 1] .animateState(.inactive)
            passcode.removeLast()
            if passcode.count == 0 {
                randomizeButton()
                disableButtons()
                enterPasscodeLabel.text = "Enter passcode"
                enterPasscodeLabel.textColor = .black
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: ButtonPasscode) {
        let data = Data(passcode.utf8)
        if PasscodeManager.shared.hasPasscode {
            passcode.removeAll()
            disableButtons()
            enterPasscodeLabel.text = "Enter passcode"
            enterPasscodeLabel.textColor = .black
            placeholder.forEach { (placeholder) in
                placeholder.animateState(.inactive)
            }
        } else {
            if passcode.count != 4 && passcode.count != 6 && passcode.count != 8 {
                enterPasscodeLabel.text = "Passcode must contain 4 or 6 or 8 degits"
                enterPasscodeLabel.textColor = .red
                placeholder.forEach { (placeholder) in
                    placeholder.animateState(.inactive)
                }
                passcode = ""
                return
            }
            if confirmedPasscode == "" {
                confirmed = true
                placeholder.forEach { (placeholder) in
                    placeholder.animateState(.inactive)
                }
                enterPasscodeLabel.text = "confirm your passcode"
                enterPasscodeLabel.textColor = .black
                cancelButton.setTitle("confirm", for: .normal)
            } else {
                if confirmedPasscode == passcode {
                    let status = KeychainService.shared.save(key: "passcode", data: data)
                    if status == noErr {
                        placeholder.forEach { (placeholder) in
                            placeholder.animateState(.inactive)
                        }
                        PasscodeManager.shared.navigateToMainPage(view: self)
                        cancelButton.setTitle("cancel", for: .normal)
                    }
                } else {
                    enterPasscodeLabel.text = "invalid passcode"
                    enterPasscodeLabel.textColor = .red
                    confirmedPasscode = ""
                    placeholder.forEach { (placeholder) in
                        placeholder.animateState(.inactive)
                    }
                }
            }
        }
        randomizeButton()
    }
    
    @IBAction func buttonEnterDidTapped(_ sender: ButtonPasscode) {
        if PasscodeManager.shared.passcode == passcode {
            PasscodeManager.shared.navigateToMainPage(view: self)
            PasscodeManager.shared.screenLocked = false
        } else {
            PasscodeManager.shared.limitRetry += 1
            if PasscodeManager.shared.limitRetry < 4 {
                enterPasscodeLabel.text = "Invalid passcode"
                enterPasscodeLabel.textColor = .red
                randomizeButton()
                for index in 0 ... (passcode.count - 1) {
                    placeholder[index].animateState(.error)
                }
            } else {
                disablePasscodeScreen()
                PasscodeManager.shared.screenLocked = true
                for index in 0 ... (passcode.count - 1) {
                    placeholder[index].animateState(.inactive)
                }
            }
        }
    }
    
}

