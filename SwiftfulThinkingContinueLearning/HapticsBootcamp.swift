//
//  HapticsBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by Digital Base on 19/5/25.
//

import SwiftUI

class HapticManager {
    static let instance = HapticManager() // Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("SUCCESS") {
                HapticManager.instance.notification(type: .success)
            }
            Button("WARNING") {
                HapticManager.instance.notification(type: .warning)
            }
            Button("ERROR") {
                HapticManager.instance.notification(type: .error)
            }
            
            Divider()
            
            Button("SOFT") {
                HapticManager.instance.impact(style:.soft)
            }
            Button("LIGHT") {
                HapticManager.instance.impact(style:.light)
            }
            Button("MEDIUM") {
                HapticManager.instance.impact(style:.medium)
            }
            Button("HEAVY") {
                HapticManager.instance.impact(style:.heavy)
            }
            Button("RIGID") {
                HapticManager.instance.impact(style:.rigid)
            }
        }
    }
}

#Preview {
    HapticsBootcamp()
}
