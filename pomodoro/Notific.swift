//
//  Notific.swift
//  pomodoro
//
//  Created by Ali Siddique on 20/01/2024.
//
import SwiftUI
struct Notific: View {
    @State private var totalSeconds = 20 // Set the initial total seconds
    @State private var minutes = 0
    @State private var seconds = 0
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(String(format: "%02d:%02d", minutes, seconds))
                .font(.largeTitle)
                .onReceive(timer) { _ in
                    if self.totalSeconds > 0 {
                        self.totalSeconds -= 1
                        self.minutes = self.totalSeconds / 60
                        self.seconds = self.totalSeconds % 60
                    } else {
                        // Timer reached 0, send a notification
                        sendNotification()
                        timer.upstream.connect().cancel() // Stop the timer
                    }
                }
            
            Button(action: {
                requestNotificationPermissions()
            }) {
                Text("Request Notification Permissions")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private func sendNotification() {
         let content = UNMutableNotificationContent()
         content.title = "Timer Expired"
         content.body = "Your timer has reached 0."
         
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false) // Trigger notification immediately
         
         let request = UNNotificationRequest(identifier: "timerExpired", content: content, trigger: trigger)
         
         UNUserNotificationCenter.current().add(request) { error in
             if let error = error {
                 print("Error sending notification: \(error.localizedDescription)")
             }
         }
     }
    
    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
            }
            // Handle the user's response to permission request here if needed
        }
    }
}



#Preview {
    Notific()
}
