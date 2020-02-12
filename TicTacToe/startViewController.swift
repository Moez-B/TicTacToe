//
//  startViewController.swift
//  TicTacToe
//
//  Created by Moez on 2019-07-18.
//  Copyright © 2019 Moez. All rights reserved.
//

import UIKit

class startViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var cpu:Bool = false
    
    let gameType:[String] = ["2 Players","1 Player"]
    
    var difficulty:String = String() //continue this and choose the apropriate bot to work with it*****
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var p1NameLabel: UILabel!
    
    @IBOutlet weak var p2NameLabel: UILabel!
    
    @IBOutlet weak var p1Name: UITextField!
    
    @IBOutlet weak var p2Name: UITextField!
    
    @IBAction func settingsTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        performSegue(withIdentifier: "toGameScreen", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if gameType[row] == "1 Player" {
            cpu = true
            p2Name.isHidden = true
            p2NameLabel.isHidden = true
            
        }
        else if gameType[row] == "2 Players" {
            cpu = false
            p2Name.isHidden = false
            p2NameLabel.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameScreen" {
            let gameView = segue.destination as! ViewController
            gameView.player1Name = p1Name.text!
            gameView.player2Name = p2Name.text!
            
            if gameView.player1Name == String() && gameView.player2Name == String() {
                gameView.player1Name = "Player 1"
                gameView.player2Name = "Player 2"
            }
            else if gameView.player1Name == String() {
                gameView.player1Name = "Player 1"
            }
            else if gameView.player2Name == String() && !cpu {
                gameView.player2Name = "Player 2"
            }
            
            print("cpu or 2players")
            
            if cpu {
                gameView.cpu = true
                gameView.player2Name = "CPU"
                
                print("difficulty: \(difficulty)")
                if difficulty == "MEDIUM" || difficulty == "HARD" {
                    gameView.difficulty = self.difficulty
                }
                else {
                    gameView.difficulty = "EASY"
                }
            }
            else if !cpu {
               gameView.cpu = false
            }
        }
        else if segue.identifier == "toSettings" {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNameFields()
    }
    
    private func configNameFields() {
        
        //method that makes the UIViewController (objects p1Name and p2Name) class a delegate of (conform to) UITextFieldDelegate
        
        p1Name.delegate = self
        p2Name.delegate = self
        
        //making startViewController conform to UIPickerViewDataSource and UIPickerViewDelegate by making itself delegates of them
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}

extension UIViewController: UITextFieldDelegate {
    
    //add extension to UIViewController, make it conform to UITextFieldDelegate
    
    public func textFieldShouldReturn(_ text: UITextField) -> Bool {
        text.resignFirstResponder()
        return true
    }
}
