//
//  resultview.swift
//  BMIdemo
//
//  Created by 제욱 on 4/7/25.
//

import SwiftUI

struct resultview: View {
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("BMI 결과값")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Your BMI is 25.5")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            
                Button("뒤로 가기") {
                                dismiss() // ✅ 이전 화면으로 돌아가기
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
        }
    }
}

#Preview {
    resultview()
}
