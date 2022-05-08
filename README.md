# 은행창구 매니저 README

# 🧮 은행 창구 매니저
> 프로젝트 기간 2022.04.25 ~ 2022.05.07  
팀원 : [malrang](https://github.com/kinggoguma), [mmim](https://github.com/JoSH0318) / 리뷰어 : [❤️ Hyunable](https://github.com/hyunable)

- [프로젝트 목표](#프로젝트-목표)
- [실행화면](#실행화면)
- [UML](#uml)
- [STEP 1 기능 구현](#step-1-기능-구현)
    + [고민했던 것들(트러블 슈팅)](#고민한-점트러블-슈팅)
    + [배운 개념](#배운-개념)
    + [PR 후 개선사항](#pr-후-개선사항)
- [STEP 2 기능 구현](#step-2-기능-구현)
    + [고민했던 것들(트러블 슈팅)](#고민한-점트러블-슈팅)
    + [배운 개념](#배운-개념)
    + [PR 후 개선사항](#pr-후-개선사항)
- [STEP 3 기능 구현](#step-3-기능-구현)
    + [고민했던 것들(트러블 슈팅)](#고민한-점트러블-슈팅)
    + [배운 개념](#배운-개념)
    + [PR 후 개선사항](#pr-후-개선사항)
 - [STEP 4 기능 구현](#step-4-기능-구현)
    + [고민했던 것들(트러블 슈팅)](#고민한-점트러블-슈팅)
    + [배운 개념](#배운-개념)
- [Ground Rules](#ground-rules)

---
## 프로젝트 목표
1. OOP(Object-Oriented Programming)
2. POP(Protocol-Oriented Programming)
3. SOLID 원칙

---

## 실행화면
![](https://i.imgur.com/DRNnZyH.gif)

---

## UML
<img width="700" src="https://i.imgur.com/WLXWO4X.png"/>

---

## STEP 1 기능 구현
**자료구조 `LinkedList` 와 `Queue` 구현**

1. `class Node<Element>`
    - `value`, `previous`, `next` 프로퍼티를 소유함
2. `struct LinkedList<Element>: Listable`
    - `var count`: 자료구조에 저장된 값이 몇개인지 세어주는 프로퍼티
    - `var isEmpty`: 자료구조에 저장된값이 있는지 없는지를 알려주는 프로퍼티
    - `var first`: 자료구조에 저장된값중 첫번째저장된 값을 알려주는 프로퍼티
    - `append()`: 자료구조에 값을 추가하는 메서드
    - `removeFirst()`: 자료구조에 저장된 첫번째 값을 제거하고 반환하는 메서드
    - `removeAll()`: 자료구조에 저장된 모든 값을 제거하는 메서드
    - `index`: 자료구조에 저장된 특정 인덱스의 값을 조회하는 메서드
    - `insert`: 자료구조에 특정 인덱스에 값을 삽입하는 메서드
3. `protocol Listable`
    - `associatedtype Element`: `Listable`프로토콜을 채택하는 타입에서 사용될 제네릭타입
    - `var count`: 자료구조에 저장된 값이 몇개인지 세어주는 프로퍼티
    - `var isEmpty`: 자료구조에 저장된값이 있는지 없는지를 알려주는 프로퍼티
    - `var first`: 자료구조에 저장된값중 첫번째저장된 값을 알려주는 프로퍼티
    - `append()`: 자료구조에 값을 추가하는 메서드
    - `removeFirst()`: 자료구조에 저장된 첫번째 값을 제거하고 반환하는 메서드
    - `removeAll()`: 자료구조에 저장된 모든 값을 제거하는 메서드
4. `struct Queue<List: Listable>`
    - `var list`: `Listable`을 채택하는 자료구조를 저장할수있는 프로퍼티
    - `var count`: 자료구조에 저장된 값이 몇개인지 세어주는 프로퍼티
    - `var isEmpty`: 자료구조에 저장된값이 있는지 없는지를 알려주는 프로퍼티
    - `var peek`: `list` 자료구조에 저장된값중 첫번째저장된 값을 알려주는 프로퍼티
    - `enqueue()`: `list` 자료구조에 값을 추가하는 메서드
    - `dequeue()`: `list` 자료구조에 저장된 첫번째 값을 제거하고 반환하는 메서드
    - `clear()`: `list` 자료구조에 저장된 모든 값을 제거하는 메서드

### 고민한 점(트러블 슈팅)
1️⃣ Node와 DoubleLinkedList의 의존도를 낮출순 없을까?
- protocol 을 활용해 의존도를 낮춰보려고 고민했다.
- 아래의 예시 코드처럼 Node 가 Connectable 프로토콜을 채택한후
- DoubleLinkedList 에서 head 와 tail 이 Node 타입이 아닌 Connectable 프로토콜 타입으로 정의해 사용할순 없을까 고민했다.
```swift
protocol Connectable {
    associatedType T
    func getValue() -> T 
    func getPrevious() -> Node<T> 
}

class Node<T>: Connectable {
    var value: T
    weak var previous: Node?
    var next: Node?
    
    init(value: T, previous: Node? = nil, next: Node? = nil) {
        self.value = value
        self.previous = previous
        self.next = next
    }
}

struct DoubleLinkedList<T> {
    private var head: Connectable?
    private var tail: Connectable?
    
    var isEmpty: Bool {
        if head == nil {
            return true
        }
        return false
    }
    
    var peek: T? {
        let head = head as? Node<T>
        return head?.value
    }
    
    mutating func enqueue(value: T) {
        if isEmpty {
            head = Node(value: value)
            tail = head
            return
        }
        let oldTail = tail as? Node<T>
        let newNode = Node(value: value, previous: oldTail)
        oldTail?.next = newNode
        tail = newNode
    }
}
```
- 하지만 위 코드의 문제점은 다운캐스팅을 하는 과정에서 다시 의존도가 높아진다는 것이다.
- 그렇다면 head 혹은 tail 이 Node 로 다운캐스팅 성공해야만 enqueue, dequeue 등의 기능을 사용할 수 있게 된다.

2️⃣ DoubleLinkedList의 타입은? class vs struct
- 🤔 DoubleLinkedList는 상속도 참조도 필요없다. 때문에 class를 사용할 이유가 없다.
- struct를 사용하기 때문에 프로퍼티 값의 변경을 주는 메서드에는 필연적으로 mutating이 쓰인다.
- mutating을 사용한 메서드는 COW 방식으로 메모리에서 값이 변하고 때문에 전체값을 복사하는 비용이 발생한다. 
- 또한, 모든 메서드에 mutating을 써줘야한다.
- 이때, 과연 class의 RC보다 비용이 더 적게 들지, 많이 들지 예상할 수 없다.

3️⃣ 순환 참조
- Node 의 next 와 previous 가 var 로 선언된다면 Node 가 여러개 있을때 next 의 Node 와 previous의 Node 가 서로 강한 순한 참조를 하게되어 Node 를 제거해도 메모리에서 해제되지 않는다.
> 이를 해결하기 위해 previous 에 weak 키워드를 사용하여 RC 카운트가 올라가지 않도록 하여 강한 순환 참조를 해결했다.

### 질문사항
1. LinkedList 를 구현하여 Queue 처럼 사용할수있는데 LinkedList와 별개로 Queue 타입을 구현해야 하는지??
2. LinkedList 와 Node 의 결합도를 낮추는 방법은 선호되는 방법인지??

### 배운 개념
- LinkedList
- associatedtype
- 의존성 관리도구
- cocoaPods
- SwiftLint

### PR 후 개선사항
1. LinkedList 추가기능 구현
    - func index(at:): index를 이용한 Queue 조회 기능 구현
    - func insert(valut: , at:): 값을 원하는 index에 삽입하는 기능 구현

2. LinkedList 를 이용한 Queue 구현
>기존에는 `LinkedList` 를 `Queue(First in First Out)` 처럼 사용할수있도록 구현하였다.
>`LinkedList`가 `Queue`처럼 사용될 순 있으나, 모든 `Queue`를 대변하는 자료구조는 아니다.
>`LinkedList`는 `Queue`를 구성하는 하나의 방법론일 뿐이기 때문에 `Queue`타입 객체를 만들어주었다.
>이를 통해 만약 새로운 자료구조 방법론으로 교체된다 하더라도 `Queue`의 수정이 거의 없고, 용이하다.

---
## STEP 2 기능 구현
1️⃣ `struct BankManager`
- `start()`: 은행을 개점하거나 종료하는 메서드
- `printOption()`: `BankManagerConsoleApp` 시작시 출력될 텍스트의 모음
- `inputNumber()`: 유저에게 입력값을 받는 메서드

2️⃣ `struct Bank`
- `let clerk`: 은행에서 근무중인 은행원
- `var cliendQueue`: 은행에 방문하여 접수한 고객들의 대기열
- `var numberOfClients`: 은행에 방문한 총 고객의 수
- `executeBankWork()`: 은행에 방문한 고객들을 대기열에 저장하고 저장한 순서대로 은행원 에게 인계해주는 메서드
- `receiveClients()`: 은행의 대기열에 10~30 사이의 랜덤한 수의 고객들을 저장해주는 메서드
- `serveClients()`: 은행의 대기열이 비어있을때까지 접수한순서대로 고객을 은행원에게 인계하는 메서드

3️⃣ `protocol Workable`
- `func deal(with client: Client?)`: 은행에서 대기중인 손님을 인계 받아 업무를 처리해주는 메서드

4️⃣ `struct BankClerk: Workable`
- `deal(with client: Client?)`: 은행에서 대기중인 손님을 인계 받아 업무를 처리해주는 메서드

5️⃣ `struct Client`
- `var orderNumber`: 은행의 대기번호 

### 고민한 점(트러블 슈팅)
1️⃣ 은행원 객체를 따로 구현할 것인가?
- 현 단계에선 은행원은 1명이 존재하고, 은행원이 가져야하는 속성 및 기능이 적다.
- 때문에 은행원 객체를 따로 구현하는 것이 맞는 것인가에 대해 토론했다.
- OOP 관점에서 보면 Bank 객체의 책임은 하나여야한다.(고객을 받고 대기시키고 대기 순서에 따라 업무를 분배하는 것)
- 은행원의 책임은 각각의 손님을 응대하고 업무를 처리하는 것 뿐이다.(다만 BanK가 은행원을 소유한다.)
> 따라서 은행원 객체(BankClerk)를 구현해야한다.

2️⃣ Bank 타입은 BankClerk 타입을 직접 소유하고 있어야할까?
- Bank 타입이 BankClerk을 직접 소유함으로 인해 결합도가 높아졌다.(재사용성이 떨어진다.)
- 만약, Bank에서 일하는 직원이 BankClerk이 아닌 다른 직원이 고용됐다면 코드의 수정 사항이 많아진다.(유지, 보수 측면에서 안좋다.)
> 이를 해결하기 위한 방법으로 POP를 선택했다.
> Workable porotocol을 생성하고, 이를 채택하고 있는 모든 객체를 Bank에서 소유할 수 있도록 변경했다.
> BankClerk은 Workable을 채택하고, Bank의 clerk 프로퍼티의 타입은 Workable로 설정했다.

### 질문사항
1️⃣ 긴 문구를 처리하는 방법에 대하여 🤔
> 📎 일단 저희는 magic literal을 없애기 위해서 name space를 사용했습니다.

요구사항에 보면 아래와 같은 문구가 있습니다!
![](https://i.imgur.com/T2N5k8d.png)
이런 경우 magic literal을 피하기 위해, name space에 magic literal를 넣어준다면 
아래 코드와 같이 name space를 만들어주어야하고
```swift
enum Constant {
    static let a = "업무가 마감되었습니다. "    
    static let b = "오늘 업무를 처리한 고객은 총 "
    static let c = "명이며, "
    static let d = "총 업무시간은 "
    static let e = "입니다."
}
```
print 할 때는 아래 코드와 같이 사용하게 됩니다.😭 
```swift
print("\(Constant.a)\(Constant.b)\(numberOfClients)\(Constant.c)\(Constant.d)\(totalTime)\(Constant.e)")
```
가독성이 너무 너무 너무 낮고, Constant라는 키워드가 너무 반복적으로 사용되기도 해서 결국 적용하진 않았습니다.

하지만 저희가 초반에 "magic literal을 피하자"라고 정한 컨벤션을 지키지 못하게 됐습니다. 😭
이러한 경우 보통 어떤식으로 처리를 하는게 좋을지 조언을 듣고 싶습니다. 🙏


### 배운 개념
- Concurrent Programming
- DispatchQueue
- DispatchWorkItem
- GCD
- protocol, POP
- Queue

### PR 후 개선사항
1️⃣ `String(format:)` 적용

>**변경전**
>네임스페이스를 활용해 매직리터럴 문자를 개선하였으나 변경전 코드는 `print` 구문 내부에서 어떤 값을 의미하는지 의미를 한번에 이해하기 어려웠다.

```swift
private enum Message {
        static let start = "번 고객 업무 시작"
        static let end = "번 고객 업무 종료"
    }

    print("\(client.orderNumber)\(Message.start)")
    Thread.sleep(forTimeInterval: Constant.workTime)
    print("\(client.orderNumber)\(Message.end)")
```


>**변경후**
>네임스페이스 와 `String(format: )`을 활용해 좀더 이해하기 쉽도록 수정해주었다.
```swift
private enum Message {
        static let start = "%d번 고객 %@업무 시작"
        static let end = "%d번 고객 %@업무 종료"
    }

    let workStartingMessage = String(format: Message.start, client.orderNumber, workType.description)
    let workEndingMessage = String(format: Message.end, client.orderNumber, workType.description)
        
    print(workStartingMessage)
    Thread.sleep(forTimeInterval: workTime)
    print(workEndingMessage)
```

---

## STEP 3 기능 구현
- `enum WorkType: String, CaseIterable`
    - `case loan = 대출`: 은행원, 손님 의 업무 케이스
    - `case deposit = 예금`: 은행원, 손님 의 업무 케이스
- `struct Bank`
    - `measureWorkTime(_ block: () -> Void) -> Double`: 파라미터로 받은 클로저의 실행 시간을 측정하는 메서드
    - `executeWork(of client: Client)`: `Client` 인스턴스의 업무값에따라 담당 은행원에게 인계해준뒤 은행원이 비동기적으로 일하게 하는 메서드
- `BankClerk: Workable`
    - `private(set) var workType`: 은행원의 담당 업무값을 갖는 프로퍼티
    - `private(set) var clerksCountByWork`: 은행원이 몇명인지(스레드를 최대 몇개 사용할수있는지)를 갖는 `DispatchSemaphore`

### 고민한 점(트러블 슈팅)
1️⃣ 재활용성과 확장성에 대한 고민
- 이번 프로젝트에선 업무가 2개(예금, 대출)이지만, 후에 업무가 추가되고 그에 따라서 직원이 새로 배치된다고 가정했다. 
- 이때, 코드의 수정을 최소화하고, 확장에 용이하도록 구현하는 것이 목표였다.
- 첫번째 시도
    1) 직무 별로 직급을 두고 직급별로 객체를 구현하는 것을 시도했다.  
    2) 만약 이럴 경우 타입이 늘어날수록 중복코드가 늘어난다는 문제가 생긴다. 
    3) 이를 해결하기 위해 class를 통한 상속을 이용해야한다. 
    4) superClass로 `Worker`를 두고 중복되는 코드를 구현한다. 
    5) 그리고 업무별 직원 class에 `Worker`를 상속시킨다.
    6) 장점: 직무가 늘어나도 class만 추가만 해주면 되기 때문에 확장성이 매우 용이하, 직무별 달라지는 업무 내용은 `override`를 통해 수정할 수 있다. 
    7) 단점: class로 구현하게 되어 RC 증가로 인해 많은 비용이 든다.
- 두번째 시도
    1) `BankClerk` 구조체를 유지하고, class를 사용하지 않는 방법으로 시도했다.
    2) 문제는 `client.wantedWork`(고객 업무)에 따라 `Clerk`의 업무 내용도 달라져야 한다는 점이었다.
    3) 이 문제를 해결하기 위해서 `WorkType` enum을 만들어줬다.
    4) 직무가 늘어난다면 enum에 csae를 추가하는 것만으로 `BankClerk` 객체에 업무라는 특성을 쥐어줄 수 있다.
    5) `BankClerk`에 `workType: WorkType` 프로퍼티를 만들어주어서 초기화되는 `BankClerk` 인스턴스 별로 식별할 수 있는 직무 특성을 부여했다.
    6) `Bank` 구조체에 직무별 `BankClerk` 인스턴스를 생성하고, dequeue 과정에서 client의 wanedWork가 무엇이냐에 따라 각각의 인스턴스의 `deal(with:)` 메서드를 호출하게 구현했다.
    7) 장점: class를 사용하지 않아 비용이 비교적 적게 든다. / `WorkType` enum에 case 추가와 `Bank` 구조체에 `BankClerk` 인스턴스를 추가하는 것만으로 확장이 가능하다.
    8) 단점: 확장을 하려면 이전에 구현된 약간의 로직을 수정해야한다. / OOP 관점에서 직관적이지 않다.(객체가 나뉘어 있지 않고 하나의 타입이 여러 인스턴스로 생성할 때 나뉘기 때문에)

> apple은 가능하면 많은 비용이 드는 class를 피하라 추천한다. 따라서 다른 방법이 있다면 굳이 class는 피하자는 생각을 했다.
> 따라서, 두번째 방법을 채택했다. 이로인해 OOP 관점에서 멀어진 것은 아닐까 고민을 했다.
> 하지만 관점에 따라서 OOP를 잘 따랐다고도 말할 수 있다.
> 오히려 class를 이용한 상속으로 인해 SOLID 원칙(LSP)을 어기는 상황 또한 고려해봐야 한다고 판단했다.

2️⃣ 재귀함수 말고 다른 방법에 대한 고민 
- 기존 재귀함수로 되어있던 taskStart() 구조를 바꾸어보려고 고민했다.
- 재귀함수는 호출할때마다 이전 함수의 메모리가 해제되지 않아, 메소드 위에 메소드가 올라가는 식으로 메모리에 스택이 쌓이게된다.(반복문 공간복잡도 O(1), 재귀함수 공간복잡도 O(n))
- 이러한 문제를 해결하기위해 재귀함수 말고 다른방법으로 고민후 반복문을 사용해 구현해보았다.

**재귀함수 사용 코드**
```swift
enum SelectOptionType: String {
    case open = "1"
    case close = "2"
}

mutating func taskStart() {
        showMenuMessage()
        guard let selectedOption = SelectOptionType(rawValue: inputNumber()) else {
            return taskStart()
        }
        
        switch selectedOption {
        case .open:
            bank.executeBankWork()
            return taskStart()
        case .close:
            return
        }
```

**while 반복문 사용 코드**
![](https://i.imgur.com/0qg0WCf.png)

3️⃣ Concurrency 
>**이번 프로젝트에선 스레드를 3개만 사용해야한다.**
**따라서 우리가 고려해야할 상황은 race condition과 최대 3개의 스레드였다.**

- **`DispatchQueue.global().async {}` 내부에 `serialMyQueue.sync {}`를 사용한 방법**
    1) 이 방식을 선택한다면 두 문제 상황을 해결할 수 있다.
    2) 하지만 필요로 하는 스레드만큼 `serialMyQueue.sync {}`를 사용해야한다.
    3) 만약 직원이 10명이라고 한다면 10개의 스레드가 필요하기 때문에 10번의 `serialMyQueue.sync {}`를 사용해야한다.
    4) 뿐만 아니라 내부 로직도 반복되기 때문에 좋지 않은 코드가 된다.
    5) 다른 문제는 직무별 최대 스레드를 통제할 수가 없는 점이다. 
    6) 만약 예금 직무가 2개라고 가정한다면, `serialMyQueue.sync {}`를 두번 사용하거나, 다시 한번 비동기를 사용한 반복문을 사용하고 그 안에서 `serialMyQueue.sync {}` 해야한다.
    7) 또한, 직무가 늘어날 때마다 `serialMyQueue.sync {}` 구문이 증가해야한다. 
    8) 때문에 이번 프로젝트에는 합리적인 방법이 아니다.
