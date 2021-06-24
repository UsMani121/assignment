//
//  SecondViewController.swift
//  work
//
//  Created by Apple on 24/06/2021.
//

import UIKit


protocol TaskDelegate {
    func sendDataa(taskName : String!)
    
    
}


class SecondViewController: UIViewController {

    
    
    @IBOutlet weak var addTextInput: UITextField!
    @IBOutlet weak var addTaskLabel: UILabel!
    
    var delegate : TaskDelegate!
    var taskString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stringToPass = taskString{
            addTextInput.text = stringToPass
        }
    }
    

  
    @IBAction func saveTaskButton(_ sender: Any) {
        
        if addTextInput.text != ""
        {
            
            let taskname = addTextInput.text ?? ""
            addTaskLabel.text = "New Task Added\n\(taskname)"
            
            delegate?.sendDataa(taskName : taskname)
            
            dismiss(animated: true, completion: nil)

        }
        else
        {
            addTaskLabel.text = "Kindly Add Task First."
        }
    }
    
}
