import SwiftUI

struct ContentView: View {
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bmi: Double?  = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("키와 몸무게를 입력해 주세요")
                    .font(.title2)
                    .padding()
                
                VStack() {
                    Text("키")
                    TextField("키", text: $height)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width : 350)
                    

                }
                
                // Weight input
                VStack() {
                    Text("몸무게")
                    TextField("몸무게", text: $weight)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 350)
                       
                }
                
                Spacer()
                
                // Calculate BMI button
                NavigationLink(
                    destination: ResultView(bmi: calculateBMI(), onRecalculate: {
                        bmi = nil
                    }),
                    label: {
                        Text("BMI 계산하기")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                )
                
                Spacer()
            }
            .background(Color.gray.opacity(0.1))
            .navigationBarHidden(true)
        }
    }
    
    func calculateBMI() -> Double {
        guard let heightValue = Double(height),
              let weightValue = Double(weight),
              heightValue > 0 else {
            return 0.0
        }
        let heightInMeters = heightValue / 100
        return weightValue / (heightInMeters * heightInMeters)
    }
}

struct ResultView: View {
    let bmi: Double
    let onRecalculate: () -> Void
    
    // Determine the color based on BMI range
    var bmiColor: Color {
        if bmi < 18.5 {
            return .blue // Underweight
        } else if bmi < 25 {
            return .green // Normal
        } else {
            return .red // Overweight
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("BMI 결과")
                .font(.title2)
                .padding(.top, 50)
            
            Text(String(format: "%.2f", bmi))
                .font(.largeTitle)
                .padding()
                .background(bmiColor.opacity(0.3))
                .cornerRadius(10)
            
            Spacer()
            
            // Recalculate button
            NavigationLink(
                destination: ContentView(),
                label: {
                    Text("다시 계산하기")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            )
            
            Spacer()
        }
        .background(Color.gray.opacity(0.1))
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

