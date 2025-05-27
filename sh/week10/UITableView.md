# UITableView

UITableView는 iOS 개발에서 UIKit 프레임워크의 핵심 컴포넌트로, 스크롤 가능한 목록 형태의 데이터를 표시하는 데 사용됩니다. 주로 테이블 뷰(Table View)라고 불리며, 데이터를 행(row) 단위로 세로로 배치하여 사용자에게 보여줍니다. 예를 들어, 설정 앱의 메뉴 목록이나 연락처 앱의 연락처 목록이 UITableView로 구현된 대표적인 사례입니다.

### 주요 특징

1. **구조**:
    - UITableView는 셀(UITableViewCell)로 구성된 행(row)과 섹션(section)으로 나뉩니다.
    - 각 섹션은 헤더/푸터를 가질 수 있으며, 여러 행을 포함합니다.
    - 셀은 텍스트, 이미지, 버튼 등 다양한 콘텐츠를 표시할 수 있습니다.
2. **데이터 소스와 델리게이트**:
    - **데이터 소스(UITableViewDataSource)**: 테이블 뷰에 표시할 데이터와 셀을 제공합니다. 필수 메서드:
        - `tableView(_:numberOfRowsInSection:)`: 섹션별 행 수 반환.
        - `tableView(_:cellForRowAt:)`: 각 셀의 콘텐츠 구성.
    - **델리게이트(UITableViewDelegate)**: 사용자 상호작용(셀 선택, 스크롤, 편집 등)을 처리합니다. 예:
        - `tableView(_:didSelectRowAt:)`: 셀 선택 시 호출.
        - `tableView(_:heightForRowAt:)`: 셀 높이 지정.
3. **셀 재사용**:
    - 메모리 효율성을 위해 셀을 재사용합니다. `dequeueReusableCell(withIdentifier:for:)` 메서드를 사용해 셀을 재활용합니다.
    - 셀 식별자(identifier)를 지정하여 다양한 셀 디자인을 관리할 수 있습니다.
4. **스타일**:
    - **Plain**: 기본 스타일로, 간단한 목록에 적합.
    - **Grouped**: 섹션별로 그룹화된 스타일, 예: 설정 앱.
    - **Inset Grouped**: 그룹 스타일에 여백이 추가된 형태(iOS 13+).
5. **커스터마이징**:
    - 셀의 레이아웃, 스타일, 애니메이션을 자유롭게 커스터마이징 가능.
    - 셀 배경, 액세서리 뷰(예: 화살표, 체크마크) 등을 추가할 수 있음.
6. **편집 기능**:
    - 셀의 삭제, 추가, 순서 변경 등 편집 모드를 지원.
    - 스와이프 동작으로 삭제 버튼이나 사용자 지정 액션을 구현 가능.

### 사용 예시 (Swift)

```swift
import UIKit

// ViewController 클래스가 UITableViewDataSource와 UITableViewDelegate 프로토콜을 채택
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 테이블 뷰를 Interface Builder와 연결하기 위한 아울렛
    @IBOutlet weak var tableView: UITableView!
    
    // 테이블 뷰에 표시할 샘플 데이터 배열
    let data = ["항목 1", "항목 2", "항목 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰의 데이터 소스를 현재 ViewController로 설정
        tableView.dataSource = self
        
        // 테이블 뷰의 델리게이트를 현재 ViewController로 설정
        tableView.delegate = self
        
        // 기본 UITableViewCell을 "Cell" 식별자로 등록
        // 셀 재사용을 위해 등록하며, 스토리보드나 XIB 없이 코드로 셀을 사용할 때 필요
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - UITableViewDataSource 메서드
    
    // 각 섹션의 행(row) 수를 반환하는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 데이터 배열의 요소 수만큼 행을 반환
        return data.count
    }

    // 각 행에 표시할 셀을 구성하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용 가능한 셀을 "Cell" 식별자로 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // 셀의 텍스트 레이블에 데이터 배열의 해당 항목 표시
        cell.textLabel?.text = data[indexPath.row]
        
        // 구성된 셀 반환
        return cell
    }

    // MARK: - UITableViewDelegate 메서드
    
    // 사용자가 셀을 선택했을 때 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 항목의 데이터를 콘솔에 출력
        print("\(data[indexPath.row]) 선택됨")
        
        // 셀 선택 효과(회색 배경)를 애니메이션과 함께 제거
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
```

