import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

/// API management strings and basis data /

List<String> cities = ["rennes", "paris", "nantes", "bordeaux", "lyon"];

String endPoint = "https://api.openweathermap.org/data/2.5/weather?";

String apiKey = dot_env.env["API_KEY"]!;

String cityQuery = "&q=";
String langQuery = "&lang=fr";
String keyQuery = "&appid=" + apiKey;
String metricQuery = "units=metric";

String midUrl = endPoint + metricQuery + langQuery + keyQuery + cityQuery;

/// Displayed information strings/

String metricStr = "°";
String tempStr = "Température: ";
String feelStr = "Ressenti: ";
String cityStr = "Ville";

String progressStr1 = "Nous téléchargeons les données…";
String progressStr2 = "C’est presque fini…";
String progressStr3 = "Plus que quelques secondes avant d’avoir le résultat…";

/// Reused data /

const timeout = Duration(seconds: 60);
const interval = Duration(seconds: 10);

/// Weather icon display /

String setIcon(String icon) {
  String iconUrl = "https://openweathermap.org/img/wn/" + icon + "@2x.png";
  return iconUrl;
}
