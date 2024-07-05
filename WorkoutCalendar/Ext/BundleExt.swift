//
//  BundleExt.swift
//  PJMusic
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import Foundation

extension Bundle {
    func hasNib(name: String) -> Bool {
        return path(forResource: name, ofType: "nib") != nil
    }
}
