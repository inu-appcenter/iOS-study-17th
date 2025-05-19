//
//  DetailViewController.swift
//  Hw5.5
//
//  Created by seunghwa on 5/19/25.
//

import UIKit

// 상세 뷰 컨트롤러 클래스 정의
class DetailViewController: UIViewController {
    
    // Storyboard에서 연결된 아울렛: 메인 히어로 이미지뷰
    @IBOutlet weak var mainHeroImageView: UIImageView!
    // Storyboard에서 연결된 아울렛: 히어로 이름 레이블
       @IBOutlet weak var heroNameLabel: UILabel!
       // Storyboard에서 연결된 아울렛: 히어로 설명 레이블
       @IBOutlet weak var heroDescriptionLabel: UILabel!
       
       // 전달받을 데이터 변수
       var heroName: String?
       var heroDescription: String?
       var heroImageName: String? // 단일 이미지 이름만 전달받음
       
    override func viewDidLoad() {
            super.viewDidLoad()
            title = "영화목록"
            
            // 아울렛 연결 확인
            guard mainHeroImageView != nil else {
                print("mainHeroImageView 아울렛 연결 실패")
                return
            }
            guard heroNameLabel != nil else {
                print("heroNameLabel 아울렛 연결 실패")
                return
            }
            guard heroDescriptionLabel != nil else {
                print("heroDescriptionLabel 아울렛 연결 실패")
                return
            }
            
            // UI 업데이트를 메인 스레드에서 실행
        DispatchQueue.main.async {
                    if let name = self.heroName, let description = self.heroDescription, let imageName = self.heroImageName {
                        print("데이터 수신 성공 - 이름: \(name), 설명: \(description), 이미지: \(imageName)")
                        self.heroNameLabel.text = name
                        self.heroDescriptionLabel.text = description
                        if let image = UIImage(named: imageName) {
                            self.mainHeroImageView.image = image
                            print("이미지 로드 성공: \(imageName)")
                        } else {
                            print("이미지 로드 실패: \(imageName)")
                        }
                    } else {
                        print("데이터 전달 실패 - 이름: \(String(describing: self.heroName)), 설명: \(String(describing: self.heroDescription)), 이미지: \(String(describing: self.heroImageName))")
                        // nil 값을 처리하여 충돌 방지
                        self.heroNameLabel.text = "이름 없음"
                        self.heroDescriptionLabel.text = "설명 없음"
                        self.mainHeroImageView.image = nil
                    }
            self.heroDescriptionLabel.numberOfLines = 0 // 여러 줄 허용
                        self.heroDescriptionLabel.lineBreakMode = .byWordWrapping
                }
            }
        }
