//
//  RecordTableCell.swift
//  oly
//
//  Created by Niranjan Ravichandran on 9/14/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class RecordTableCell: UITableViewCell {
    
    var title: UILabel!
    var timestampLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title = UILabel(frame: .init(x: 12, y: 12, width: self.frame.width, height: 20))
        title.textColor = .black
        self.contentView.addSubview(title)
        
        timestampLabel = UILabel(frame: .init(x: 0, y: 12, width: self.frame.width, height: 0))
        timestampLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(timestampLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareView(withRecord recordModel: RecordTableCellModel) {
        self.title.text = recordModel.name
        self.title.sizeToFit()
        self.timestampLabel.text = recordModel.timestamp
        self.timestampLabel.sizeToFit()
        self.timestampLabel.frame.origin.x = self.contentView.frame.width - self.timestampLabel.frame.width - 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.title.text = nil
//        self.timestampLabel.text = nil
        
    }
    
}


struct RecordTableCellModel {
    
    var name: String!
    var timestamp: String!
    var path: URL!
    var duration: Double = 0
    
    init(record: Record) {
        self.name = record.name.replacingOccurrences(of: GlobalConstants.defaultAudioFormat, with: "")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        self.timestamp = dateFormatter.string(from: record.timestamp)
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        path = paths[0].appendingPathComponent(self.name)
    }
}
