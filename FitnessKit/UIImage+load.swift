//
//  UIImage+load.swift
//  FitnessKit
//
//  Created by Oleg Sitnikov on 02.03.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import  UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
