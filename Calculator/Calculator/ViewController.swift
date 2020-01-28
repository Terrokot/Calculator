//
//  ViewController.swift
//  Calculator
//
//  Created by Egor Tereshonok on 1/27/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var previousValue: Double = 0
    var currentValue: Double = 0
    var taskString: String = ""
    var operation = 0
    var performMath = false
    var breaker = true
    
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var task: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func number(_ sender: UIButton) {
        
        if performMath && breaker {
            if sender.tag == 10 {
                resultLabel.text! = "00"
                task.text! += "00"
            } else if sender.tag == 11 {
                resultLabel.text! = "."
                task.text! += "."
            } else {
                resultLabel.text! = String(sender.tag)
                task.text! += String(sender.tag)
            }
            currentValue = Double(resultLabel.text!)!
            performMath = false
            breaker = false
        } else {
            if sender.tag == 10 {
                resultLabel.text! += "00"
                task.text! += "00"
            } else if sender.tag == 11 {
                resultLabel.text! += "."
                task.text! += "."
            } else {
                resultLabel.text! += String(sender.tag)
                task.text! += String(sender.tag)
                currentValue = Double(resultLabel.text!)!
                
            }
        }
    }
    
    /* operations tags
     ac ->  12
     /  ->  13
     *  ->  14
     -  ->  15
     +  ->  16
     =  ->  17
     */
    @IBAction func operations(_ sender: UIButton) {
        if resultLabel.text != "" && sender.tag != 12 && sender.tag != 17 && breaker {
            
            if let a = Double(resultLabel.text!) {
                previousValue = a
            } else { return }
            operation = sender.tag
            performMath = true
            
            switch sender.tag {
            case 13:
                resultLabel.text! += " / "
                task.text! += " / "
                
            case 14:
                resultLabel.text! += " * "
                task.text! += " * "
                
            case 15:
                resultLabel.text! += " - "
                task.text! += " - "
                
            case 16:
                resultLabel.text! += " + "
                task.text! += " + "
                
            default:
                break
            }
            
        } else if sender.tag == 17 {
            switch operation {
            case 13:
                resultLabel.text = String(previousValue / currentValue)
            case 14:
                resultLabel.text = String(previousValue * currentValue)
            case 15:
                resultLabel.text = String(previousValue - currentValue)
            case 16:
                resultLabel.text = String(previousValue + currentValue)
                print(previousValue)
                print(currentValue)
            default:
                break
            }
            breaker = true
        } else if sender.tag == 12 {
            resultLabel.text = ""
            task.text = ""
            previousValue = 0
            currentValue = 0
            operation = 0
            breaker = true
        }
        
    }
    
    
    //1st row
    
    
    @IBOutlet weak var firstRow: UIView!
    
    
    
    //2nd row
    
    
    @IBOutlet weak var secondRow: UIView!
    
    
    
    //3rd row
    
    
    @IBOutlet weak var thirdRow: UIView!
    
    
    //4th row
    
    @IBOutlet weak var fouthRow: UIView!
    
    
    
    // controlRow
    @IBOutlet weak var controlRow: UIView!
    
    
    @IBOutlet weak var equally: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        //MARK: Rectangles
        bottomView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        //MARK: Buttons
        equally.layer.backgroundColor = UIColor(red: 0.392, green: 0.78, blue: 1, alpha: 1).cgColor
        equally.layer.cornerRadius = equally.frame.height / 2



        
    }
    
}

