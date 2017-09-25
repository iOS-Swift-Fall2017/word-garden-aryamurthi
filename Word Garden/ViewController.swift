//
//  ViewController.swift
//  Word Garden
//
//  Created by Arya Murthi on 9/19/17.
//  Copyright © 2017 Arya Murthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImgageView: UIImageView!
    
    let labelSubString = "_"
    var lettersGuessed = ""
    let wordsToGuess = ["PIZZA", "SUSHI","PASTA","HAMBURGER","PAELLA","CHICKEN","SWIFT"]
    lazy var randomIndex = Int(arc4random_uniform(UInt32(wordsToGuess.count)))
    var newRandomIndex = -1
    
    lazy var wordToGuess = wordsToGuess[randomIndex]
    
    
    
    
    var guessIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        formatUserGuessLabel()
    }
    
    @IBAction func guesedLetterFieldChanged(_ sender: UITextField) {
        guessLetterButton.isEnabled = true
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
            
        }else {
            //disabel button of there isn't a single character in guessLetterField
            guessLetterButton.isEnabled = false
        }
        
        
    }
    
    @IBAction func doneKeyPressed(_ sender: Any) {
        guessedLetterField.resignFirstResponder()
        guessALetter()
        wrongAnswer()
        guessedLetterField.text = ""
        guessLetterButton.isEnabled = false
        
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
        wrongAnswer()
        
    }
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
        repeat {
            newRandomIndex = Int(arc4random_uniform(UInt32(wordsToGuess.count)))
        } while randomIndex == newRandomIndex
        
        randomIndex = newRandomIndex
        
        wordToGuess = wordsToGuess[randomIndex]
        
       formatUserGuessLabel()
        flowerImgageView.image = UIImage(named:"flower8")
        playAgainButton.isEnabled = false
        guessIndex = 0
        guessCountLabel.text = "You've made \(guessIndex) incorrect guesses!"
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        
        
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    func labelChangeImageChange() {
        guessIndex += 1
        if guessIndex == 1{
            guessCountLabel.text = "You've made \(guessIndex) incorrect guess!"
        }else {
        guessCountLabel.text = "You've made \(guessIndex) incorrect guesses!"
        }
        
        flowerImgageView.image = UIImage(named: "flower\(8-guessIndex)" )
    }
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + "\(letter) "
                
            } else {
                revealedWord += "_ "
            }
            userGuessLabel.text = revealedWord
        }
        
    }
    func guessALetter() {
       formatUserGuessLabel()
        
    let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            labelChangeImageChange()
        }
        
     let currentWord = userGuessLabel.text!
        if !currentWord.contains(labelSubString) {
            guessCountLabel.text = "Yay! You got the word!"
            playAgainButton.isEnabled = true
            playAgainButton.isHidden = false
            lettersGuessed = ""
            
        }
    
    }
    
    func wrongAnswer() {
        if guessIndex == 8 {
            guessCountLabel.text = "Whoops! You seem to have run out of guesses. The hidden word was \(wordToGuess)!"
            guessLetterButton.isEnabled = false
            guessedLetterField.isEnabled = false
            playAgainButton.isEnabled = true
            playAgainButton.isHidden = false
            guessLetterButton.isEnabled = false
        }else{
            guessLetterButton.isEnabled = false
        }
    }
}