- **위 방식의 문제를 해결하기 위해 client Queue를 2개 사용**
    1) 만약 예금 고객과 대출 고객의 `Queue`를 각각 `enqueue` 받는다면, 각각의 고객 `Queue` 별로  `DispatchQueue.global().async {}`를 사용하여 `dequeue`해주고 `semaphore`를 통해 스레드 최대수를 통제할 수 있다.
    2) 처음에는 좋은 방법이라고 생각했지만, 확장성 면에서 큰 단점을 발견했다.
    3) 만약 직무가 10개라고 하면, `client`의 `queue`가 10개 존재하게 된다.
    4) 또한 각 직무별 `semaphore` 또한 10개 존재한다.
    5) 때문에 확장성을 고려했을 때 큰 단점이라고 생각되어 선택하지 않았다.
- **semaphore와 직무별 분기를 이용한 방법**
    1) 최대 스레드는 직원의 수만큼 이어야한다. 또한 직무별 최대 스레드는 직무별 직원이 수만큼 이어야한다.
    2) 이 두점을 해결하고자 전체 직원 수만큼의 `semaphore`를 설정하고, 다시 `BankClerk`타입 내부에서 직무별 `semaphore`를 설정하여 문제를 해결하고자 했다.
    3) `DispatchQueue.global().async` 이전에 `전체 semaphore.wait()`을 통해 스레드를 제한했다.
    4) 다음 분기를 통해 선택된 직무별 직원 `deal(with: )` 메서드 내부의 `부분 semaphore.wait() / .signal()`을 통해 직무별 스레드도 제한해줄 수 있었다.
    5) 다만 이 부분에서 문제됐던 점은 `전체 semaphore.wait()`의 시점이었다.
    6) `DispatchQueue.global().async` 이후, 즉 내부에서 `전체 semaphore.wait()`을 사용하면 이미 `semaphore count`가 감소하기 전에 스레드로 던져지기 때문에`semaphore count`과 무관하게 스레드가 이미 생성되버리는 현상이 생겼다.
    7) 이 문제는 `DispatchQueue.global().async` 이전에 해줌으로써 해결할 수 있었다.

