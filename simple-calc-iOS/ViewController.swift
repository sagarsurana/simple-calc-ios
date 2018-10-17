//
//  ViewController.swift
//  simple-calc-iOS
//
//  Created by Sagar Surana on 10/16/18.
//  Copyright © 2018 ischoolsagar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentNumber: UITextField!
    var currentFunction: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func numberPressed(sender: UIButton!) {
        var pressed: String = sender!.titleLabel!.text!
        if (!currentFunction.isEmpty) {
            let lastEntered = (currentFunction[currentFunction.count - 1])
            if (Int(lastEntered) != nil) {
                let newVal: Int = (Int(lastEntered)! * 10) + Int(pressed)!
                currentFunction.remove(at: currentFunction.count - 1)
                pressed = String(newVal)
            }
        }
        currentFunction.append(pressed)
        currentNumber.text = pressed
    }
    
    
    @IBAction func operationPressed(sender: UIButton!) {
        
        let pressed: String = sender!.titleLabel!.text!
        if (currentFunction.isEmpty) {
            if (pressed != "count" && pressed != "avg") {
                currentFunction.append("0")
            }
        }
        if (pressed == "fact" && currentFunction.count > 1) {
            currentNumber.text = "Try again with 1 number"
            currentFunction = []
        } else {
            currentFunction.append(pressed)
        }
        
    }
    
    @IBAction func totalPressed(_ sender: Any) {
        print(currentFunction)
        let response: Int = calculate(currentFunction)
        currentFunction = []
        currentNumber.text = String(response)
    }
    
    @IBAction func clearUp(_ sender: UIButton) {
        currentFunction = []
        currentNumber.text = "0"
    }
    
    public func calculate(_ args: [String]) -> Int {
        var res: Int = 0
        let size = args.count;
        if size <= 1 {
            return 0;
        }
        let lastElement = Int(args[size-1])
        let first = (Int(args[0]))!
        if (lastElement != nil) {
            let second = (Int(args[2]))!
            switch args[1] {
            case "add":
                res = first + second
            case "mul":
                res = first * second
            case "div":
                res = first / second
            case "sub":
                res = first - second
            case "avg":
                res = average(args)
            case "count":
                res = (args.count + 1) / 2
            default: //modulo operator
                res = first % second
            }
        } else {
            if (first >= 0) {
                res = factorial(first)
            }
        }
        return res;
    }
    
    public func factorial(_ param: Int) -> Int {
        var response = param
        if (param == 0) {
            return 1
        }
        for i in 1..<param {
            response = response * (param-i)
        }
        return response
    }
    
    public func average(_ arr: [String]) -> Int {
        var avg: Int;
        var count: Int = 0;
        var sum = 0;
        for i in 0..<(arr.count) {
            if (arr[i] != "avg") {
                count += 1
                sum += (Int(arr[i]))!
            }
        }
        avg = sum/(count)
        return avg
    }
    
    
}

