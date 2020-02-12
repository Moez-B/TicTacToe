//
//  ViewController.swift
//  TicTacToe
//
//  Created by Moez on 2019-07-16.
//  Copyright © 2019 Moez. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {
   
    var cpu:Bool = true
    
    var difficulty:String = String()
    
    var p1Turn:Bool = true
    
    var p2Turn:Bool = false
    
    //0 is blank, 1 is X, 2 os O
    var grid:[[Int]] = [[0,0,0],
                        [0,0,0],
                        [0,0,0]]
    
    var turn:Int = 1
    
    var player1Name:String = String()
    
    var player2Name:String = String()
    
    @IBOutlet weak var a1: UIImageView!
    
    @IBOutlet weak var a2: UIImageView!
    
    @IBOutlet weak var a3: UIImageView!
    
    @IBOutlet weak var b1: UIImageView!
    
    @IBOutlet weak var b2: UIImageView!
    
    @IBOutlet weak var b3: UIImageView!
    
    @IBOutlet weak var c1: UIImageView!
    
    @IBOutlet weak var c2: UIImageView!
    
    @IBOutlet weak var c3: UIImageView!
    
    @IBOutlet weak var winner: UILabel!
    
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "toStartScreen", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winner.text = "\(player1Name)'s Turn:"
    }
    
    func winner(_ arr:[[Int]]) -> Int {
        let j:Int = 0
        for i in 0...2 {
            if grid[i][j] == grid[i][j+1] && grid[i][j] == grid[i][j+2] && grid[i][j] != 0 {
                return grid[i][j]
            }
            else {
            }
        }
        let h:Int = 0
        for g in 0...2 {
            if grid[h][g] == grid[h+1][g] && grid[h][g] == grid[h+2][g] && grid[h][g] != 0 {
                return grid[h][g]
            }
        }
        if grid[0][0] == grid[1][1] && grid[0][0] == grid[2][2] {
            return grid[1][1]
        }
        else if grid[1][1] == grid[0][2] && grid[1][1] == grid[2][0] {
            return grid[1][1]
        }
        return 0
    }
    
    func isWin(_ val:Int) -> Bool {
        if val == 0 {
            return false
        }
        return true
    }
    
    func playerTurn(_ turnNum:Int,_ picture:UIImageView,_ y:Int,_ x:Int) {
        if turn % 2 == 0 && grid[y][x] == 0 && p2Turn {
            winner.text = "\(player1Name)'s Turn:"
            p1Turn = true
            p2Turn = false
            picture.image = UIImage(named: "o")
            grid[y][x] = 2
            turnAdd()
        }
        else if turn % 2 == 1 && grid[y][x] == 0 && p1Turn{
            winner.text = "\(player2Name)'s Turn:"
            p2Turn = true
            p1Turn = false
            picture.image = UIImage(named: "x")
            grid[y][x] = 1
            turnAdd()
        }
    }
    
    func turnAdd() {
        turn += 1
    }
    
    func displayWinner() {
        if winner(grid) == 1 {
           winner.text = "\(player1Name) Has Won!"
        }
        else if winner(grid) == 2 {
            winner.text = "\(player2Name) Has Won!"
        }
        winner.textColor = .green
    }
    
    func positionToImageView(_ y:Int,_ x:Int) -> UIImageView {
        if y == 0 && x == 0 {
            return a1
        }
        else if y == 0 && x == 1 {
            return a2
        }
        else if y == 0 && x == 2 {
            return a3
        }
        else if y == 1 && x == 0 {
            return b1
        }
        else if y == 1 && x == 1 {
            return b2
        }
        else if y == 1 && x == 2 {
            return b3
        }
        else if y == 2 && x == 0 {
            return c1
        }
        else if y == 2 && x == 1 {
            return c2
        }
      return c3
    }
    
    func imageViewToPosition(_ image:UIImageView) -> (Int,Int) {
        if image == a1 {
            return (0,0)
        }
        else if image == a2 {
            return(0,1)
        }
        else if image == a3 {
            return(0,2)
        }
        else if image == b1 {
            return(1,0)
        }
        else if image == b2 {
            return(1,1)
        }
        else if image == b3 {
            return(1,2)
        }
        else if image == c1 {
            return(2,0)
        }
        else if image == c2 {
            return(2,1)
        }
        return(2,2)
    }
    
    func compute_cpuMove(_ dif:String) -> (UIImageView) {
        switch(dif) {
        case "MEDIUM":
            var numX:Int = Int()
            var numY:Int = Int()
            print("\(numY) and \(numX) were chosen")
            return positionToImageView(numY,numX)
            
        default:
            var ranNumY:Int = 0
            var ranNumX:Int = 0
            repeat {
                ranNumY = Int.random(in: 0...2)
                ranNumX = Int.random(in: 0...2)
            } while grid[ranNumY][ranNumX] != 0
            print("\(ranNumY) and \(ranNumX) were chosen")
            return positionToImageView(ranNumY,ranNumX)
        }
    }
    
    func execute_cpuMove() {
        let spot:UIImageView = compute_cpuMove(difficulty)
        playerTurn(turn,spot,imageViewToPosition(spot).0,imageViewToPosition(spot).1)
        if isWin(winner(grid)) {
            displayWinner()
        }
        else {
            //do nothing
        }
    }
    
    @IBAction func a1Tapped(_ sender: Any) {
        if grid[imageViewToPosition(a1).0][imageViewToPosition(a1).1] == 0 {
            playerTurn(turn,a1,0,0)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func a2Tapped(_ sender: Any) {
        if grid[imageViewToPosition(a2).0][imageViewToPosition(a2).1] == 0 {
            playerTurn(turn,a2,0,1)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func a3Tapped(_ sender: Any) {
        if grid[imageViewToPosition(a3).0][imageViewToPosition(a3).1] == 0 {
            playerTurn(turn,a3,0,2)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func b1Tapped(_ sender: Any) {
        if grid[imageViewToPosition(b1).0][imageViewToPosition(b1).1] == 0 {
            playerTurn(turn,b1,1,0)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func b2Tapped(_ sender: Any) {
        if grid[imageViewToPosition(b2).0][imageViewToPosition(b2).1] == 0 {
            playerTurn(turn,b2,1,1)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func b3Tapped(_ sender: Any) {
        if grid[imageViewToPosition(b3).0][imageViewToPosition(b3).1] == 0 {
            playerTurn(turn,b3,1,2)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func c1Tapped(_ sender: Any) {
        if grid[imageViewToPosition(c1).0][imageViewToPosition(c1).1] == 0 {
            playerTurn(turn,c1,2,0)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func c2Tapped(_ sender: Any) {
        if grid[imageViewToPosition(c2).0][imageViewToPosition(c2).1] == 0 {
            playerTurn(turn,c2,2,1)
            if isWin(winner(grid)) {
                    displayWinner()
            }
                else {
            //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func c3Tapped(_ sender: Any) {
        if grid[imageViewToPosition(c3).0][imageViewToPosition(c3).1] == 0 {
            playerTurn(turn,c3,2,2)
            if isWin(winner(grid)) {
                displayWinner()
            }
            else {
                //do nothing
            }
        
            print("cpu move (if 1 player)")
        
            if cpu && !isWin(winner(grid)) {
                execute_cpuMove()
            }
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        grid = [[0,0,0],
                [0,0,0],
                [0,0,0]]
        
        turn = 1
        
        p1Turn = true
        p2Turn = false
        
        a1.image = UIImage(named: "blank")
        a2.image = UIImage(named: "blank")
        a3.image = UIImage(named: "blank")
        b1.image = UIImage(named: "blank")
        b2.image = UIImage(named: "blank")
        b3.image = UIImage(named: "blank")
        c1.image = UIImage(named: "blank")
        c2.image = UIImage(named: "blank")
        c3.image = UIImage(named: "blank")
        
        winner.text = "\(player1Name)'s Turn:"
        winner.textColor = .black
    }
}
