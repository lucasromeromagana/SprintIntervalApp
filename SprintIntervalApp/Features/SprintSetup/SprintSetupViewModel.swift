//
//  SprintSetupViewModel.swift
//  SprintIntervalApp
//
//  Created by Lucas Romero Magaña on 24/10/24.
//

import SwiftUI
import Combine

class SprintSetupViewModel: ObservableObject {
    // Publicamos los datos seleccionados para que la vista se actualice cuando cambien
    @Published var sprintMinutes: Int = 0
    @Published var sprintSeconds: Int = 0
    @Published var restMinutes: Int = 0
    @Published var restSeconds: Int = 0
    @Published var repetitions: Int = 1

    // Publicamos el tiempo total de sprint (en segundos)
    @Published var totalSprintTime: Int = 0
    @Published var totalRestTime: Int = 0

    // Combine Cancellables
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Cuando cambian los minutos o segundos, recalculamos el tiempo total del sprint
        Publishers.CombineLatest($sprintMinutes, $sprintSeconds)
            .map { (minutes, seconds) in
                return (minutes * 60) + seconds
            }
            .assign(to: \.totalSprintTime, on: self)
            .store(in: &cancellables)

        // Recalcular el tiempo total de descanso
        Publishers.CombineLatest($restMinutes, $restSeconds)
            .map { (minutes, seconds) in
                return (minutes * 60) + seconds
            }
            .assign(to: \.totalRestTime, on: self)
            .store(in: &cancellables)
    }
}
