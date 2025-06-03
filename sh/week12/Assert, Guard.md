# Assert, Guard

### 1. **Assertion (`assert`)**

`assert`는 **디버깅 모드**에서만 동작하는 조건 검증 도구입니다. 주로 개발 중 예상치 못한 상황을 점검하거나 코드의 가정을 확인할 때 사용됩니다. 배포 환경(Release 빌드)에서는 `assert`가 무시되므로 성능에 영향을 주지 않습니다.

### **특징**

- **형식**: `assert(_:_:file:line:)`
    - 첫 번째 인자: 검증할 조건 (`Bool` 타입)
    - 두 번째 인자: 조건이 실패했을 때 출력할 오류 메시지 (선택)
    - `file`과 `line`: 오류가 발생한 파일과 라인 번호 (디버깅 정보, 기본값 제공)
- **동작**: 조건이 `false`이면 프로그램이 중단되고 오류 메시지를 출력.
- **사용 환경**: 디버깅 빌드에서만 동작. 배포 환경에서는 코드가 제외됨.
- **용도**: 개발자가 코드의 특정 가정을 검증하거나 디버깅 중 문제를 빠르게 발견할 때 사용.

### **예제**

```swift
var someInt: Int = 0
assert(someInt == 0, "someInt != 0") // 조건 충족, 정상 실행
someInt = 1
// assert(someInt == 0, "someInt != 0") // 조건 실패, 프로그램 중단

```

- `assert`는 코드의 특정 상태를 가정하고 이를 검증할 때 유용. 예를 들어, 함수의 입력값이 특정 조건을 만족해야 한다고 가정할 때 사용.
- 배포 환경에서 동작하지 않으므로, 중요한 로직 검증에는 적합하지 않을 수 있음.

---

### 2. **Precondition (`precondition`)**

`precondition`은 `assert`와 유사하지만, **배포 환경에서도 동작**합니다. 따라서 실제 서비스 환경에서 조건을 강제하고 싶을 때 사용됩니다. 조건이 실패하면 앱이 강제로 종료되므로 신중히 사용해야 합니다.

### **특징**

- **형식**: `precondition(_:_:file:line:)`
    - `assert`와 동일한 인자를 받음.
- **동작**: 조건이 `false`이면 프로그램이 즉시 종료되고 오류 메시지를 출력.
- **사용 환경**: 디버깅 및 배포 환경 모두에서 동작.
- **용도**: 필수적인 조건이 반드시 충족되어야 하는 상황에서 사용. 예를 들어, 앱의 핵심 로직에서 잘못된 입력이 들어오면 앱을 종료시키는 경우.

### **예제**

```swift
func functionWithPrecondition(age: Int?) {
    precondition(age != nil, "age == nil")
    precondition((age! >= 0) && (age! <= 130), "나이값 입력이 잘못되었습니다")
    print("당신의 나이는 \\(age!)세입니다")
}
functionWithPrecondition(age: 50) // 정상 실행
// functionWithPrecondition(age: nil) // 조건 실패, 프로그램 종료

```

### **추가 설명**

- `precondition`은 `assert`와 달리 배포 환경에서도 동작하므로, 사용자 경험에 영향을 줄 수 있음. 따라서 앱이 종료되어도 안전한 상황에서만 사용.
- 예를 들어, 서버에서 받은 데이터가 반드시 유효해야 하는 경우나, 앱의 핵심 기능이 특정 조건에 의존할 때 사용.

---

### 3. **Guard 문 (Early Exit)**

`guard`는 조건이 충족되지 않을 때 코드 블록을 **빠르게 종료**하는 데 사용됩니다. `assert`나 `precondition`과 달리 프로그램을 종료시키지 않고, 특정 조건이 실패하면 제어를 반환하거나 종료시키는 방식으로 동작합니다. 특히 **옵셔널 바인딩**과 함께 자주 사용됩니다.

### **특징**

- **형식**:
    
    ```swift
    guard 조건 else {
        // 조건이 실패했을 때 실행할 코드
        // 반드시 return, break, continue, throw 등의 종료 지시어가 포함되어야 함
    }
    
    ```
    
- **동작**: 조건이 `true`면 다음 코드로 진행, `false`면 `else` 블록 실행 후 종료.
- **사용 환경**: 디버깅 및 배포 환경 모두에서 동작.
- **용도**:
    - 잘못된 입력값 처리
    - 옵셔널 바인딩
    - 조건문을 간결하게 작성하며 코드 가독성 향상

### **예제**

