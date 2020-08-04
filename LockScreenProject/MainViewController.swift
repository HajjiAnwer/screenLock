//
//  MainViewController.swift
//  LockScreenProject
//
//  Created by Hajji Anwer on 8/4/20.
//  Copyright © 2020 spare. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    var sourceController = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.textColor = .green
        sourceController == 0 ? (loginLabel.isHidden = true) : (loginLabel.isHidden = false)
    }

}
