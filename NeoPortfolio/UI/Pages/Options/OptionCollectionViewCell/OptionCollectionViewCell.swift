//
//  OptionCollectionViewCell.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateIsSelectedUI(isSelected: Bool){
        holderView.backgroundColor = isSelected ? .primaryBlue : .white
        var textColor: UIColor = isSelected ? .white : .darkGray
        optionLabel.textColor = textColor
        titleLabel.textColor = textColor
        costLabel.textColor = textColor
        descLabel.textColor = textColor
        selectLabel.textColor = textColor
        selectImageView.tintColor = textColor
        selectImageView.image = UIImage(systemName: isSelected ? "checkmark.circle.fill" : "circle")
        selectLabel.text = isSelected ? "Selected" : "Click To Select"
    }
    
    func setUp(option: String, title: String, cost: String, desc: String, isSelected: Bool){
        optionLabel.text = option
        titleLabel.text = title
        costLabel.text = cost
        descLabel.text = desc
        updateIsSelectedUI(isSelected: isSelected)
    }

}
