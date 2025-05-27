# 동기/비동기 개념과 Swift Concurrency

### 1. **동기(Synchronous)와 비동기(Asynchronous) 개념**

- **동기(Synchronous)**:
    - 작업이 **순차적으로** 실행되며, 한 작업이 완료될 때까지 다음 작업이 시작되지 않음.
    - 호출한 함수가 결과를 반환할 때까지 호출자(Caller)는 대기.
    - **특징**:
        - 코드 흐름이 직관적이고 예측 가능.
        - 작업이 오래 걸리면 UI 스레드가 블록되어 앱이 멈춘 것처럼 보일 수 있음(예: 네트워크 요청).
        - **사용 예**: 간단한 계산, 파일 읽기(빠른 경우), UI 업데이트(메인 스레드).
    - **비유**: 전화 통화. 상대방이 응답할 때까지 기다림.
- **비동기(Asynchronous)**:
    - 작업이 **독립적으로** 실행되며, 호출자는 작업 완료를 기다리지 않고 즉시 다음 작업을 진행.
    - 작업 완료 시 콜백, 프로미스, 또는 Swift의 `async/await`를 통해 결과를 처리.
    - **특징**:
        - UI 스레드를 블록하지 않아 앱 응답성이 좋음.
        - 코드가 복잡해질 수 있음(콜백 지옥, 비동기 흐름 관리 필요).
        - **사용 예**: 네트워크 요청, 파일 다운로드, 시간이 오래 걸리는 작업.
    - **비유**: 문자 메시지. 메시지를 보내고 답장이 올 때까지 기다리지 않고 다른 일을 함.

---

### 2. **Swift Concurrency**

Swift Concurrency는 Swift 5.5(iOS 15+)에서 도입된 비동기 프로그래밍을 위한 프레임워크로, 비동기 코드 작성을 간결하고 안전하게 만듭니다.

### **주요 구성 요소**

1. **async/await**:
    - **설명**: 비동기 함수를 정의하고 호출하는 문법.
    - `async`로 비동기 함수를 선언하고, `await`로 비동기 작업의 결과를 기다림.
    - **동기/비동기와의 관계**:
        - `await`는 비동기 작업이 완료될 때까지 실행을 일시 중단(Suspend)하지만, 스레드를 블록하지 않음.
        - 동기 코드처럼 직관적으로 작성 가능하면서 비동기 작업의 이점을 제공.
    - **예시**:
        
        ```swift
        func fetchData() async throws -> String {
            let url = URL(string: "<https://api.example.com>")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return String(decoding: data, as: UTF8.self)
        }
        
        Task {
            do {
                let result = try await fetchData()
                print(result)
            } catch {
                print("Error: \\(error)")
            }
        }
        
        ```
        
2. **Task**:
    - **설명**: 비동기 작업을 실행하는 단위. 메인 스레드나 백그라운드에서 비동기 코드를 실행할 수 있음.
    - **동기/비동기와의 관계**:
        - 비동기 작업을 시작하는 진입점으로, 동기 코드에서 비동기 코드를 호출할 때 사용.
        - `Task.detached`로 독립적인 비동기 작업을 실행 가능.
    - **예시**:
        
        ```swift
        Task { // 비동기 작업 시작
            let data = try await fetchData()
            print(data)
        }
        
        ```
        
3. **Actors**:
    - **설명**: 데이터 경쟁(Data Race)을 방지하기 위해 동시 접근을 관리하는 참조 타입.
    - **동기/비동기와의 관계**:
        - 비동기적으로 안전하게 공유 자원(예: 데이터)에 접근하도록 보장.
        - 동기 코드에서 발생할 수 있는 데이터 충돌 문제를 비동기 환경에서 해결.
    - **예시**:
        
        ```swift
        actor DataStore {
            var count = 0
            func increment() {
                count += 1
            }
        }
        
        let store = DataStore()
        Task {
            await store.increment()
            print(await store.count)
        }
        
        ```
        
4. **Structured Concurrency**:
    - **설명**: 비동기 작업을 계층적으로 관리하여 작업이 완료되거나 취소될 때까지 추적.
    - **예시**: `async let`으로 병렬 작업 실행.
        
        ```swift
        async let first = fetchData()
        async let second = fetchData()
        let results = try await [first, second]
        
        ```
        
5. **MainActor**:
    - **설명**: UI 업데이트처럼 메인 스레드에서 실행해야 하는 작업을 처리.
    - **동기/비동기와의 관계**:
        - 비동기 작업이 메인 스레드에서 안전하게 실행되도록 보장.
    - **예시**:
        
        ```swift
        @MainActor
        func updateUI() {
            label.text = "Updated"
        }
        
        ```
        

---

### 3. **Swift Concurrency와 동기/비동기의 관계**

- **동기 코드와의 통합**:
    - Swift Concurrency는 동기 코드에서 비동기 코드를 호출할 수 있도록 `Task`를 제공.
    - 예: 동기 함수에서 `Task`를 사용해 비동기 작업 실행.
- **비동기 코드의 간소화**:
    - `async/await`는 콜백이나 클로저 기반의 비동기 코드를 대체하여 가독성을 높임.
    - 예: GCD의 `DispatchQueue`나 콜백 대신 `await`로 비동기 작업 처리.
- **성능과 안전성**:
    - `Actors`와 `MainActor`를 통해 비동기 환경에서 데이터 경쟁 방지.
    - 비동기 작업이 스레드를 블록하지 않아 앱 응답성 유지.

---

### 4. **동기/비동기와 Swift Concurrency 사용 사례**

- **동기 작업**:
    - 간단한 계산, 로컬 데이터 처리 등 즉시 완료되는 작업.
    - Swift Concurrency 없이 일반 함수로 충분.
- **비동기 작업**:
    - 네트워크 요청, 파일 I/O, 시간 소모 작업.
    - Swift Concurrency의 `async/await`, `Task`, `Actors`로 처리.
    - 예: API 호출, 이미지 다운로드, 데이터베이스 쿼리.
- **Swift Concurrency의 이점**:
    - 콜백 지옥 제거, 에러 처리 간소화(`try/catch`).
    - 병렬 작업(`async let`)과 안전한 동시성(`Actors`) 지원.

---

### 5. **결론**

- **동기**: 작업이 순차적, 즉시 결과 반환, 스레드 블록 가능.
- **비동기**: 작업이 독립적, 스레드 블록 없이 결과 대기.
- **Swift Concurrency**:
    - `async/await`, `Task`, `Actors`를 통해 비동기 프로그래밍을 간결하고 안전하게 구현.
    - 동기 코드와 비동기 코드를 자연스럽게 통합, UI 응답성과 성능 최적화.
    - 네트워크 요청, 파일 처리 등 비동기 작업에서 특히 유용.