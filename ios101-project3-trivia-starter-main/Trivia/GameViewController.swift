//
//  GameViewController.swift
//  Trivia
//
//  Created by Ankur Gyawali on 10/3/23.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gameModels = [Question]()
    var currentQuestion: Question?
    
    
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var restartButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestion()
        configureUI(question: gameModels.first!)
//        configureUI()

        // Do any additional setup after loading the view.
    }
    

    
    
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
        
        
        
    }
    private func checkAnswer(answer: Answer, question: Question)->Bool{
        return question.answers.contains(where: {$0.text == answer.text }) && answer.correct
        
    }
    
    
    
    private func setupQuestion(){
        gameModels.append(Question(text: "What is the highest peak of the world?", answers: [
            Answer(text: "K2", correct: false),
            Answer(text: "Mount Everest", correct: true),
            Answer(text: "Kanchanjunga", correct: false),
            Answer(text: "Annapurna I", correct: false)
        ]))
        
        gameModels.append(Question(text: "Where is Nepal located?", answers: [
            Answer(text: "India", correct: false),
            Answer(text: "Himalayas", correct: false),
            Answer(text: "Asia", correct: true),
            Answer(text: "Europe", correct: false)
        ]))
        
        gameModels.append(Question(text: "What is the shape of Nepal's Flag", answers: [
            Answer(text: "Triangle", correct: true),
            Answer(text: "Square", correct: false),
            Answer(text: "Pentagon", correct: false),
            Answer(text: "Hexagon", correct: false)
        ]))
        
    }
    
    //Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]
        
        if  checkAnswer(answer: answer, question: question){
            
            //correct
            if let index = gameModels.firstIndex(where: {$0.text == question.text}){
                if index < (gameModels.count - 1){
                    //next question
                    let nextQuestion = gameModels[index+1]
                    print("\(nextQuestion.text)")
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                    
                    
                }
                else{
                    //end of game
                    let alert = UIAlertController(title: "Done", message: "You beat the game", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present(alert,animated: true)
                }
            }
        }
        else {
            //wrong
            let alert = UIAlertController(title: "Wrong", message: "Try Again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func didTapRestart(_ sender: UIButton) {
        // Reset the current question to the first one
        currentQuestion = gameModels.first

        // Update the UI with the first question
        configureUI(question: currentQuestion!)

   
    }

    
}

struct Question {
    let text: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool //true /false
}
