import SwiftUI

struct TimerPage: View {
    @State private var timeElapsedTimer: Double = 0.0
    @State private var timeElapsedChrono: Double = 0.0
    @State private var isRunningTimer: Bool = false
    @State private var isRunningChrono: Bool = false
    @State private var timer: Timer? = nil
    
    @State private var selectedMinutes: Int = 0

    var body: some View {
        VStack {
            // Timer Section
            VStack(spacing: 20) {
                Text("Timer")
                    .font(.largeTitle)
                    .padding()
                Text(formatTime(timeElapsedTimer))
                    .font(.largeTitle)
                    .padding()
                Picker("", selection: $selectedMinutes) {
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i) min").tag(i)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.horizontal)

                HStack(spacing: 20) {
                    Button(action: { startTimer() }) {
                        Image(systemName: isRunningTimer ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(isRunningTimer ? .red : .green)
                    }
                    
                    Button(action: { resetTimer() }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()

            Divider()
                .padding()

            // Chrono Section
            VStack(spacing: 20) {
                Text("Chrono")
                    .font(.largeTitle)
                    .padding()
                Text(formatTime(timeElapsedChrono))
                    .font(.largeTitle)
                    .padding()

                HStack(spacing: 20) {
                    Button(action: { startChrono() }) {
                        Image(systemName: isRunningChrono ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(isRunningChrono ? .red : .green)
                    }
                    
                    Button(action: { resetChrono() }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
    }

    // Timer Functions
    func startTimer() {
        if isRunningTimer {
            timer?.invalidate()
            timer = nil
        } else {
            timeElapsedTimer = Double(selectedMinutes * 60)
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if timeElapsedTimer > 0 {
                    timeElapsedTimer -= 0.1
                } else {
                    timer?.invalidate()
                    timer = nil
                    isRunningTimer = false
                }
            }
        }
        isRunningTimer.toggle()
    }

    func resetTimer() {
        timer?.invalidate()
        timer = nil
        timeElapsedTimer = 0.0
        isRunningTimer = false
    }

    // Chrono Functions
    func startChrono() {
        if isRunningChrono {
            timer?.invalidate()
            timer = nil
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                timeElapsedChrono += 0.1
            }
        }
        isRunningChrono.toggle()
    }

    func resetChrono() {
        timer?.invalidate()
        timer = nil
        timeElapsedChrono = 0.0
        isRunningChrono = false
    }

    // Time Formatting
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time - floor(time)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}
