//
//  SprintTimerView.swift
//  SprintIntervalApp
//
//  Created by Lucas Romero Magaña on 24/10/24.
//

import SwiftUI

struct SprintTimerView: View {
    let session: SprintSession // Recibe la configuración desde la primera pantalla

    @State private var currentTime = 0
    @State private var totalTime = 0
    @State private var isSprint = true // Indica si es sprint o descanso
    @State private var remainingRepetitions: Int
    @State private var progress: Double = 1.0
    @State private var timer: Timer? = nil

    init(session: SprintSession) {
        self.session = session
        self._remainingRepetitions = State(initialValue: session.repetitions)
    }

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 20) // Círculo gris de fondo

                Circle()
                    .trim(from: 0, to: CGFloat(progress)) // Progreso del círculo
                    .stroke(isSprint ? Color.red : Color.blue, lineWidth: 20)
                    .rotationEffect(.degrees(-90)) // Rotación para que el progreso inicie desde arriba
                    .animation(.linear(duration: 1), value: progress)

                Text("\(currentTime)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .onAppear {
                        startTimer()
                    }
            }
            .frame(width: 250, height: 250) // Tamaño del círculo

            if remainingRepetitions == 0 {
                Text("¡Enhorabuena! Has terminado")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            } else {
                Text(isSprint ? "Sprint" : "Descanso")
                    .font(.title)
                    .padding()
            }
        }
        .navigationTitle("Sprint Timer")
        .onDisappear {
            timer?.invalidate() // Detiene el temporizador cuando la vista desaparece
        }
    }

    func startTimer() {
        if remainingRepetitions == 0 {
            return // No hace nada si las repeticiones han terminado
        }

        if isSprint {
            totalTime = session.totalSprintTime
        } else {
            totalTime = session.totalRestTime
        }

        currentTime = totalTime
        progress = 1.0

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if currentTime > 0 {
                currentTime -= 1
                progress = Double(currentTime) / Double(totalTime)
            } else {
                switchMode() // Cambia de modo cuando el tiempo llega a 0
            }
        }
    }

    func switchMode() {
        timer?.invalidate()

        if isSprint {
            isSprint = false
        } else {
            isSprint = true
            remainingRepetitions -= 1
        }

        if remainingRepetitions > 0 {
            startTimer() // Reinicia el temporizador con el nuevo modo
        }
    }
}

#Preview {
    SprintTimerView(session: SprintSession(sprintMinutes: 0, sprintSeconds: 10, restMinutes: 0, restSeconds: 20, repetitions: 2))
}
