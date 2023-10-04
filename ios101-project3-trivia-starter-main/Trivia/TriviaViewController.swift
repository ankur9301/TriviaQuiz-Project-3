//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Ankur Gyawali on 10/3/23.
//

/*
 
 Things We NEed:
- Menu Screen
- Game Screen
- Answer Object
- Question Object
 
 
 */


import UIKit

class TriviaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startGame(){
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