### 주요 메서드와 속성

- **reloadData()**: 테이블 뷰를 새로고침하여 데이터를 다시 로드.
- **separatorStyle**: 셀 간 구분선 스타일 설정.
- **rowHeight**: 기본 행 높이 설정.
- **estimatedRowHeight**: 동적 높이 셀을 위한 예상 높이.

### 언제 사용하나?

- 목록 형태의 데이터를 표시할 때 (예: 뉴스 피드, 채팅 목록).
- 복잡한 레이아웃이 필요하지 않은 경우 (복잡한 경우 UICollectionView 고려).
- 스크롤과 셀 재사용이 필요한 인터페이스.

### 대안

- **UICollectionView**: 더 유연한 그리드 또는 커스텀 레이아웃을 원할 때.
- **SwiftUI의 List**: SwiftUI를 사용하는 경우, 더 간단한 API로 비슷한 기능 제공.

# UIScrollView

**UIScrollView**는 UIKit에서 스크롤 가능한 콘텐츠를 표시하는 기본 컴포넌트로, 자유로운 레이아웃과 스크롤 동작을 지원합니다. 확대/축소, 페이징 등 다양한 기능을 제공합니다.

### 주요 특징

- **스크롤**: `contentSize`로 스크롤 가능한 영역 정의, 수평/수직 스크롤 가능.
- **줌**: `minimumZoomScale`, `maximumZoomScale`로 확대/축소 설정.
- **페이징**: `isPagingEnabled`로 페이지 단위 스크롤 활성화.
- **델리게이트**: `UIScrollViewDelegate`로 스크롤, 줌, 드래그 이벤트 처리.
- **커스텀 콘텐츠**: 이미지, 텍스트, 커스텀 뷰 등을 자유롭게 배치.

### 언제 사용?

- 단일 콘텐츠 스크롤 (예: 긴 문서, 이미지 뷰어).
- 페이징 기반 UI (예: 온보딩 화면).
- **UITableView**나 **UICollectionView**로 해결하기 어려운 비표준 레이아웃.

### 코드 예시 (Swift)

```swift
import UIKit

class ScrollViewController: UIViewController {
    // 스크롤 뷰 인스턴스 선언
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 스크롤 뷰를 뷰에 추가 및 레이아웃 설정
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // 콘텐츠로 사용할 레이블 생성
        let label = UILabel()
        label.text = "이것은 긴 텍스트입니다.\\n" + String(repeating: "스크롤 테스트\\n", count: 20)
        label.numberOfLines = 0
        scrollView.addSubview(label)

        // 레이블의 Auto Layout 설정
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: scrollView.topAnchor),
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        // 스크롤 뷰의 콘텐츠 크기는 Auto Layout에 의해 자동 설정
        scrollView.delegate = self
    }
}

// 스크롤 뷰 델리게이트 확장
extension ScrollViewController: UIScrollViewDelegate {
    // 스크롤 시 호출
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("현재 스크롤 위치: \\(scrollView.contentOffset.y)")
    }
}

```

### 주요 속성과 메서드

- `contentSize`: 스크롤 가능한 콘텐츠 크기.
- `contentOffset`: 현재 스크롤 위치.
- `bounces`: 경계 바운스 효과.
- `setContentOffset(_:animated:)`: 프로그래밍 방식으로 스크롤 이동.

# UICollectionView

**UICollectionView**는 데이터를 격자(grid) 또는 커스텀 레이아웃으로 표시하는 유연한 컴포넌트입니다. **UITableView**보다 복잡한 레이아웃을 지원하며, 셀 재사용으로 메모리 효율성을 유지합니다.

### 주요 특징

- **레이아웃**: `UICollectionViewFlowLayout` 또는 커스텀 레이아웃으로 격자, 플로우, 비선형 UI 구현.
- **셀 재사용**: `dequeueReusableCell`로 효율적 메모리 관리.
- **데이터 소스**: `UICollectionViewDataSource`로 데이터 제공.
- **델리게이트**: `UICollectionViewDelegate`로 사용자 상호작용 처리.
- **섹션**: 헤더, 푸터, 셀을 포함한 섹션 구성 가능.

