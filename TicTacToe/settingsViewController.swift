//
//  settingsViewController.swift
//  TicTacToe
//
//  Created by Moez on 2019-08-06.
//  Copyright © 2019 Moez. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let difficultyOptions:[String] = ["EASY","MEDIUM","HARD"]
    
    var difficultyChosen:String = String()
    
    @IBOutlet weak var difficultyPickerView: UIPickerView!
    
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToStartView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let startView = segue.destination as! startViewController
        startView.difficulty = difficultyChosen
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficultyOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficultyOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        difficultyChosen = difficultyOptions[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configDifficltyPicker()
    }
    
    func configDifficltyPicker() {
        difficultyPickerView.delegate = self
        difficultyPickerView.dataSource = self
    }

}