```swift
// 수정 전
DispatchQueue.global().async(group: clerks) { [self] in
    self.clerksCount.wait() // `semaphore count`가 1감소 했지만 이미 스레드는 생성
    // some code
    self.clerksCount.signal()
}
// 수정 후

self.clerksCount.wait() // 스레드가 생겨나기 이전에 `semaphore count`가 1감소하여 스레드 제한
DispatchQueue.global().async(group: clerks) { [self] in      
    // some code
    self.clerksCount.signal()
        }
```

### 질문사항
1️⃣ `DispatchSemaphore` 의 네이밍은 어떻게 지어야 할까요? 🤔
- 저희 코드에서 DispatchSemaphore 는 총직원수를 의미합니다
- 그렇기 때문에 총직원수 라는 의미를 갖도록 `clerksCount` 라는 네이밍을 사용했는데요
- DispatchSemaphore 를 사용할때 주로 사용되는 네이밍이 따로 있는지 궁금합니다!!
```swift
private var clerksCount: DispatchSemaphore
```

2️⃣ 재귀함수 말고 다른 좋은 방법!?
- 반복문으로 구현하게되면 `SelectOptionType` 에 추가 case 가 필요하게되어 반복문 을 활용한 코드로 변경하지 않았습니다! 
- 재귀함수, 꼬리재귀 말고 다른 방법으로 아래의 코드를 구현할수있는 좋은방법이있을까요? 🤔

