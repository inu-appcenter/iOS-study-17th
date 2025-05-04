//
//  ContentView.swift
//  BMIdemo
//
//  Created by 제욱 on 4/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var height: String = ""
    @State private var weight: String = ""
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                VStack (spacing: 20) {
                    Text("키와 몸무게를 입력해주세요")
                        .padding(.top, 60)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("키")
                                .padding(10)
                            
                            Text("몸무게")
                        }
                        .padding(.leading)
                        
                        VStack(alignment: .leading) {
                            TextField("cm단위로 입력하세요", text: $height)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            TextField("kg단위로 입력하세요", text: $weight)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .padding(.leading)
                    }
                    .padding(.top, 5)
                    
                    Spacer(minLength: 10)
                    
                    NavigationLink("BMI 계산하기", destination:  resultview())
                        .padding()
                        .frame(width: 350)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
        
#Preview {
ContentView()
}
