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
    
    
    enum DeviceOrientation {
        case portrait
        case landscape
    }
    
    var orientation: DeviceOrientation = .portrait
    
    //MARK: Logic
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
    
    //MARK: UI
    
    
    
    //1st row
    
    
    @IBOutlet weak var firstRow: UIView!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonDivision: UIButton!
    
    //2nd row
    
    
    @IBOutlet weak var secondRow: UIView!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var buttonMultiplication: UIButton!
    
    
    
    //3rd row
    
    
    @IBOutlet weak var thirdRow: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    
    
    
    //4th row
    
    @IBOutlet weak var fouthRow: UIView!
    @IBOutlet weak var button00: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var buttonPoint: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    
    
    
    // controlRow
    @IBOutlet weak var controlRow: UIView!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var equally: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orientationSet(orientation: &orientation)
        print(orientation)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutSet()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if orientation == .portrait {
            orientation = .landscape
        } else {
            orientation = .portrait
        }
        print("вызов крыжа")
        layoutSet()
        
    }
    
    override func viewWillLayoutSubviews() {
        //MARK: Rectangles
        bottomView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        //MARK: Buttons
        equally.layer.backgroundColor = UIColor(red: 0.392, green: 0.78, blue: 1, alpha: 1).cgColor
        layoutSet()
        print("крыж по вашему распоряжению прибыл")
    }
    
    private func orientationSet(orientation: inout DeviceOrientation) {
        if view.frame.size.width < view.frame.size.height {
            orientation = .portrait
        } else { orientation =  .landscape}
    }
    
    private func layoutSet() {
        if orientation == .landscape {
            //MARK: LANDSCAPE
            
            // frame and position
            //MARK: Views
            topView.frame = CGRect(x: 0, y: 0, width: 301, height: 414)
            bottomView.frame = CGRect(x: 301, y: 0, width: 435, height: 414)
            
            
            
            //MARK: Buttons
            
            firstRow.frame = CGRect(x: 0, y: 0, width: 435, height: 74)
            secondRow.frame = CGRect(x: 0, y: 74 + 10, width: 435, height: 74)
            thirdRow.frame = CGRect(x: 0, y: (74 + 10) * 2, width: 435, height: 74)
            fouthRow.frame = CGRect(x: 0, y: (74 + 10) * 3, width: 435, height: 74)
            controlRow.frame = CGRect(x: 0, y: (74 + 10) * 4, width: 435, height: 74)
            
            let landscapeButtonSize = CGSize(width: 74, height: 74)
            button0.frame.size = landscapeButtonSize
            button00.frame.size = landscapeButtonSize
            button1.frame.size = landscapeButtonSize
            button2.frame.size = landscapeButtonSize
            button3.frame.size = landscapeButtonSize
            button4.frame.size = landscapeButtonSize
            button5.frame.size = landscapeButtonSize
            button6.frame.size = landscapeButtonSize
            button7.frame.size = landscapeButtonSize
            button8.frame.size = landscapeButtonSize
            button9.frame.size = landscapeButtonSize
            
            buttonDivision.frame.size = landscapeButtonSize
            buttonMultiplication.frame.size = landscapeButtonSize
            buttonMinus.frame.size = landscapeButtonSize
            buttonPlus.frame.size = landscapeButtonSize
            buttonPoint.frame.size = landscapeButtonSize
            buttonClear.frame.size = landscapeButtonSize
            
            equally.frame.size = CGSize(width: 266, height: 64)
            equally.layer.cornerRadius = equally.frame.height / 2
            
            
            
            
            
            
            
            //Decoration
            
            
            
            
        } else {
            //MARK: PORTRAIT
            // frame and position
            //MARK: Views
            
            topView.frame = CGRect(x: 0, y: 0, width: 414, height: 250)
            bottomView.frame = CGRect(x: 0, y: 250, width: 414, height: 486)
            //MARK: Buttons
            
            
            firstRow.frame = CGRect(x: 0, y: 0, width: 435, height: 88)
            secondRow.frame = CGRect(x: 0, y: 88 + 10, width: 435, height: 88)
            thirdRow.frame = CGRect(x: 0, y: (88 + 10) * 2, width: 435, height: 88)
            fouthRow.frame = CGRect(x: 0, y: (88 + 10) * 3, width: 435, height: 88)
            controlRow.frame = CGRect(x: 0, y: (88 + 10) * 4, width: 435, height: 88)
            
            
            let portraitButtonSize = CGSize(width: 88, height: 88)
            button0.frame.size = portraitButtonSize
            button00.frame.size = portraitButtonSize
            button1.frame.size = portraitButtonSize
            button2.frame.size = portraitButtonSize
            button3.frame.size = portraitButtonSize
            button4.frame.size = portraitButtonSize
            button5.frame.size = portraitButtonSize
            button6.frame.size = portraitButtonSize
            button7.frame.size = portraitButtonSize
            button8.frame.size = portraitButtonSize
            button9.frame.size = portraitButtonSize
            
            buttonDivision.frame.size = portraitButtonSize
            buttonMultiplication.frame.size = portraitButtonSize
            buttonMinus.frame.size = portraitButtonSize
            buttonPlus.frame.size = portraitButtonSize
            buttonPoint.frame.size = portraitButtonSize
            buttonClear.frame.size = portraitButtonSize
            
            equally.frame.size = CGSize(width: 266, height: 68)
            equally.layer.cornerRadius = equally.frame.height / 2
            
            //FistRow
            
            
            
            
            //Decoration
            
            
            
        }
    }
    
}


