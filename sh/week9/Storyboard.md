# Storyboard

---

## 1. Segue (세그웨이)

### 정의

- Storyboard에서 뷰 컨트롤러 간 전환을 관리하는 연결 방식.

### 주요 특징

- 전환 방식: Push, Modal, Popover, Custom, Unwind.
- Storyboard에서 시각적으로 설정하거나 코드로 제어.

### 관련 명령어 및 코드

- **Segue 호출**:
    
    ```swift
    performSegue(withIdentifier: "SegueIdentifier", sender: self)
    ```
    
    - Storyboard에서 설정한 Segue를 코드로 실행.
- **데이터 전달**:
    
    ```swift
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueIdentifier" {
            if let destinationVC = segue.destination as? TargetViewController {
                destinationVC.data = "전달할 데이터"
            }
        }
    }
    ```
    
    - prepare(for:sender:)를 사용하여 데이터 전달.
- **Unwind Segue**:
    
    ```swift
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        // 이전 화면에서 돌아올 때 실행
    }
    ```
    
    - Storyboard의 Exit에 연결하여 복귀.

### Storyboard 설정

- UIButton/UIView에서 컨트롤 드래그로 대상 뷰 컨트롤러 연결.
- Attributes Inspector에서 Segue Identifier 설정 (예: "SegueIdentifier").
- UINavigationController 사용 시 Push Segue를 위해 내비게이션 스택 확인.

### 사용 예

- 버튼 탭 시 performSegue로 다음 화면 이동.
- 사용자 입력 데이터를 prepare(for:sender:)로 전달.

---

## 2. Delegate (델리게이트)

### 정의

- 객체 간 1:1 통신을 위한 프로토콜 기반 패턴. 데이터 전달/이벤트 처리에 사용.

### Storyboard에서의 역할

- 화면 간 역방향 데이터 전달, 커스텀 컴포넌트 이벤트 처리.

### 관련 명령어 및 코드

- **프로토콜 정의**:
    
    ```swift
    protocol MyDelegate: AnyObject {
        func didSelectItem(_ item: String)
    }
    ```
    
    - 델리게이트 메서드 정의.
- **델리게이트 속성 추가**:
    
    ```swift
    class ChildViewController: UIViewController {
        weak var delegate: MyDelegate?
    }
    ```
    
    - 메모리 누수 방지를 위해 weak 사용.
- **델리게이트 호출**:
    
    ```swift
    delegate?.didSelectItem("선택된 아이템")
    ```
    
    - 이벤트 발생 시 호출.
- **델리게이트 채택 및 구현**:
    
    ```swift
    class ParentViewController: UIViewController, MyDelegate {
        func didSelectItem(_ item: String) {
            print("받은 아이템: \(item)")
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let childVC = segue.destination as? ChildViewController {
                childVC.delegate = self
            }
        }
    }
    ```
    
    - 부모 뷰 컨트롤러에서 프로토콜 채택 및 설정.

### Storyboard 설정

- Storyboard에서 델리게이트는 코드로 설정 (childVC.delegate = self).
- Segue와 함께 데이터 흐름 관리.

### 사용 예

- 모달 뷰에서 입력 텍스트를 부모 뷰로 전달.
- UITableView 셀 선택 이벤트를 상위 컨트롤러로 전달.

---

## 3. Scene (씬)

### 정의

- Storyboard에서 하나의 뷰 컨트롤러와 UI 요소를 나타내는 단위.

### 주요 특징

- 각 Scene은 UIViewController와 연결.
- Storyboard는 여러 Scene과 Segue로 앱 흐름 구성.

### 관련 명령어 및 코드

- **뷰 컨트롤러 인스턴스화**:
    
    ```swift
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerID") as! TargetViewController
    ```
    
    - Storyboard에서 Scene 로드.
- **네비게이션 푸시**:
    
    ```swift
    navigationController?.pushViewController(viewController, animated: true)
    ```
    
    - UINavigationController로 전환.
- **모달 표시**:
    
    ```swift
    present(viewController, animated: true, completion: nil)
    ```
    
    - Scene을 모달로 표시.
- **초기 뷰 컨트롤러 설정**:
    
    ```swift
    window?.rootViewController = storyboard.instantiateInitialViewController()
    ```
    
    - 앱의 첫 Scene 설정.

### Storyboard 설정

- Identity Inspector에서 Scene의 Storyboard ID 설정 (예: "ViewControllerID").
- Initial View Controller 체크박스로 Entry Point 지정.
- UINavigationController/UITabBarController로 Scene 연결.

### 사용 예

- 로그인 Scene에서 성공 시 메인 Scene으로 전환.
- Storyboard로 앱 내비게이션 흐름 설계.

---

## 4. AutoLayout (오토레이아웃)

### 정의

- 다양한 디바이스 크기/방향에 맞게 UI를 배치하는 제약 기반 시스템.

### 주요 개념

- **Constraints**: 뷰의 위치, 크기, 간격 정의.
- **Safe Area**: 노치, 상태바 고려.
- **UIStackView**: 뷰 자동 정렬.

### 관련 명령어 및 코드

- **제약 추가 (Anchor 기반)**:
    
    ```swift
    let button = UIButton(type: .system)
    button.setTitle("Click Me", for: .normal)
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        button.heightAnchor.constraint(equalToConstant: 50)
    ])
    ```
    
    - Anchor로 제약 설정.
- **Visual Format Language (VFL)**:
    
    ```swift
    let button = UIButton(type: .system)
    button.setTitle("Click Me", for: .normal)
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    let views = ["button": button]
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[button]-16-|", options: [], metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[button(50)]", options: [], metrics: nil, views: views))
    ```
    
    - VFL로 복잡한 레이아웃 정의.
- **UIStackView**:
    
    ```swift
    let button1 = UIButton(type: .system)
    button1.setTitle("Button 1", for: .normal)
    let button2 = UIButton(type: .system)
    button2.setTitle("Button 2", for: .normal)
    
    let stackView = UIStackView(arrangedSubviews: [button1, button2])
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.distribution = .fillEqually
    view.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
    ])
    ```
    
    - UIStackView로 뷰 그룹화.
- **레이아웃 업데이트**:
    
    ```swift
    view.setNeedsLayout()
    view.layoutIfNeeded()
    ```
    
    - 레이아웃 강제 업데이트.

### Storyboard 설정

- **Interface Builder**:
    - 컨트롤 드래그로 제약 추가.
    - Pin/Align 메뉴로 간격, 정렬 설정.
    - Embed in Stack View로 UIStackView 생성.
- **Safe Area**:
    - Use Safe Area Layout Guides 활성화.
    - 제약을 Safe Area에 연결.
- **Priority 및 Content Hugging/Compression**:
    - Attributes Inspector에서 Priority (1~1000) 설정.
    - Content Hugging Priority/Compression Resistance Priority로 크기 우선순위 조정.

### 디버깅 명령어

- **View Debugger**:
    - Xcode: View > Debug > View Debugging > Show View Frames
- **런타임 제약 확인**:
    
    ```swift
    po view.constraints
    ```
    
    - 콘솔에서 제약 목록 출력.
- **오류 확인**:
    - Xcode의 빨간/노란 경고로 모호한 제약(Ambiguous) 또는 충돌(Conflicting) 확인.

### 사용 예

- UIButton을 Safe Area 상단 20pt, 좌우 16pt로 고정.
- UIStackView로 버튼/레이블 수직 정렬.