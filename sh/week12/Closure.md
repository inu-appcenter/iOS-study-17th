# Closure

### **1. 클로저의 기본 문법**

클로저는 Swift에서 이름 없는 함수로, 코드 블록을 변수나 상수에 저장하거나 함수의 인자로 전달할 수 있는 도구입니다. 클로저는 매개변수, 반환 타입, 실행 코드를 포함하며, `{}`로 정의됩니다.

- **구성 요소**: 매개변수 목록, 반환 타입, `in` 키워드, 실행 코드.
- **용도**: 비동기 작업, 콜백, 함수형 프로그래밍 등에서 자주 사용됩니다.

**코드**:

```swift
{ (매개변수 목록) -> 반환타입 in
    실행 코드
}

```

---

### **2. 클로저의 사용**

클로저는 변수나 상수에 저장하여 재사용 가능한 코드 블록으로 사용할 수 있습니다. 아래 예제에서는 두 정수를 더하는 클로저를 `sum` 상수에 저장하고, 이를 호출하여 결과를 얻습니다.

- 클로저는 함수처럼 호출 가능하며, 타입 명시가 필요합니다 (예: `(Int, Int) -> Int`).

```swift
// sum이라는 상수에 클로저를 할당
let sum: (Int, Int) -> Int = { (a: Int, b: Int) in
    return a + b
}
let sumResult: Int = sum(1, 2)
print(sumResult) // 3

```

---

### **3. 함수의 전달인자로서의 클로저**

클로저는 함수의 매개변수로 전달되어, 함수 내부에서 원하는 로직을 동적으로 실행할 수 있습니다. 이를 통해 코드의 유연성을 높일 수 있습니다.

- **장점**: 동일한 함수를 다양한 클로저와 조합하여 다른 동작을 수행할 수 있습니다.

**코드(ex)**

```swift
let add: (Int, Int) -> Int = { (a: Int, b: Int) in
    return a + b
}
let subtract: (Int, Int) -> Int = { (a: Int, b: Int) in
    return a - b
}
let divide: (Int, Int) -> Int = { (a: Int, b: Int) in
    return a / b
}

func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}

var calculated: Int

calculated = calculate(a: 50, b: 10, method: add)
print(calculated) // 60

calculated = calculate(a: 50, b: 10, method: subtract)
print(calculated) // 40

calculated = calculate(a: 50, b: 10, method: divide)
print(calculated) // 5

// 인라인 클로저
calculated = calculate(a: 50, b: 10, method: { (left: Int, right: Int) -> Int in
    return left * right
})
print(calculated) // 500

```

---

### **4. 클로저의 간소화 문법**

Swift는 클로저의 문법을 간소화하여 코드를 간결하고 읽기 쉽게 만들 수 있는 다양한 방법을 제공합니다.

- **핵심**: 후행 클로저, 반환 타입 생략, 단축 인자 이름, 암시적 반환 등을 활용해 코드의 양을 줄입니다.

### **4.1. 기본 설정**

`calculate` 함수는 두 정수와 클로저를 받아 연산을 수행합니다. 이 함수를 기준으로 간소화 단계를 진행합니다.

**코드(ex)**

```swift
func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}

var result: Int

```

### **4.2. 후행 클로저**

클로저가 함수의 마지막 매개변수일 경우, 매개변수 이름을 생략하고 함수 호출 뒤에 `{}`로 클로저를 작성할 수 있습니다. 이를 후행 클로저(Trailing Closure)라고 합니다.

- **장점**: 코드가 더 자연스럽고 읽기 쉬워집니다.

```swift
result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
    return left + right
}
print(result) // 20

```

### **4.3. 반환타입 생략**

Swift 컴파일러는 클로저의 반환 타입을 함수 시그니처에서 추론할 수 있으므로, `-> Int`를 생략할 수 있습니다. 단, `in` 키워드는 여전히 필요합니다.

- **후행 클로저와 조합 가능**: 더 간결한 코드로 작성할 수 있습니다.

```swift
result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) in
    return left + right
})
print(result) // 20

// 후행 클로저와 함께
result = calculate(a: 10, b: 10) { (left: Int, right: Int) in
    return left + right
}
print(result) // 20

```

### **4.4. 단축 인자 이름**

매개변수 이름을 직접 지정하지 않고, `$0`, `$1` 등의 단축 인자 이름을 사용할 수 있습니다. `$0`은 첫 번째 매개변수, `$1`은 두 번째 매개변수를 나타냅니다.

- **장점**: 매개변수 이름을 생략해 코드가 간결해집니다.

```swift
result = calculate(a: 10, b: 10, method: {
    return $0 + $1
})
print(result) // 20

// 후행 클로저와 함께
result = calculate(a: 10, b: 10) {
    return $0 + $1
}
print(result) // 20

```

### **4.5. 암시적 반환 표현**

클로저의 마지막 줄은 암시적으로 반환값으로 간주되므로, `return` 키워드를 생략할 수 있습니다. 단, 클로저가 한 줄로 작성되어야 합니다.

- **장점**: 단일 표현식 클로저에서 코드가 더욱 간결해집니다.

```swift
result = calculate(a: 10, b: 10) {
    $0 + $1
}
print(result) // 20

// 한 줄로 간결히
result = calculate(a: 10, b: 10) { $0 + $1 }
print(result) // 20

```

### **4.6. 축약 전후 비교**

클로저는 여러 단계의 간소화를 통해 매우 간결한 형태로 변형될 수 있습니다. 아래는 축약 전과 후의 코드를 비교한 예입니다.

- **축약 전**: 모든 타입과 키워드를 명시.
- **축약 후**: 후행 클로저, 단축 인자, 암시적 반환을 활용해 최소화.
- **축약 전**:

```swift
result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) -> Int in
    return left + right
})

```

- **축약 후**:

```swift
result = calculate(a: 10, b: 10) { $0 + $1 }
print(result) // 20

```

---

### **추가 정리 및 요약**

- **클로저의 핵심**: 이름 없는 함수로, 변수에 저장하거나 함수 인자로 전달 가능.
- **주요 활용**: 비동기 작업, 콜백, 함수형 프로그래밍.
- **간소화의 이점**: 코드 가독성과 간결성을 높여 개발 효율성을 개선.
- **주의점**:
    - 간소화된 클로저는 가독성을 해칠 수 있으므로, 팀 내 코드 스타일 가이드에 맞게 사용.
    - 복잡한 로직에서는 명시적 타입과 `return`을 사용하는 것이 가독성에 유리할 수 있음.

---