# LazyVGrid / LazyHGrid

- **설명**
    - `LazyVGrid`(수직 그리드)와 `LazyHGrid`(수평 그리드)는 SwiftUI에서 데이터를 그리드 형태로 배치하는 데 사용됩니다.
    - "Lazy"라는 이름에서 알 수 있듯이, 화면에 보이는 셀만 메모리에 로드하여 성능을 최적화합니다(레이지 로딩).
    - `LazyVGrid`는 열(column)을 기반으로 수직 스크롤, `LazyHGrid`는 행(row)을 기반으로 수평 스크롤을 제공합니다.
- **주요 특징**
    - **유연한 레이아웃**: 열/행의 크기와 간격을 커스터마이징할 수 있습니다(`GridItem` 사용).
    - **스크롤 방향**: `LazyVGrid`는 수직, `LazyHGrid`는 수평.
    - **성능 최적화**: 보이지 않는 셀은 메모리에 로드되지 않아 대량 데이터 처리에 적합.
    - **사용 예시**: 사진 갤러리, 타일 형태의 UI, 상품 목록 등.
    - **코드 예시**:
        
        ```swift
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(0..<100) { index in
                    Text("Item \\(index)")
                        .frame(height: 100)
                        .background(Color.blue)
                }
            }
            .padding()
        }
        
        ```
        
- **UIKit 대응**
    - **UICollectionView**와 직접 대응.
    - `UICollectionView`처럼 다양한 레이아웃(그리드, 플로우 등)을 지원하며, 셀을 자유롭게 배치할 수 있습니다.
    - `LazyVGrid`/`LazyHGrid`는 `UICollectionViewFlowLayout`과 비슷한 동작을 하지만, SwiftUI의 선언적 문법으로 더 간결하게 구현 가능.

### 2. **List**

- **설명**
    - `List`는 SwiftUI에서 데이터를 단일 열로 나열하는 뷰로, 테이블 형태의 UI를 구현하는 데 사용됩니다.
    - 스크롤 가능한 리스트로, 셀을 동적으로 생성하며 성능 최적화를 위해 레이지 로딩을 사용합니다.
- **주요 특징**
    - **단일 열 레이아웃**: 기본적으로 수직 스크롤만 지원.
    - **스타일링 가능**: iOS의 기본 테이블 뷰 스타일(예: `.plain`, `.grouped`, `.insetGrouped`)을 지원.
    - **동적 데이터 처리**: `ForEach`와 결합하여 동적 데이터 표시가 용이.
    - **사용 예시**: 설정 화면, 연락처 목록, 채팅 목록 등.
    - **코드 예시**:
        
        ```swift
        List {
            ForEach(0..<100) { index in
                Text("Row \\(index)")
                    .padding()
            }
        }
        .listStyle(.plain)
        
        ```
        
- **UIKit 대응**
    - **UITableView**와 직접 대응.
    - `UITableView`의 단일 열, 수직 스크롤 기반 리스트와 유사하며, 셀 재사용과 같은 성능 최적화 기법을 내부적으로 사용.
    - `List`는 `UITableView`보다 선언적이고 간결한 방식으로 UI를 구성할 수 있습니다.

---

### 3. **LazyVGrid / LazyHGrid vs List 비교**

| **특징** | **LazyVGrid / LazyHGrid** | **List** |
| --- | --- | --- |
| **레이아웃** | 다열/다행 그리드 (2D 레이아웃) | 단일 열 (1D 레이아웃) |
| **스크롤 방향** | 수직(`LazyVGrid`) / 수평(`LazyHGrid`) | 수직 스크롤만 지원 |
| **성능 최적화** | 보이는 셀만 로드 (Lazy 로딩) | 보이는 셀만 로드 (Lazy 로딩) |
| **사용 사례** | 사진 갤러리, 상품 목록, 타일 UI | 설정 화면, 연락처, 간단한 목록 UI |
| **커스터마이징** | 열/행 크기와 간격 조정 가능 (`GridItem`) | 스타일(`.plain`, `.grouped`) 및 셀 커스터마이징 |
| **UIKit 대응** | `UICollectionView` | `UITableView` |

---

### 4. **CollectionView vs TableView와의 개념 대응**

- **LazyVGrid / LazyHGrid ↔ UICollectionView**
    - `UICollectionView`는 다양한 레이아웃(그리드, 커스텀 등)을 지원하며, `LazyVGrid`/`LazyHGrid`는 이와 유사하게 다열/다행 레이아웃을 제공.
    - `UICollectionView`는 레이아웃 객체(예: `UICollectionViewFlowLayout`)를 통해 복잡한 설정이 필요하지만, SwiftUI의 그리드는 `GridItem`으로 간단히 구성 가능.
    - 공통점: 셀 재사용, 레이지 로딩, 대량 데이터 처리.
- **List ↔ UITableView**
    - `UITableView`는 단일 열, 수직 스크롤 기반의 리스트를 제공하며, `List`는 동일한 역할을 SwiftUI에서 수행.
    - `UITableView`는 데이터 소스와 델리게이트 패턴을 사용하지만, `List`는 SwiftUI의 선언적 문법으로 더 간결하게 구현.
    - 공통점: 셀 재사용, 섹션/헤더 지원, 스크롤 최적화.

---

### 5. 사용 상황

- **LazyVGrid / LazyHGrid**:
    - 다열/다행 레이아웃이 필요한 경우(예: 갤러리, 상품 목록).
    - 복잡한 2D 레이아웃을 간단히 구현하고 싶을 때.
    - 수평/수직 스크롤이 모두 필요한 UI.
- **List**:
    - 단순한 단일 열 리스트가 필요한 경우(예: 설정, 채팅 목록).
    - iOS 네이티브 스타일의 테이블 뷰 UI를 빠르게 구현하고 싶을 때.
    - 간단한 데이터 나열에 최적화.

---

### 6. **결론**

- `LazyVGrid`/`LazyHGrid`는 `UICollectionView`의 SwiftUI 버전으로, 유연한 2D 레이아웃과 성능 최적화를 제공합니다.
- `List`는 `UITableView`의 SwiftUI 버전으로, 간단한 단일 열 리스트에 적합합니다.