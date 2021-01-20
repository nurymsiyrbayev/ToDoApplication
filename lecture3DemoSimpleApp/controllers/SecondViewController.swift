//
//  SecondViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

protocol NewToDoViewControllerDelegate:class {
    func addItem(_ item: ToDoItem)
}

protocol EditToDoViewControllerDelegate:class {
    func editItem(_ index: Int,_ item: ToDoItem)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arr = [ToDoItem]()
    let cellId = "TableViewCell"
    
// Navigation btn for add new ToDo item
    @IBAction func addNewItemBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NewToDoViewController") as! NewToDoViewController
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        self.configureTableView()
        arr.append(ToDoItem( title: "LOl", subTitle: "lol", deadLine: Date(), status: false))
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        
    }
    
    func removeItem(_ id: Int) {
        self.arr.remove(at: id)
    }
    
}

extension SecondViewController: NewToDoViewControllerDelegate{
    func addItem(_ item: ToDoItem) {
        arr.append(item)
        tableView.reloadData()
    }
}

extension SecondViewController: EditToDoViewControllerDelegate{
    func editItem(_ index: Int,_ item: ToDoItem){
        arr[index] = item
        tableView.reloadData()
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let item = arr[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
// Swiper for delete and change Current Item
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: (Bool) -> ()) in actionPerformed(true)
            self.removeItem(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        delete.backgroundColor = .systemRed
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in actionPerformed(true)
            let vc = self.storyboard?.instantiateViewController(identifier: "EditToDoItemViewController") as! EditToDoItemViewController
            vc.delegate  = self
            vc.index = indexPath.row
            vc.editingItem = self.arr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        edit.backgroundColor = .systemOrange
        
        return UISwipeActionsConfiguration(actions: [delete,edit])
    }
    
//  Swiper for change Item status to Done/InProgress
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let status = UIContextualAction(style: .normal, title: "Done/InProgress") { (contextualAction, view, actionPerformed: (Bool) -> ()) in actionPerformed(true)
            self.arr[indexPath.row].status.toggle()
            tableView.reloadData()
        }
        if self.arr[indexPath.row].status{
            status.backgroundColor = .lightGray
            status.title = "InProgress"
        } else{
            status.backgroundColor = .systemGreen
            status.title = "Done"
        }
        return UISwipeActionsConfiguration(actions: [status])
    }
}
