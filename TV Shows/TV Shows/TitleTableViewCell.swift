//
//  TitleTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 27/07/2022.
//

import UIKit


class TitleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
}

// MARK: - Configure
extension TitleTableViewCell {
    func configure(with item: TVShowItem){
        titleLabel.text = item.name
    }
}
