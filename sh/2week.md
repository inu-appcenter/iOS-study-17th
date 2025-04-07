# 제목 없음

**import** SwiftUI

**struct** ContentView: View {

@State **private** **var** height: String = ""

@State **private** **var** weight: String = ""

@State **private** **var** bmi: Double? = **nil**

**var** body: **some** View {

NavigationStack {

VStack(spacing: 20) {

Text("키와 몸무게를 입력해주세요")

.font(.title2)

.padding(.top, 40)

VStack {

Text("키")

.font(.title2)

TextField("키", text: $height)

.keyboardType(.numberPad)

.textFieldStyle(RoundedBorderTextFieldStyle())

.padding(.horizontal)

.frame(width: 350)

}

VStack {

Text("몸무게")

.font(.title2)

TextField("몸무게", text: $weight)

.keyboardType(.numberPad)

.textFieldStyle(RoundedBorderTextFieldStyle())

.padding(.horizontal)

.frame(width: 350)

}

Spacer()

NavigationLink("BMI 계산하기", destination: SecondView(bmi: calculatebmi(), recalculate: {

bmi = **nil**

}))

.disabled(height.isEmpty || weight.isEmpty)

.font(.title3)

.frame(maxWidth: .infinity)

.padding()

.background(Color.blue)

.foregroundColor(Color.white)

.cornerRadius(10)

.padding()

}

.padding()

}

}

**func** calculatebmi() -> Double {

**guard** **let** heightValue = Double(height),

**let** weightValue = Double(weight),

heightValue > 0 **else** {

**return** 0.0

}

**let** heightmeters = heightValue / 100

**return** weightValue / (heightmeters * heightmeters)

}

}

**struct** SecondView: View {

**let** bmi: Double

**let** recalculate: () -> Void

**func** bmicolor() -> Color {

**if** bmi < 18.5 {

**return** Color.blue

} **else** **if** bmi < 24.9 {

**return** Color.green

} **else** {

**return** Color.red

}

}

**var** body: **some** View {

VStack(spacing: 20) {

Text("BMI 결과")

.font(.title2)

.padding(.top, 50)

Text(String(format: "%.2f", bmi))

.font(.largeTitle)

.padding()

.background(bmicolor().opacity(0.3))

.cornerRadius(10)

Spacer()

NavigationLink("다시 계산하기", destination: ContentView())

.font(.title3)

.frame(maxWidth: .infinity)

.padding()

.background(Color.blue)

.foregroundColor(.white)

.cornerRadius(10)

.padding(.horizontal)

Spacer()

}

.background(Color.gray.opacity(0.1))

.navigationBarHidden(**true**)

}

}

#Preview {

ContentView()

}