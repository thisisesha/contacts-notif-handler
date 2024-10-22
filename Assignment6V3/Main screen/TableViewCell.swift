//
//  TableViewCell.swift
//  Assignment6V3
//
//  Created by Esha Chiplunkar on 10/21/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       // setupWrapperCellView()
        setupLabelName()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.layer.cornerRadius = 8
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.systemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
//            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
//            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
//            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            labelName.heightAnchor.constraint(equalToConstant: 20),
            labelName.widthAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor),
                
         //   wrapperCellView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

}
