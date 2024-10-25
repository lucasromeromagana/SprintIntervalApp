//
//  SprintSession.swift
//  SprintIntervalApp
//
//  Created by Lucas Romero Magaña on 24/10/24.
//

import Foundation

struct SprintSession {
    let sprintMinutes: Int
    let sprintSeconds: Int
    let restMinutes: Int
    let restSeconds: Int
    let repetitions: Int

    var totalSprintTime: Int {
        return (sprintMinutes * 60) + sprintSeconds
    }

    var totalRestTime: Int {
        return (restMinutes * 60) + restSeconds
    }
}

