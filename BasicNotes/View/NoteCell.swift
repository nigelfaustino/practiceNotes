//
//  NoteCell.swift
//  BasicNotes
//
//  Created by NIGEL FAUSTINO on 2/19/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit
import Stevia

class NoteCell: UITableViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let label2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        sv(label, label2)
        label.top(10).left(20)
        label2.Top == label.Bottom + 10
        label2.left(20).bottom(10)
    }

    func configure(_ note: Note) {
        label.text = note.title
        label2.text = note.body
    }
}
