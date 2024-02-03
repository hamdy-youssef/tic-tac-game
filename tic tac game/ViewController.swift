//
//  ViewController.swift
//  tic tac game
//
//  Created by Hamdy Youssef on 03/02/2024.
//

import UIKit

class ViewController: UIViewController {

    enum Turn {
        case Nought
        case Cross
    }
     
    @IBOutlet var turnLabel: UILabel!
    @IBOutlet var a1: UIButton!
    @IBOutlet var a2: UIButton!
    @IBOutlet var a3: UIButton!
    
    @IBOutlet var b1: UIButton!
    @IBOutlet var b2: UIButton!
    @IBOutlet var b3: UIButton!
    
    @IBOutlet var c1: UIButton!
    @IBOutlet var c2: UIButton!
    @IBOutlet var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var nought = "O"
    var cross = "X"
    var board = [UIButton]()
    var noughtsScore = 0
    var crossesScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
    }

    func initBoard() {
        board.append (a1)
        board.append (a2)
        board.append (a3)
        board.append (b1)
        board.append (b2)
        board.append (b3)
        board.append (c1)
        board.append (c2)
        board.append (c3)
    }

    @IBAction func boardTabBtn(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(cross) {
            crossesScore += 1
            resultAlert(title: "Crosses Win!")
        }
        if checkForVictory(nought) {
            noughtsScore += 1
            resultAlert(title: "Nought Win!")
        }
        
        if(fullBoard()) {
            resultAlert (title: "Draw")
        }
    }
    
    func checkForVictory(_ s :String) -> Bool {
        // Horizental Vectory
        if thisSymboll(a1, s) && thisSymboll(a2, s) && thisSymboll(a3, s) {
            return true
        }
        if thisSymboll(b1, s) && thisSymboll(b2, s) && thisSymboll(b3, s) {
            return true
        }
        if thisSymboll(c1, s) && thisSymboll(c2, s) && thisSymboll(c3, s) {
            return true
        }
        // Vertical Vectory
        if thisSymboll(a1, s) && thisSymboll(b1, s) && thisSymboll(c1, s) {
            return true
        }
        if thisSymboll(a2, s) && thisSymboll(b2, s) && thisSymboll(c2, s) {
            return true
        }
        if thisSymboll(a3, s) && thisSymboll(b3, s) && thisSymboll(c3, s) {
            return true
        }
        // Diagonal Vectory
        if thisSymboll(a1, s) && thisSymboll(b2, s) && thisSymboll(c3, s) {
            return true
        }
        if thisSymboll(a3, s) && thisSymboll(b2, s) && thisSymboll(c1, s) {
            return true
        }
        
        return false
    }
    
    func thisSymboll(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert (title: String) {
        let message = "\nNoughts " + String (noughtsScore) + "\n\nCrosses " + String (crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard ()
        }))
        self.present (ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.Nought) {
            firstTurn = Turn.Cross
            turnLabel.text = cross
        } else if(firstTurn == Turn.Cross) {
            firstTurn = Turn.Nought
            turnLabel.text = nought
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            if currentTurn == Turn.Nought {
                sender.setTitle(nought, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = cross
            } else if currentTurn == Turn.Cross {
                sender.setTitle(cross, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = nought
            }
        }
    }

}

