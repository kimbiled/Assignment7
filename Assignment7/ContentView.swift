import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter city name...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    
                    Button("Search") {
                        if !searchText.isEmpty {
                            viewModel.fetchWeather(for: searchText)
                        }
                    }
                }
                .padding()

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red).font(.caption)
                }

                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let weather = viewModel.weather {
                    List {
                        Section {
                            if viewModel.isOffline {
                                Label("Offline Mode", systemImage: "wifi.slash")
                                    .foregroundColor(.orange)
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(viewModel.currentCityName)
                                    .font(.title).bold()
                                
                                if let weather = viewModel.weather {
                                    Text(viewModel.displayTemp(weather.current_weather.temperature))
                                        .font(.system(size: 60, weight: .bold))
                                    
                                    Text("Wind speed: \(weather.current_weather.windspeed, specifier: "%.1f") km/h")
                                    Text("Last update: \(weather.current_weather.time)")
                                        .font(.caption).foregroundColor(.secondary)
                                }
                            }
                        }
                        Section("3-Day Forecast") {
                            ForEach(0..<3, id: \.self) { i in
                                HStack {
                                    Text(weather.daily.time[i])
                                    Spacer()
                                    Text(viewModel.displayTemp(weather.daily.temperature_2m_max[i]))
                                        .bold()
                                    Text("/")
                                    Text(viewModel.displayTemp(weather.daily.temperature_2m_min[i]))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Weather App")
            .onAppear {
                viewModel.fetchWeather(for: "Astana")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(viewModel.useCelsius ? "→ °F" : "→ °C") {
                        viewModel.useCelsius.toggle()
                    }
                }
            }
        }
    }
}
