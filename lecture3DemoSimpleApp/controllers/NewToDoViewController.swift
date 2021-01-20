//
//  NewToDoViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by ADMIN ODoYal on 19.01.2021.
//

import UIKit

class NewToDoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var deadLineDatePicker: UIDatePicker!
    
    weak var delegate: NewToDoViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.becomeFirstResponder()
        titleTextField.delegate = self
        subtitleTextField.becomeFirstResponder()
        subtitleTextField.delegate = self
        deadLineDatePicker.minimumDate = Date()
        deadLineDatePicker.setDate(Date(), animated:  true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action:#selector(saveNewToDoItem))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func saveNewToDoItem(_ sender: Any) {
        if let title = titleTextField.text, !title.isEmpty,let subtitle = subtitleTextField.text, !subtitle.isEmpty{
            let date = deadLineDatePicker.date
            let item = ToDoItem(title: title, subTitle: subtitle, deadLine: date, status: statusState(date))
            delegate?.addItem(item)
            navigationController?.popViewController(animated: true)
        }
        else {
            print("Add Somthing")
        }
    }
    
    func statusState(_ date:Date) -> Bool {
        if date < Date() {
            return true
        }else{
            return false
        }
    }
}
