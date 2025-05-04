//
//  model.swift
//  Moviecontrol
//
//  Created by 제욱 on 4/7/25.
//

import SwiftUI

// MARK: - Model
struct Movie: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
}
