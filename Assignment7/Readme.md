
# Assignment 7 - Weather App (iOS)

## Project Overview
This is a simple Weather App built with Swift and SwiftUI for the Native Mobile Development course. [cite_start]The app allows users to search for a city and view current weather conditions and a 3-day forecast[cite: 10, 18].

## Tech Stack & Architecture
- [cite_start]**Language:** Swift (Xcode) [cite: 6]
- [cite_start]**UI Framework:** SwiftUI [cite: 35]
- [cite_start]**Architecture:** MVVM (Model-View-ViewModel) for clear separation of concerns [cite: 16, 31]
- [cite_start]**Networking:** URLSession with Codable for JSON parsing [cite: 29, 30]
- [cite_start]**Local Cache:** UserDefaults [cite: 14, 35]

## Features Implemented
- **Search:** Users can enter a city name. [cite_start]Coordinates are fetched using `CLGeocoder`[cite: 20].
- [cite_start]**Weather Details:** Displays city name, temperature, wind speed, and last update time[cite: 21].
- [cite_start]**Forecast:** Shows a 3-day daily forecast[cite: 22].
- **Offline Mode:** The last successful API response is saved locally. [cite_start]If the network is unavailable, the app displays cached data with a "Offline" label[cite: 23].
- [cite_start]**Settings:** Toggle between Celsius and Fahrenheit[cite: 24].

## API Information
- [cite_start]**Source:** [Open-Meteo](https://open-meteo.com/) (No API key required)[cite: 27].
- [cite_start]**Endpoints used:** `v1/forecast` with parameters for `current_weather` and `daily`.

## How to Run
1. Clone the repository.
2. Open `Assignment7.xcodeproj` in Xcode.
3. Select a simulator (e.g., iPhone 15) and press `Cmd + R`.
