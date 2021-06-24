//
//  ViewController.swift
//  work
//
//  Created by Apple on 24/06/2021.
//

import UIKit

class ViewController: UIViewController {

    
    deinit{
        
        
        do{
            
            let encodedData : Data = try PropertyListEncoder().encode(taskArray)
            UserDefaults.standard.set(encodedData, forKey: "encodedArray")
            
            print("encoded data == \(encodedData)")
            
        }catch {
            print(error)
        }
   
    }
    
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var taskLabelVC1: UILabel!
    
    
    var taskArray : [ModelClass] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
//
//        if let data = UserDefaults.standard.object(forKey: "taskArray") as? [ModelClass]
//        {
//
//            taskArray = data
//            taskLabelVC1.text = "total tasks are \(taskArray.count)"
//
//        }
//        else{
//
//        }
        
        
            if let data = UserDefaults.standard.value(forKey: "encodedArray") as? Data
            {
                
                print("data in if ==  \(data)")
                
                do{
                print("data in do == \(data)")
                let obj = try PropertyListDecoder().decode([ModelClass].self, from: data)
                    print("object == \(obj) ")
                    
                    
                    taskArray = obj
                    taskTableView.reloadData()
            }catch{
                print(error)
            }
       
        }
     
        
        
        
    }

    
    
    @IBAction func goToSecondVC(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        vc.delegate = self
        
        
        present(vc, animated: true, completion: nil)
    }
    

}

extension ViewController: TaskDelegate{

    func sendDataa(taskName: String!) {
    
        taskLabelVC1.text = taskName
        taskArray.append(ModelClass(taskName: taskName))
        taskTableView.reloadData()
        print(taskArray.count)
    }
}









extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {return}
        
        
        let task = taskArray[indexPath.row]
        
      //  print("task name == \(arr.taskName) \n task status == \(arr.taskStatus)")
        



        if task.taskStatus == false {
            print("before click status == \(task.taskStatus)")
            task.taskStatus = true
            
            
            taskArray.remove(at: indexPath.row)
            taskArray.insert(task, at: indexPath.row)
        
            print("after click status == \(task.taskStatus)")
        }
        else
        {
            print("before click status == \(task.taskStatus)")
            task.taskStatus = false
            
            taskArray.remove(at: indexPath.row)
            taskArray.insert(task, at: indexPath.row)

          
            print("after click status == \(task.taskStatus)")
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
//        task.taskStatus = !task.taskStatus
//        taskArray.remove(at: indexPath.row)
//        taskArray.insert(task, at: indexPath.row)
//
        
        cell.CustomCellImageView.image = task.taskStatus == true ? UIImage(named: "check") : UIImage(named: "uncheck1")
    }
}






extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = taskArray[indexPath.row]
        
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! CustomTableViewCell
        
   
        cell.CustomCellTaskNameLabel.text = task.taskName
       
        cell.CustomCellImageView.image = task.taskStatus == true ? UIImage(named: "check") : UIImage(named: "uncheck1")
        
        
        // cell.textLabel?.text = "\(task.taskName),     ,\(task.taskStatus)"
         

        return cell
    }
    
    
}

