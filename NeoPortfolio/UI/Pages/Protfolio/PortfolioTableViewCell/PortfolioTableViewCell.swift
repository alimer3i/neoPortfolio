//
//  PortfolioTableViewCell.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(name: String, balance: String){
        nameLabel.text = name
        balanceLabel.text = balance
    }
    
}
