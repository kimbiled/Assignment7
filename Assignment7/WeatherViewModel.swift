import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var isOffline = false
    @Published var errorMessage: String?
    @Published var currentCityName: String = "Astana"
    
    @Published var useCelsius: Bool {
        didSet {
            UserDefaults.standard.set(useCelsius, forKey: "useCelsius")
            objectWillChange.send()
        }
    }
    
    private let cacheKey = "cached_weather_data"
    private let cityKey = "cached_city_name"

    init() {
        self.useCelsius = UserDefaults.standard.object(forKey: "useCelsius") as? Bool ?? true
        self.currentCityName = UserDefaults.standard.string(forKey: cityKey) ?? "Astana"
    }

    func displayTemp(_ temp: Double) -> String {
        if useCelsius {
            return String(format: "%.1f°C", temp)
        } else {
            let fahrenheit = (temp * 9/5) + 32
            return String(format: "%.1f°F", fahrenheit)
        }
    }

    func fetchWeather(for cityName: String) {
        isLoading = true
        errorMessage = nil
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                
                DispatchQueue.main.async {
                    self.currentCityName = placemark.locality ?? cityName
                    UserDefaults.standard.set(self.currentCityName, forKey: self.cityKey)
                }
                
                self.performRequest(lat: lat, lon: lon)
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "City not found"
                    self.loadFromCache()
                }
            }
        }
    }

    private func performRequest(lat: Double, lon: Double) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current_weather=true&daily=temperature_2m_max,temperature_2m_min&timezone=auto"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    if let decoded = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                        self.weather = decoded
                        self.isOffline = false
                        UserDefaults.standard.set(data, forKey: self.cacheKey)
                        return
                    }
                }
                self.loadFromCache()
            }
        }.resume()
    }

    private func loadFromCache() {
        if let data = UserDefaults.standard.data(forKey: cacheKey),
           let decoded = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
            self.weather = decoded
            self.isOffline = true
        }
    }
}
