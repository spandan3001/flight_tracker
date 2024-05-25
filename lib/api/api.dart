import 'dart:convert';
import 'package:flight_tracker/model/data.dart';
import 'package:http/http.dart' as http;

Future<FlightData?> processData(String code1, String code2) async {
  //return FlightData.fromJson(obj);
  print("Start processing");

  final Uri apiUrl =
      Uri.parse('https://backendflightpath.onrender.com/api/flightPath');

  try {
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'start': code1,
        'end': code2,
      }),
    );

    // Log the raw response
    print('Raw response: ${response.body}');

    if (response.statusCode == 200) {
      // Successfully processed the data
      print('Data processed successfully');

      // Trim any extraneous whitespace or unexpected characters
      // final trimmedResponseBody = response.body.trim();
      //
      // // Handle the response data if needed
      final responseData = jsonDecode(response.body);
      // print(responseData);

      FlightData data = FlightData.fromJson(responseData);
      print(data.weather);

      return data;
    } else {
      // Error processing the data
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }

  return null;
}