### 언제 사용?

- 사진 갤러리, 타일 UI, 다중 열 레이아웃 (예: Instagram 피드).
- 복잡한 스크롤 방향 또는 비표준 레이아웃이 필요한 경우.

### 코드 예시 (Swift)

```swift
import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 컬렉션 뷰 인스턴스
    private var collectionView: UICollectionView!
    private let data = ["항목 1", "항목 2", "항목 3", "항목 4", "항목 5"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // 플로우 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100) // 셀 크기
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 섹션 여백

        // 컬렉션 뷰 초기화
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white

        // 셀 등록
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // 뷰에 추가
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - UICollectionViewDataSource

    // 아이템 수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // 셀에 레이블 추가 (예시)
        let label = UILabel(frame: cell.bounds)
        label.text = data[indexPath.item]
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        cell.backgroundColor = .lightGray
        return cell
    }

    // MARK: - UICollectionViewDelegate

    // 셀 선택 시 호출
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("선택된 항목: \\(data[indexPath.item])")
    }
}

```

### 주요 속성과 메서드

- `collectionViewLayout`: 레이아웃 객체.
- `reloadData()`: 데이터 새로고침.
- `dequeueReusableCell(withReuseIdentifier:for:)`: 셀 재사용.
- `UICollectionViewFlowLayout.sectionInset`: 섹션 여백 설정.

---

### 비교: UIScrollView vs. UITableView vs. UICollectionView

| **특징** | **UIScrollView** | **UITableView** | **UICollectionView** |
| --- | --- | --- | --- |
| **용도** | 자유로운 스크롤 콘텐츠 표시 | 세로 목록 데이터 표시 | 격자 또는 커스텀 레이아웃 데이터 표시 |
| **레이아웃** | 수동으로 콘텐츠 배치 | 행/섹션 기반 (세로 고정) | 플로우 또는 커스텀 레이아웃 |
| **셀 재사용** | 없음 | 지원 (dequeueReusableCell) | 지원 (dequeueReusableCell) |
| **데이터 관리** | 없음 (개발자 직접 관리) | UITableViewDataSource | UICollectionViewDataSource |
| **사용자 상호작용** | UIScrollViewDelegate (스크롤, 줌) | UITableViewDelegate (선택, 편집) | UICollectionViewDelegate (선택 등) |
| **복잡성** | 낮음 (단순 스크롤) | 중간 (목록 관리) | 높음 (복잡한 레이아웃) |
| **사용 예** | 이미지 뷰어, 긴 텍스트, 온보딩 화면 | 설정 메뉴, 연락처 목록 | 사진 갤러리, 타일 UI, Pinterest 스타일 |
| **성능** | 콘텐츠 크기에 따라 메모리 소모 | 셀 재사용으로 효율적 | 셀 재사용으로 효율적 |
| **SwiftUI 대안** | ScrollView | List | LazyVGrid/LazyHGrid |

### 비교 설명

- **UIScrollView**:
    - 가장 기본적이고 유연한 컴포넌트로, 콘텐츠를 수동으로 배치해야 함.
    - 셀 재사용이 없어 대량 데이터에는 비효율적.
    - 간단한 스크롤 UI나 비표준 레이아웃에 적합.
- **UITableView**:
    - 세로 목록에 특화, 셀 재사용으로 메모리 효율적.
    - 간단한 데이터 목록 표시(예: 1열 리스트)에 최적.
    - 복잡한 레이아웃은 구현 어려움.
- **UICollectionView**:
    - 격자, 다중 열, 커스텀 레이아웃 지원으로 유연성 높음.
    - 셀 재사용으로 대량 데이터 처리 가능.
    - 설정이 복잡하고 초기 학습 곡선이 높음.

### 선택 가이드

- **단일 콘텐츠 스크롤** → UIScrollView (예: 긴 문서).
- **간단한 세로 목록** → UITableView (예: 설정 앱).
- **복잡한 레이아웃** → UICollectionView (예: 사진 갤러리).