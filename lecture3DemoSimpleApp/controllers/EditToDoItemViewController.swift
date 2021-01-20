//
//  EditToDoItemViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by ADMIN ODoYal on 19.01.2021.
//

import UIKit

class EditToDoItemViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var deadLineDatePicker: UIDatePicker!
    var index: Int?
    var editingItem: ToDoItem?
    
    weak var delegate: EditToDoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = editingItem?.title
        titleTextField.delegate = self
        subtitleTextField.text = editingItem?.subTitle
        subtitleTextField.delegate = self
        deadLineDatePicker.minimumDate = Date()
        deadLineDatePicker.setDate(editingItem?.deadLine ?? Date(), animated: true)
        navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveToDoItem))
    }
    
    @IBAction func saveToDoItem(_ sender: Any){
        if let title = titleTextField.text, !title.isEmpty,let subtitle = subtitleTextField.text, !subtitle.isEmpty{
            let date = deadLineDatePicker.date
            let item = ToDoItem(title: title, subTitle: subtitle, deadLine: date, status: statusState(date))
            delegate?.editItem(self.index!, item)
            navigationController?.popViewController(animated: true)
        }
        else {
            print("Add Somthing")
        }
    }
    
    func statusState(_ date:Date) -> Bool {
        if date > Date() {
            return true
        }else{
            return false
        }
    }

}
