// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherConditions {
  String description;
  String image;
  WeatherConditions({
    required this.description,
    required this.image,
  });

  static const Map<int, dynamic> weatherConditions = {
    0: {"description": "Unknown", "image": "assets/icons/black/unknown.svg"},
    1000: {
      "description": "Clear Sunny",
      "image": "assets/icons/black/clear_day.svg"
    },
    1100: {
      "description": "Mostly Clear",
      "image": "assets/icons/black/mostly_clear_day.svg"
    },
    1101: {
      "description": "Partly Cloudy",
      "image": "assets/icons/black/partly_cloudy_day.svg"
    },
    1102: {
      "description": "Mostly Cloudy",
      "image": "assets/icons/black/mostly_cloudy.svg"
    },
    1001: {"description": "Cloudy", "image": "assets/icons/black/cloudy.svg"},
    2000: {"description": "Fog", "image": "assets/icons/black/fog.svg"},
    2100: {
      "description": "Light Fog",
      "image": "assets/icons/black/fog_light.svg"
    },
    4000: {"description": "Drizzle", "image": "assets/icons/black/drizzle.svg"},
    4001: {"description": "Rain", "image": "assets/icons/black/rain.svg"},
    4200: {
      "description": "Light Rain",
      "image": "assets/icons/black/rain_light.svg"
    },
    4201: {
      "description": "Heavy Rain",
      "image": "assets/icons/black/rain_heavy.svg"
    },
    5000: {"description": "Snow", "image": "assets/icons/black/snow.svg"},
    5001: {
      "description": "Flurries",
      "image": "assets/icons/black/flurries.svg"
    },
    5100: {
      "description": "Light Snow",
      "image": "assets/icons/black/snow_light.svg"
    },
    5101: {
      "description": "Heavy Snow",
      "image": "assets/icons/black/snow_heavy.svg"
    },
    6000: {
      "description": "Freezing Drizzle",
      "image": "assets/icons/black/freezing_drizzle.svg"
    },
    6001: {
      "description": "Freezing Rain",
      "image": "assets/icons/black/freezing_rain.svg"
    },
    6200: {
      "description": "Light Freezing Rain",
      "image": "assets/icons/black/freezing_rain_light.svg"
    },
    6201: {
      "description": "Heavy Freezing Rain",
      "image": "assets/icons/black/freezing_rain_heavy.svg"
    },
    7000: {
      "description": "Ice Pellets",
      "image": "assets/icons/black/ice_pellets.svg"
    },
    7101: {
      "description": "Heavy Ice Pellets",
      "image": "assets/icons/black/ice_pellets_heavy.svg"
    },
    7102: {
      "description": "Light Ice Pellets",
      "image": "assets/icons/black/ice_pellets_light.svg"
    },
    8000: {
      "description": "Thunderstorm",
      "image": "assets/icons/black/tstorm.svg"
    }
  };

  static Map<String, String> getWeatherCondition(int weatherCode) {
    return weatherConditions[weatherCode] ??
        {'description': 'Unknown', 'image': 'assets/icons/black/clear_day.svg'};
  }
}
