//
//  TableViewCell.swift
//  Paper
//
//  Created by Tushar Singh on 11/12/18.
//  Copyright © 2018 Tushar Singh. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {


    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseCode: UILabel!
    @IBOutlet weak var slot: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var button: UIButton!
    
    weak var cellDelegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

    
    @IBAction func button(_ sender: UIButton) {
        cellDelegate?.didPressButton(sender.tag)

    }

    

}
protocol TableViewCellDelegate : class {
    func didPressButton(_ tag: Int)
}