```swift
func functionWithGuard(age: Int?) {
    guard let unwrappedAge = age, unwrappedAge < 130, unwrappedAge >= 0 else {
        print("나이값 입력이 잘못되었습니다")
        return
    }
    print("당신의 나이는 \\(unwrappedAge)세입니다")
}
functionWithGuard(age: 50) // 정상 실행: "당신의 나이는 50세입니다"
// functionWithGuard(age: -1) // "나이값 입력이 잘못되었습니다"
// functionWithGuard(age: nil) // "나이값 입력이 잘못되었습니다"

```

### **추가 설명**

- `guard`는 `if` 문과 반대되는 철학을 가짐. `if`는 조건이 참일 때 실행할 코드를 정의하지만, `guard`는 조건이 거짓일 때 빠르게 종료하도록 설계.
- **가독성**: 복잡한 중첩 `if` 문을 피하고, 함수의 핵심 로직을 간결하게 유지.
- **옵셔널 바인딩**: `guard let`을 사용해 옵셔널 값을 안전하게 언래핑하며, 언래핑된 변수는 `guard` 블록 외부에서도 사용 가능.
- **반드시 종료 지시어 필요**: `else` 블록 내에서 `return`, `break`, `continue`, `throw` 등을 사용해야 컴파일 에러를 피할 수 있음.

### **다양한 사용 사례**

1. **반복문에서의 사용**:
    
    ```swift
    var count = 1
    while true {
        guard count < 3 else {
            break
        }
        print(count)
        count += 1
    }
    // 출력: 1, 2
    
    ```
    
    - `guard`를 사용해 반복문을 조기에 종료.
2. **딕셔너리와 타입 캐스팅**:
    
    ```swift
    func someFunction(info: [String: Any]) {
        guard let name = info["name"] as? String else {
            return
        }
        guard let age = info["age"] as? Int, age >= 0 else {
            return
        }
        print("\\(name): \\(age)")
    }
    someFunction(info: ["name": "yagom", "age": 10]) // 출력: "yagom: 10"
    
    ```
    

---

### **비교 정리**

| 기능 | `assert` | `precondition` | `guard` |
| --- | --- | --- | --- |
| **동작 환경** | 디버깅 모드 | 디버깅 및 배포 | 디버깅 및 배포 |
| **조건 실패 시** | 프로그램 종료, 오류 메시지 | 프로그램 종료, 오류 메시지 | `else` 블록 실행 후 종료 (`return`, `break` 등) |
| **주요 용도** | 디버깅 중 가정 검증 | 필수 조건 강제 | 빠른 종료, 옵셔널 바인딩, 가독성 |
| **오류 처리** | 오류 메시지 출력 | 오류 메시지 출력 | 사용자 정의 처리 (예: 메시지 출력 후 종료) |
| **가독성** | 단순 조건 검증 | 단순 조건 검증 | 복잡한 조건 처리 및 가독성 향상 |

---

### **추가 팁**

1. **언제 무엇을 사용할까?**
    - **디버깅 중 가정 확인**: `assert` 사용. 배포 환경에 영향을 주지 않음.
    - **필수 조건 강제**: `precondition` 사용. 앱의 안정성을 위해 반드시 충족해야 하는 조건에 적합.
    - **빠른 종료 및 가독성**: `guard` 사용. 특히 옵셔널 처리나 복잡한 조건 검증에서 유리.
2. **주의점**
    - `assert`와 `precondition`은 프로그램을 강제로 종료시키므로 사용자 경험에 영향을 줄 수 있음. 특히 `precondition`은 배포 환경에서도 동작하니 신중히 사용.
    - `guard`는 `else` 블록에서 반드시 종료 지시어를 포함해야 하며, 이를 잊으면 컴파일 에러 발생.
3. **실제 사용 예시**
    - 서버 API 호출 후 데이터 검증:
        
        ```swift
        func processUserData(user: [String: Any]) {
            guard let id = user["id"] as? String else {
                print("Invalid user ID")
                return
            }
            precondition(!id.isEmpty, "User ID cannot be empty")
            print("Processing user with ID: \\(id)")
        }
        
        ```
        
        - `guard`로 옵셔널 바인딩 및 초기 검증, `precondition`으로 필수 조건 강제.

---

### **결론**

- `assert`: 디버깅 전용, 가벼운 조건 검증.
- `precondition`: 배포 환경에서도 동작, 필수 조건 강제.
- `guard`: 빠른 종료와 가독성 향상, 옵셔널 처리에 최적.