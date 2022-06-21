//
//  ContentView.swift
//  BarChartExpenseDemo
//
//  Created by Thongchai Subsaidee on 21/6/22.
//

import SwiftUI

enum Month: String, CaseIterable {
    case jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
}

struct MonthlyExpense: Identifiable {
    var id = UUID()
    var month: Month
    var value: Double
    var name: String {
        month.rawValue.capitalized
    }
}

extension MonthlyExpense {
    static var sampleData: [MonthlyExpense] {
        [
            MonthlyExpense(month: Month.jan, value: 5000),
            MonthlyExpense(month: Month.feb, value: 2000),
            MonthlyExpense(month: Month.mar, value: 3000),
            MonthlyExpense(month: Month.apr, value: 1002),
            MonthlyExpense(month: Month.may, value: 2320),
            MonthlyExpense(month: Month.jun, value: 4536),
            MonthlyExpense(month: Month.jul, value: 8764),
            MonthlyExpense(month: Month.aug, value: 3434),
            MonthlyExpense(month: Month.sep, value: 4545),
            MonthlyExpense(month: Month.oct, value: 9067),
            MonthlyExpense(month: Month.nov, value: 2362),
            MonthlyExpense(month: Month.dec, value: 5300)
        ]
    }
    
    static var maxValue: Double {
        let maxData = sampleData.max { exp1, exp2 in
            exp1.value < exp2.value
        }
        return maxData!.value
    }
}

struct Util {
    static func normalizeddata(maxBarHeight: Double, value: Double, max: Double) -> Double {
        return (maxBarHeight * value) / max
    }
}

struct ContentView: View {
    
    var sampleData = MonthlyExpense.sampleData //.shuffled()
    @State private var animate = false
    @State private var selectedValue = "None"
    
    var body: some View {
        VStack {
            
            Text("Selected: \(selectedValue)")
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.purple, in: RoundedRectangle(cornerRadius: 5))
            
            
            HStack {
                ForEach(sampleData) { data in
                    VStack {
                        ZStack(alignment: .bottom) {
                            
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.pink.opacity(0.05))
                                .frame(width: 20, height: 300)
                            
                            RoundedRectangle(cornerRadius: 5)
                                .fill(LinearGradient(colors: [.purple, .blue], startPoint: .bottom, endPoint: .top))
                                .frame(width: 20, height: animate ? Util.normalizeddata(maxBarHeight: 250, value: data.value, max: MonthlyExpense.maxValue) : 0)
                                .animation(.easeOut.speed(0.3).delay(1), value: animate)
                        }
                        
                        Text(data.name)
                            .font(.caption2)
                            .layoutPriority(2)
                            .rotationEffect(.degrees(-45))
                            .padding(.top)
                        
                    }
                    .onTapGesture {
                        selectedValue = String(format: "%@ %.0f", data.name, data.value )
                    }
                }
            }
            .onAppear {
                animate.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
