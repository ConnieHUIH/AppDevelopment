# 🌤️ Flutter Weather App (Real-time Weather Forecast)

A weather forecast application built with Flutter. This app fetches real-time weather data based on the user's current location by integrating the **OpenWeatherMap API**, and utilizes **Lottie** animations to deliver dynamic and vivid visual effects according to different weather conditions (e.g., sunny, rainy, cloudy).

---

# Getting Started

For security and privacy reasons, the personal API Key has been hidden in this repository. To run this project locally on your machine, please follow the steps below:

### 1. Get an OpenWeatherMap API Key
1. Go to the [OpenWeatherMap Official Website](https://openweathermap.org/) and register for a free account.
2. After logging in, navigate to the `API keys` page and generate your unique `API Key` (it usually takes a few minutes to activate).

### 2. Clone and Configure the Project
Clone this repository to your local machine, then open `lib/pages/weather_page.dart`:

```dart
// Find this line:
final _weatherService = WeatherService('YOUR_API_KEY_HERE');

// Replace 'YOUR_API_KEY_HERE' with the API Key you just generated:
final _weatherService = WeatherService('YOUR_ACTUAL_API_KEY_HERE');

Built With
Flutter SDK - Cross-platform UI framework
http - For handling HTTP requests and API integration
geolocator - For retrieving device GPS location
lottie - For parsing and rendering After Effects animations natively