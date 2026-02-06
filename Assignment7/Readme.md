
# Assignment 7 - Weather App (iOS)

## Project Overview
This is a simple Weather App built with Swift and SwiftUI for the Native Mobile Development course. The app allows users to search for a city and view current weather conditions and a 3-day forecast.

## Tech Stack & Architecture
- **Language:** Swift (Xcode)
- **UI Framework:** SwiftUI
- **Architecture:** MVVM (Model-View-ViewModel) for clear separation of concerns
- **Networking:** URLSession with Codable for JSON parsing
- **Local Cache:** UserDefaults 

## Features Implemented
- **Search:** Users can enter a city name. Coordinates are fetched using `CLGeocoder`.
- **Weather Details:** Displays city name, temperature, wind speed, and last update time.
- **Forecast:** Shows a 3-day daily forecast.
- **Offline Mode:** The last successful API response is saved locally. If the network is unavailable, the app displays cached data with a "Offline" label.
- **Settings:** Toggle between Celsius and Fahrenheit.

## API Information
- **Source:** [Open-Meteo](https://open-meteo.com/) (No API key required).
- **Endpoints used:** `v1/forecast` with parameters for `current_weather` and `daily`.

## How to Run
1. Clone the repository.
2. Open `Assignment7.xcodeproj` in Xcode.
3. Select a simulator (e.g., iPhone 15) and press `Cmd + R`.
