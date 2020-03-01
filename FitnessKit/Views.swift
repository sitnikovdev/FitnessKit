//
//  Views.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 29.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import UIKit

 class BaseItemLabel: UILabel  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.font = .preferredFont(forTextStyle: .headline)
        self.textColor = .systemGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class BaseItemText: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.font = .preferredFont(forTextStyle: .body)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class BaseImage: UIImageView {

    init(_ image: UIImage, frame: CGRect, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 0 ) {
        super.init(frame: .zero)
        self.frame = CGRect(x: 100, y: 150, width: 70, height: 70)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.isOpaque = true
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(backgroundColor: UIColor, cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
