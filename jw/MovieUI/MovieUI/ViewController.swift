//
//  ViewController.swift
//  MovieUI
//
//  Created by 제욱 on 5/27/25.
//

import UIKit
//테이블 뷰 제어를 위한 deligate랑 datasource
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //구조체
    struct Movie {
        let title: String
        let info: String
        let imageName: String
    }
    //데이터
    let movie: [Movie] = [
        Movie(title: "batman", info: "batmanbatmanbatman", imageName: "batman"),
        Movie(title: "blackpanther", info: "blackpantherblackpantherblackpanther", imageName: "blackpanther"),
        Movie(title: "captain", info: "captaincaptaincaptain", imageName: "captain"),
        Movie(title: "doctorstrange", info: "doctorstrangedoctorstrangedoctorstrange", imageName: "doctorstrange"),
        Movie(title: "guardians", info: "guardiansguardiansguardians", imageName: "guardians"),
        Movie(title: "hulk", info: "hulkhulkhulk", imageName: "hulk"),
        Movie(title: "ironman", info: "ironmanironmanironman", imageName: "ironman"),
        Movie(title: "spiderman", info: "spidermanspidermanspiderman", imageName: "spiderman"),
        Movie(title: "spiderman2", info: "spiderman2spiderman2spiderman2", imageName: "spiderman2"),
        Movie(title: "thor", info: "thorthorthor", imageName: "thor"),
    ]
    //tableview 연결
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count//구조체 갯수
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = movie[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = data.info
        cell.posterImageView.image = UIImage(named: data.imageName)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
        // Do any additional setup after loading the view.
    }

