//
//  ViewController.swift
//  Hw5.5
//
//  Created by seunghwa on 5/19/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 데이터 모델
    let heroes = [
        ("배트맨", "배트맨이 출현하는 영화", "batman"),
        ("캡틴 아메리카", "캡틴 아메리카의 기원, 캡틴 아메리카는 어떻게 탄생하게 되었을까?", "captain_america"),
        ("아이언맨", "토니 스타크가 출현, 아이언맨이 탄생하게된 계기가 재미있는 영화", "ironman"),
        ("토르", "아스가르드의 후계자 토르가 지구에 오게되는 스토리", "thor"),
        ("헐크", "브루스 배너 박사의 실험을 통해 헐크가 탄생하게 되는 영화", "hulk"),
        ("스파이더맨", "피터 파커 학생에서 스파이더맨이 되는 과정을 담은 스토리", "spiderman"),
        ("블랙팬서", "와칸다의 왕위 계승자 티찰라 블랙팬서가 된다.", "blackpanther")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 테이블 뷰 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 테이블 뷰 행 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200.0 // 원하는 높이 (예: 100포인트, 기본값은 약 44포인트)
        }
    // 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableViewCell
        
        let hero = heroes[indexPath.row]
        cell.heroNameLabel.text = hero.0
        cell.heroDescriptionLabel.text = hero.1
        cell.heroImageView.image = UIImage(named: hero.2)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            print("Segue 호출 시도: ShowDetail, 인덱스: \(indexPath.row)")
            performSegue(withIdentifier: "ShowDetail", sender: indexPath)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            print("prepare(for segue:) 호출됨, identifier: \(String(describing: segue.identifier))")
            if segue.identifier == "ShowDetail" {
                print("Segue Identifier 일치: ShowDetail")
                if let detailVC = segue.destination as? DetailViewController {
                    print("DetailViewController 캐스팅 성공")
                    if let indexPath = sender as? IndexPath {
                        let hero = heroes[indexPath.row]
                        detailVC.heroName = hero.0
                        detailVC.heroDescription = hero.1
                        detailVC.heroImageName = hero.2
                        print("전달된 데이터 - 이름: \(hero.0), 설명: \(hero.1), 이미지: \(hero.2)")
                    } else {
                        print("indexPath 캐스팅 실패")
                    }
                } else {
                    print("DetailViewController 캐스팅 실패")
                }
            } else {
                print("잘못된 Segue Identifier: \(String(describing: segue.identifier))")
            }
        }
    }
// 커스텀 셀 클래스
class HeroTableViewCell: UITableViewCell {
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
}
