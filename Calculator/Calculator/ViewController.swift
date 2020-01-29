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
                if let b = Double(resultLabel.text!) {
                    currentValue = b
                } else { breaker = true }
                
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
    
    @IBOutlet var buttons: [UIButton]!
    
    
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
    
    override func viewWillLayoutSubviews() {
        orientationSet(orientation: &orientation)
        
        switch UIDevice.current.userInterfaceIdiom {
            
        case .phone:
            iphoneLayoutSet()
        case .pad:
            ipadLayoutSet()
        case .unspecified:
            break
        case .tv:
            break
        case .carPlay:
            break
        @unknown default:
            break
        }
        print("крыж по вашему распоряжению прибыл")
    }
    
    private func orientationSet(orientation: inout DeviceOrientation) {
        if view.frame.size.width < view.frame.size.height {
            orientation = .portrait
        } else { orientation =  .landscape }
    }
    
    //MARK: IPHONE
    
    private func iphoneLayoutSet() {
        
        for i in buttons {
            i.titleLabel?.font = UIFont(name: "Futura-Medium", size: 24)
        }
        
        if orientation == .landscape {
            //MARK: LANDSCAPE
            
            let landscapeButtonSize: CGFloat = 74
            
            // frame and position
            //MARK: Views
            topView.frame = CGRect(x: 0, y: 0, width: 301, height: 414)
            bottomView.frame = CGRect(x: 301, y: 0, width: 435, height: 414)
            
            resultLabel.frame = CGRect(x: 0, y: 20, width: 301 - 30 , height: 66)
            resultLabel.font = UIFont(name: "Futura-Medium", size: 50)
            
            task.frame = CGRect(x: 20, y: 355, width: 301, height: 24)
            task.font = UIFont(name: "Futura-Medium", size: 24)
            task.textAlignment = .left
            
            //MARK: Buttons
            
            //FistRow
            
            firstRow.frame = CGRect(x: 0, y: 5, width: 435, height: 74)
            
            button7.frame = CGRect(x: 36, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button8.frame = CGRect(x: 36 + landscapeButtonSize + 25 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button9.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            buttonDivision.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //SecondRow
            secondRow.frame = CGRect(x: 0, y: 5 + 74 + 10, width: 435, height: 74)
            
            button4.frame = CGRect(x: 36, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button5.frame = CGRect(x: 36 + landscapeButtonSize + 25 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button5.layer.cornerRadius = landscapeButtonSize / 2
            button5.layer.borderWidth = 3
            button5.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2).cgColor
            button6.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            buttonMultiplication.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //ThirdROW
            thirdRow.frame = CGRect(x: 0, y: 5 + (74 + 10) * 2, width: 435, height: 74)
            
            button1.frame = CGRect(x: 36, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button2.frame = CGRect(x: 36 + landscapeButtonSize + 25 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button3.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            buttonMinus.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //FourthROW
            fouthRow.frame = CGRect(x: 0, y: 5 + (74 + 10) * 3, width: 435, height: 74)
            
            button0.frame = CGRect(x: 36, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button00.frame = CGRect(x: 36 + landscapeButtonSize + 25 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            buttonPoint.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            buttonPlus.frame = CGRect(x: 36 + (landscapeButtonSize + 25) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //ControlRow
            controlRow.frame = CGRect(x: 0, y: 5 + (74 + 10) * 4, width: 435, height: 74)
            
            buttonClear.frame = CGRect(x: 36, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            equally.frame = CGRect(x: 36 + landscapeButtonSize + 20, y: 2, width: landscapeButtonSize, height: landscapeButtonSize)
            
            equally.frame.size = CGSize(width: 266, height: 64)
            equally.layer.cornerRadius = equally.frame.height / 2
            equally.layer.backgroundColor = UIColor(red: 0.392, green: 0.78, blue: 1, alpha: 1).cgColor
            
        } else {
            //MARK: PORTRAIT
            let portraitButtonSize: CGFloat = 88
            
            //MARK: Views
            
            topView.frame = CGRect(x: 0, y: 0, width: 414, height: 250)
            bottomView.frame = CGRect(x: 0, y: 250, width: 414, height: 486)
            
            resultLabel.frame = CGRect(x: 0, y: 142, width: 414, height: 70)
            resultLabel.font = UIFont(name: "Futura-Medium", size: 70)
            
            task.frame = CGRect(x: 0, y: 89, width: 414, height: 36)
            task.font = UIFont(name: "Futura-Medium", size: 24)
            task.textAlignment = .right
            
            //MARK: Buttons
            
            //FistRow
            firstRow.frame = CGRect(x: 0, y: 0, width: 435, height: 88)
            
            button7.frame = CGRect(x: 16, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button8.frame = CGRect(x: 16 + portraitButtonSize + 10 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button9.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            buttonDivision.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            //SecondRow
            secondRow.frame = CGRect(x: 0, y: 88 + 10, width: 435, height: 88)
            
            button4.frame = CGRect(x: 16, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button5.frame = CGRect(x: 16 + portraitButtonSize + 10 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button5.layer.cornerRadius = portraitButtonSize / 2
            button6.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            buttonMultiplication.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            //ThirdRow
            thirdRow.frame = CGRect(x: 0, y: (88 + 10) * 2, width: 435, height: 88)
            
            button1.frame = CGRect(x: 16, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button2.frame = CGRect(x: 16 + portraitButtonSize + 10 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button3.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            buttonMinus.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            // FourthRow
            fouthRow.frame = CGRect(x: 0, y: (88 + 10) * 3, width: 435, height: 88)
            
            button0.frame = CGRect(x: 16, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button00.frame = CGRect(x: 16 + portraitButtonSize + 10 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            buttonPoint.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            buttonPlus.frame = CGRect(x: 16 + (portraitButtonSize + 10) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            // ControlRow
            controlRow.frame = CGRect(x: 0, y: (88 + 10) * 4, width: 435, height: 88)
            
            buttonClear.frame = CGRect(x: 16, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            buttonClear.titleLabel?.textAlignment = .center
            
            equally.frame = CGRect(x: 16 + portraitButtonSize + 15, y: 10, width: 266, height: 68)
            equally.layer.cornerRadius = equally.frame.height / 2
            equally.layer.backgroundColor = UIColor(red: 0.392, green: 0.78, blue: 1, alpha: 1).cgColor
        }
    }
    
    //MARK: IPAD
    private func ipadLayoutSet() {
        
        for i in buttons {
            i.titleLabel?.font = UIFont(name: "Futura-Medium", size: 64)
        }
        if orientation == .landscape {
            //MARK: LANDSCAPE
            
            let landscapeButtonSize: CGFloat = 150
            
            // frame and position
            //MARK: Views
            topView.frame = CGRect(x: 0, y: 0, width: 479, height: 834)
            bottomView.frame = CGRect(x: 479, y: 0, width: 715, height: 834)
            
            resultLabel.frame = CGRect(x: 0, y: 40, width: 479 - 40 , height: 90)
            resultLabel.font = UIFont(name: "Futura-Medium", size: 90)
            
            task.frame = CGRect(x: 40, y: 730, width: 479, height: 48)
            task.font = UIFont(name: "Futura-Medium", size: 48)
            task.textAlignment = .left
            
            //MARK: Buttons
            
          
            //FistRow
            
            firstRow.frame = CGRect(x: 0, y: 14 , width: bottomView.frame.size.width, height: landscapeButtonSize)
            
            button7.frame = CGRect(x: 27, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button8.frame = CGRect(x: 27 + landscapeButtonSize + 20 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button9.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            buttonDivision.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //SecondRow
            secondRow.frame = CGRect(x: 0, y: 14 + landscapeButtonSize + 20, width: bottomView.frame.size.width, height: landscapeButtonSize)
            
            button4.frame = CGRect(x: 27, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button5.frame = CGRect(x: 27 + landscapeButtonSize + 20 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button5.layer.cornerRadius = landscapeButtonSize / 2
            button5.layer.borderWidth = 3
            button5.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2).cgColor
            button6.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            buttonMultiplication.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //ThirdROW
            thirdRow.frame = CGRect(x: 0, y: 14 + (landscapeButtonSize + 20) * 2, width: bottomView.frame.size.width, height: landscapeButtonSize)
            
            button1.frame = CGRect(x: 27, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button2.frame = CGRect(x: 27 + landscapeButtonSize + 20 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button3.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            
            buttonMinus.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //FourthROW
            fouthRow.frame = CGRect(x: 0, y: 14 + (landscapeButtonSize + 20) * 3, width: bottomView.frame.size.width, height: landscapeButtonSize)
            
            button0.frame = CGRect(x: 27, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            button00.frame = CGRect(x: 27 + landscapeButtonSize + 20 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            buttonPoint.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 2 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            buttonPlus.frame = CGRect(x: 27 + (landscapeButtonSize + 20) * 3 , y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            //ControlRow
            controlRow.frame = CGRect(x: 0, y: 14 + (landscapeButtonSize + 20) * 4, width: bottomView.frame.size.width, height: landscapeButtonSize)
            
            buttonClear.frame = CGRect(x: 27, y: 0, width: landscapeButtonSize, height: landscapeButtonSize)
            
            equally.frame = CGRect(x: 27 + landscapeButtonSize + 54, y: 10, width: landscapeButtonSize, height: landscapeButtonSize)
            
            equally.frame.size = CGSize(width: 412, height: 86)
            equally.layer.cornerRadius = equally.frame.height / 2
            equally.layer.backgroundColor = UIColor(red: 0.392, green: 0.78, blue: 1, alpha: 1).cgColor
            
        } else {
            //MARK: PORTRAIT
            let portraitButtonSize: CGFloat = 150
            
            //MARK: Views
            
            topView.frame = CGRect(x: 0, y: 0, width: 834, height: 360)
            bottomView.frame = CGRect(x: 0, y: 360, width: 834, height: 834)
            
            resultLabel.frame = CGRect(x: 0, y: 225, width: 834 - 30, height: 90)
            resultLabel.font = UIFont(name: "Futura-Medium", size: 90)
            
            task.frame = CGRect(x: 0, y: 146, width: 834 - 30, height: 48)
            task.font = UIFont(name: "Futura-Medium", size: 48)
            task.textAlignment = .right
            
            //MARK: Buttons
            
            
            //FistRow
            firstRow.frame = CGRect(x: 0, y: 20 , width: bottomView.frame.size.width, height: portraitButtonSize)
            
            button7.frame = CGRect(x: 32, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button8.frame = CGRect(x: 32 + portraitButtonSize + 60 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button9.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            buttonDivision.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            //SecondRow
            secondRow.frame = CGRect(x: 0, y: 20 + portraitButtonSize + 20, width: bottomView.frame.size.width, height: portraitButtonSize)
            button4.frame = CGRect(x: 32, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button5.frame = CGRect(x: 32 + portraitButtonSize + 60 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button5.layer.cornerRadius = portraitButtonSize / 2
            button6.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)

            buttonMultiplication.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            //ThirdRow
            thirdRow.frame = CGRect(x: 0, y: 20 + (portraitButtonSize + 20) * 2 , width: bottomView.frame.size.width, height: portraitButtonSize)
            
            button1.frame = CGRect(x: 32, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button2.frame = CGRect(x: 32 + portraitButtonSize + 60 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button3.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)

            buttonMinus.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            // FourthRow
            fouthRow.frame = CGRect(x: 0, y: 20 + (portraitButtonSize + 20) * 3 , width: bottomView.frame.size.width, height: portraitButtonSize)
            
            button0.frame = CGRect(x: 32, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            button00.frame = CGRect(x: 32 + portraitButtonSize + 60 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            buttonPoint.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 2 , y: 0, width: portraitButtonSize, height: portraitButtonSize)

            buttonPlus.frame = CGRect(x: 32 + (portraitButtonSize + 60) * 3 , y: 0, width: portraitButtonSize, height: portraitButtonSize)
            
            // ControlRow
            controlRow.frame = CGRect(x: 0, y: 20 + (portraitButtonSize + 20) * 4 , width: bottomView.frame.size.width, height: portraitButtonSize)
            
            buttonClear.frame = CGRect(x: 32, y: 0, width: portraitButtonSize, height: portraitButtonSize)
            buttonClear.titleLabel?.textAlignment = .center
            
            equally.frame = CGRect(x: 32 + portraitButtonSize + 80, y: 10, width: 529, height: 86)
            equally.layer.cornerRadius = equally.frame.height / 2
            equally.layer.backgroundColor = UIColor(red: 0.392, green: 0.78, blue: 1, alpha: 1).cgColor
        }
    }
}




