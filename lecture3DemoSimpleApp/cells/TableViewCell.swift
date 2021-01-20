//
//  TableViewCell.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadLineLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item:ToDoItem) -> Void {
        titleLabel.text = item.title
        deadLineLabel.text =  convertDateToString(item.deadLine)
        subTitleLabel.text = item.subTitle
        if item.status{
            contentView.backgroundColor = .green
        }else{
            contentView.backgroundColor = .gray
        }
    }
    
    func convertDateToString(_ date:Date) -> String {
        let converter = DateFormatter()
        converter.dateFormat = "d MMM y"
        return converter.string(from: date)
    }
}
