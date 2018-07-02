//
//  ViewController.swift
//  day1
//
//  Created by Brian Xu on 2/7/2018.
//  Copyright © 2018 Fake Name. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var p1button: UIButton!
    @IBOutlet weak var p2button: UIButton!
    @IBOutlet weak var p2scoreLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var p1score = 0
    var p2score = 0
    var maxScore = 20
    
    var p1color: UIColor!
    var p2color: UIColor!
    
    let settings = UIAlertController(title: "SETTINGS", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    let gamemodes = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
    let customMax = UIAlertController(title: "SET MAX SCORE", message: nil, preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        p1color = p1button.backgroundColor!
        p2color = p2button.backgroundColor!
        
        p2scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        p2button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        settings.addAction(UIAlertAction(title: "CHANGE GAME MODE", style: .default, handler: {(alert: UIAlertAction!) in self.present(self.gamemodes, animated: true, completion: nil) }))
        settings.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 20", style: .default, handler: {(alert: UIAlertAction!) in self.maxScore = 20 }))
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 30", style: .default, handler: {(alert: UIAlertAction!) in self.maxScore = 30 }))
        gamemodes.addAction(UIAlertAction(title: "MAX SCORE: 50", style: .default, handler: {(alert: UIAlertAction!) in self.maxScore = 50 }))
        gamemodes.addAction(UIAlertAction(title: "CUSTOM", style: .default, handler: {(alert: UIAlertAction!) in self.present(self.customMax, animated: true, completion: nil) }))
        gamemodes.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
        
        customMax.addTextField(configurationHandler: { (textField) in
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
        })
        customMax.addAction(UIAlertAction(title: "CONFIRM", style: .default, handler: {(alert: UIAlertAction!) in
            let textField = self.customMax.textFields![0]
            let newMax: Int? = Int(textField.text!)
            self.maxScore = newMax!
        }))
        customMax.addAction(UIAlertAction(title: "< BACK", style: .default, handler: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func p1buttonTapped(_ sender: UIButton) {
        p1score += 1
        p1button.setTitle(String(p1score), for: .normal)
        
        if p1score == maxScore {
            p1button.setTitle("WINNER", for: .disabled)
            
            p1button.isEnabled = false
            p2button.isEnabled = false
            resetButton.isHidden = false
            resetButton.isEnabled = true
            settingsButton.isHidden = false
            settingsButton.isEnabled = true
        }
        
        sender.backgroundColor = p1button.backgroundColor!.darker(by: CGFloat(30/maxScore))
    }
    
    @IBAction func p2buttonTapped(_ sender: UIButton) {
        p2score += 1
        p2button.setTitle(String(p2score), for: .normal)
        
        if p2score == maxScore {
            p2button.setTitle("WINNER", for: .disabled)
            
            p2button.isEnabled = false
            p1button.isEnabled = false
            resetButton.isHidden = false
            resetButton.isEnabled = true
            settingsButton.isHidden = false
            settingsButton.isEnabled = true
        }
        
        sender.backgroundColor = p2button.backgroundColor!.darker(by: CGFloat(30/maxScore))
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        if sender == resetButton {
            if resetButton.titleLabel!.text == "START" {
                resetButton.setTitle("RESET", for: .normal)
            }
            resetButton.isHidden = true
            resetButton.isEnabled = false
            settingsButton.isHidden = true
            settingsButton.isEnabled = false
        
            p1score = 0
            p1button.isEnabled = true
            p1button.setTitle(String(p1score), for: .normal)
            p1button.setTitle(String(p1score), for: .disabled)
            p1button.backgroundColor = p1color
        
            p2score = 0
            p2button.isEnabled = true
            p2button.setTitle(String(p2score), for: .normal)
            p2button.setTitle(String(p2score), for: .disabled)
            p2button.backgroundColor = p2color
        }
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        self.present(settings, animated: true, completion: nil)
    }
    
}
