//
//  viewmodel.swift
//  Moviecontrol
//
//  Created by 제욱 on 4/7/25.
//

import SwiftUI

// MARK: - ViewModel
class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = [
        Movie(name: "Batman", imageName: "batman", description: "배트맨이 어둠 속에서 고담시를 지키는 이야기"),
        Movie(name: "Iron Man", imageName: "batman", description: "아이언맨이 첨단 슈트로 세상을 구하는 이야기"),
        Movie(name: "Captain America", imageName: "batman", description: "캡틴 아메리카가 정의를 위해 싸우는 이야기"),
        Movie(name: "Spiderman", imageName: "batman", description: "스파이더맨이 거미줄을 타며 세상을 구하는 이미지"),
        Movie(name: "Hulk", imageName: "batman", description: "헐크가 분노로부터 힘을 얻는 이야기"),
        Movie(name: "Thor", imageName: "batman", description: "토르가 묠니르를 들고 번개를 부르는 이야기")
    ]
}
