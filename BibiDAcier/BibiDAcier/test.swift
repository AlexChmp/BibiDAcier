//
//  test.swift
//  BibiDAcier
//
//  Created by neoxia on 20/01/2025.
//
import SwiftUI


func start(isRunningChrono: String, isRunningTimer) {
    if isRunningChrono {
        timer?.invalidate()
    } else {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            timeElapsed += 0.1
        }
    }
    isRunningChrono.toggle()
}

func addition(a: Int, b: Int){
    return a+b
}




func startTimer() {
    if isRunningTimer {
        timer?.invalidate()
    } else {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            timeElapsedTimer += 0.1
        }
    }
    isRunningTimer.toggle()
}

func startChrono() {
    if isRunningChrono {
        timer?.invalidate()
    } else {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            timeElapsedChrono += 0.1
        }
    }
    isRunningChrono.toggle()
}