**재귀함수 사용 코드**
```swift
enum SelectOptionType: String {
    case open = "1"
    case close = "2"
}

mutating func taskStart() {
        showMenuMessage()
        guard let selectedOption = SelectOptionType(rawValue: inputNumber()) else {
            return taskStart()
        }
        
        switch selectedOption {
        case .open:
            bank.executeBankWork()
            return taskStart()
        case .close:
            return
        }
```
**while 반복문 사용 코드**
![](https://i.imgur.com/0qg0WCf.png)

### 배운 개념
`@discardableResult`
`DispatchQueue`
`DispatchGroup`
`DispatchWorkitem`
`DispatchSemaphore, wait(), signal()`

### PR 후 개선사항
1️⃣ operation 타입화 -> BlockOperation 방법으로 변경
- 이전 PR에서는 operation을 상속받은 `BankClerk` class를 만들어 task를 타입화하였다.
- 보통 이러한 방법은 task의 코드가 무거워지는 경우 사용하거나, operation을 상속받는 여러 class 객체가 있을 때 사용한다.
- 이를 통해 `각각의 oepration을 상속 받는 class`가 `하나의 작업`을 `하나의 스레드`에서 작업을 처리할 수 있도록 한다. (물론 각자의 class를 operationQueue에 추가해주는 방법을 통해서 -> operationQueue.addOperations([class1, class2]), waitUntilFinished: true)
- 이번 프로젝트는 비교적 task의 코드가 간결하고 oepration을 상속 받는 class가 한 개뿐이다.
- ❗️따라서 이번 프로젝트에 적합한 방법이 아니다.
- BlockOperation처럼 operationQueue에 직접 작업할 코드블럭을 넣어주는 방식으로 변경했다.
- 대신 operationQueue를 두 개를 만들어서 loan, deposit의 task을 각자의 Queue에서 처리하도록 했다.
```swift
loanClerksQueue.maxConcurrentOperationCount = loanClerksCount
depositClerksQueue.maxConcurrentOperationCount = depositClerksCount

// ...some code

switch client.requirementType {
case .loan:
    loanClerksQueue.addOperation { [self] in
        clerk.deal(with: client)
    }
case .deposit:
    depositClerksQueue.addOperation { [self] in
        clerk.deal(with: client)
    }
}

```

---
## STEP 4 기능 구현
**`BankManager Consol App` 을 `IOS UIApp` 으로 전환**

1️⃣ `class MainView`
- `BankManager UIApp` 에서 사용될 `scrollView`, `stackView` 등 루트뷰의 설정을 포함한 타입.
- `makeClientLabel(_ client: Client) -> UILabel`:
  -  은행에 방문한 손님(Client) 를 인자로 받아 손님의 정보를 토대로 `Label` 을 만들어 반환하는 메서드
- `add(waitingClientLabel: UILabel)`:
  -  Label 을 인자로 받아 대기중 스택뷰(waitingListStackView)에 추가 해주는 메서드
- `removeWaitingLabelAndAdd(_ workingLabel: UILabel)`:
  -  Label을 인자로 받아 대기중 스택뷰에서 Label.text 가 일치하는 Label 이 있다면 대기중 스택뷰에서 제거한후 업무중 스택뷰(workingListStackView) 에 해당 Label 을 추가하는 메서드
- `remove(_ workingClient: Client)`:
  - 손님(Client)를 인자로 받아 업무중 스택뷰(waitingListStackView)에서 손님의 정보와 일치하는 Label 을 찾아 제거하는 메서드

2️⃣ `class BankManager`
- `setUp()`:
  -  뷰컨트롤러의 루트뷰에 `MainView` 를 추가하고 `UI` 의 버튼들을 탭했을때 수행될 기능을 연결시켜주는 메서드
- `func didTapClientAppend()`:
  -  `UI`에서의 고객 10명 추가 버튼을 탭하면 실행될 메서드,은행(bank)의 `executeBankWork()`업무시작 메서드를 호출한다.
- `func didTapClientReset()`:
  -  `UI`에서의 초기화 버튼을 탭하면 대기중,업무중 스택뷰에 포함된 레이블을 모두 제거한후, 방문한 고객들을 전부 제거하는 메서드. 은행(bank)의 손님대기열(clientsQueue) 에서 초기화 해주는 `cleat()` 메서드를 호출한다.

3️⃣ `protocol BankDelegate`
- `bank(_ bank: Bank, shouldRecieve waitingClient: Client)`:
  - 손님(Client)을 인자로 받아 손님의 정보를 토대로 Label 을 만든후 대기중 스택뷰에 추가하는 메서드
- `bank(_ bank: Bank, shouldMoveToWorkingList workingClient: Client)`:
  - 손님(Client)을 인자로 받아 손님의 정보를 토대로 Label 을 만든후 대기중 스택뷰에 만든 Label 의 text 와 일치하는 레이블을 대기중 스택뷰에서 제거한후 업무중 스택뷰에 추가하는 메섣, 
- `bank(_ bank: Bank, shouldFinishWork client: Client)`
  -  손님(Client)을 인자로 받아 업무중 스택뷰에서 손님의 정보와 일치하는 레이블을 제거하는 메서드. MainView의 remove() 메서드를 호출한다.

### 고민한 점(트러블 슈팅)
1️⃣ data 전달 방법(NotaficationCenter vs Delegate pattern)
- STEP4에서는 `Bank` 발생하는 작업과 그에 대한 정보 변경을 VC가 알게 해야하고, UI에 반영해야한다.
- `NotaficationCenter`
    - `NotaficationCenter`방법은 일대다 통신 방법에서 유리하다. 즉, 일대다 통신 방법에 많이 사용된다. 
    - 이번 프로젝트는 일대일 통신 방법에 가깝다.
    - 따라서 `NotaficationCenter`를 사용하는 것이 옳지 않다.
    - 또한, 값이 변경한 곳을 추적하기가 어렵다는 단정도 채택하지 않은 이유 중 하나가 됐다.
- `Delegate pattern`
    - 이번 프로젝트는 한 곳의 정보의 변경은 한 곳의 UI에 적용된다.
    - 따라서 일대일 통신에 유리한 `Delegate pattern`이 적합하다고 판단했다.
    - 또한, 정보의 흐름을 파악하기 편해서 동기, 비동기 처리를 경험하는 프로젝트에서 적합하다고 판단했다.
    - protocol에 필요한 메서드를 명확히 명시한 것도 큰 장점 중 하나라고 판단했다.

2️⃣ `Delegate pattern`과 naming
- `Delegate pattern`을 제대로 구현한 경험이 적어서, naming에 고민이 많았다.
- 때문에 apple의 delegate 메서드 스타일을 참고했다.

![](https://i.imgur.com/sBL8pm1.png)

- 위는 tableViewDelegate 메서드이다. 
- apple은 tabelView delegate 메서드명을 
  func <호출 객체의 인스턴스명>(<호출 객체의 타입>, <실행될 동작명: 정보>, <추가적인 정보명: 정보>)와 같은 방법으로 작명한 것을 볼 수 있다.
- 이번 프로젝트에 위와 같은 방법을 적용하면 아래와 같은 네이밍을 할 수 있을 것 같다.

```swift
// protocol
protocol BankDelegate: AnyObject {
    func bank(_ bank: Bank, shouldRecieve waitingClient: Client)
    func bank(_ bank: Bank, shouldMoveToWorkingList workingClient: Client)
    func bank(_ bank: Bank, shouldFinishWork client: Client)
}

class Bank {
    // delegate 프로퍼티
    weak var delegate: BankDelegate?
    
    // 호출부
    delegate?.bank(self, shouldRecieve: client)
}
```

3️⃣ UI를 구성하는 객체 분리
- 모든 UI를 코드로 구현하다 보니 VC의 코드가 길어졌고, 이것을 분리하는 방법을 고민했다.
- UIView 를 상속받는 class `MainView`에 Layout관련 코드를 구현했다.
- 이후, VC의 view위에 `MainView`의 인스턴스 view를 쌓는 방법을 생각했다.
```swift
view.addSubview(mainView)
mainView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    mainView.topAnchor.constraint(equalTo: view.topAnchor),
    mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
])
mainView.makeView()
```
- view.addSubview() 메서드를 통해 인스턴스 view를 추가해주고, NSLayoutConstraint를 통해 constraint을 설정해주었다. 


### 배운 개념
- `Delegate pattern`
- `NotifycationCenter`
- `NSLayoutConstraint`
- `translatesAutoresizingMaskIntoConstraints`

---

## Ground Rules
### 스크럼
- 🌈  10시 시작 
- 스크럼 시간은 30분이 넘지 않기
- 오늘의 목표 / 공유할 이슈 / 컨디션 공유
- 자신의 부족한 부분 / 우리 팀이 아쉬운 부분 토론
- 상황에 따라 조정 가능

### 주간 활동 시간
- 월, 화, 목, 금 : 10시 ~ 22시
- 수요일 : 개인공부
- 점심시간 : 13시 ~ 14시
- 저녁시간 : 18시 ~ 20시
- 상황에 따라 조정 가능

###  🪧 코딩 컨벤션
#### Swift 코드 스타일
코드 스타일은 [스타일쉐어 가이드 컨벤션](https://github.com/StyleShare/swift-style-guide#%EC%A4%84%EB%B0%94%EA%BF%88) 에 따라 진행한다.

#### Commit 규칙
커밋 제목은 최대 50자 입력
본문은 한 줄 최대 72자 입력

#### Commit 메세지
🪛[chore]: 코드 수정, 내부 파일 수정.  
✨[feat]: 새로운 기능 구현.  
🎨[style]: 스타일 관련 기능.(코드의 구조/형태 개선)  
➕[add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가  
🔧[file]: 새로운 파일 생성, 삭제 시  
🐛[fix]: 버그, 오류 해결.  
🔥[del]: 쓸모없는 코드/파일 삭제.  
📝[docs]: README나 WIKI 등의 문서 개정.  
💄[mod]: storyboard 파일,UI 수정한 경우.  
✏️[correct]: 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다.  
🚚[move]: 프로젝트 내 파일이나 코드(리소스)의 이동.  
⏪️[rename]: 파일 이름 변경이 있을 때 사용합니다.  
⚡️[improve]: 향상이 있을 때 사용합니다.  
♻️[refactor]: 전면 수정이 있을 때 사용합니다  
🔀[merge]: 다른브렌치를 merge 할 때 사용합니다.  
✅ [test]: 테스트 코드를 작성할 때 사용합니다.  

#### Commit Body 규칙
제목 끝에 마침표(.) 금지
한글로 작성

#### 브랜치 이름 규칙
`STEP1`, `STEP2`, `STEP3`
