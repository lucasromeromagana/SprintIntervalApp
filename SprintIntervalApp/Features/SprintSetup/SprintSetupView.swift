//
//  ContentView.swift
//  SprintIntervalApp
//
//  Created by Lucas Romero Magaña on 24/10/24.
//

import SwiftUI

import SwiftUI

struct SprintSetupView: View {
    @StateObject var viewModel = SprintSetupViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // Sprint Time Section
                    Section(header: Text("Tiempo del Sprint")) {
                        HStack {
                            Picker("Minutos", selection: $viewModel.sprintMinutes) {
                                ForEach(0..<5) {
                                    Text("\($0) min")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(maxHeight: 100)

                            Picker("Segundos", selection: $viewModel.sprintSeconds) {
                                ForEach(0..<60) {
                                    Text("\($0) sec")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(maxHeight: 100)
                        }
                    }

                    // Rest Time Section
                    Section(header: Text("Tiempo de Descanso")) {
                        HStack {
                            Picker("Minutos", selection: $viewModel.restMinutes) {
                                ForEach(0..<5) {
                                    Text("\($0) min")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(maxHeight: 100)

                            Picker("Segundos", selection: $viewModel.restSeconds) {
                                ForEach(0..<60) {
                                    Text("\($0) sec")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(maxHeight: 100)
                        }
                    }

                    // Repetitions Section
                    Section(header: Text("Repeticiones del Sprint")) {
                        Picker("Repeticiones", selection: $viewModel.repetitions) {
                            ForEach(1..<11) {
                                Text("\($0) veces")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(maxHeight: 100)
                    }

                    // Summary Section
                    Section(header: Text("Resumen")) {
                        Text("Sprint: \(viewModel.sprintMinutes) min \(viewModel.sprintSeconds) sec")
                        Text("Descanso: \(viewModel.restMinutes) min \(viewModel.restSeconds) sec")
                        Text("Repeticiones: \(viewModel.repetitions)")
                    }
                }

                Spacer()

                // Botón "Comenzar" fijo en la parte inferior
                NavigationLink(destination: SprintTimerView(session: SprintSession(
                    sprintMinutes: viewModel.sprintMinutes,
                    sprintSeconds: viewModel.sprintSeconds,
                    restMinutes: viewModel.restMinutes,
                    restSeconds: viewModel.restSeconds,
                    repetitions: viewModel.repetitions
                ))) {
                    Text("Comenzar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding() // Padding exterior para separar del borde inferior
            }
            .navigationTitle("Configurar Sprint")
        }
    }
}

struct SprintSetupView_Previews: PreviewProvider {
    static var previews: some View {
        SprintSetupView()
    }
}
