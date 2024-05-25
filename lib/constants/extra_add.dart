// import 'package:flutter/material.dart';
//
// class FlightInfoCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flight Information Card'),
//       ),
//       body: Center(
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           elevation: 5,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Your previous flight information row here...
//                 SizedBox(height: 20),
//                 Divider(),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FlightDetail(
//                       title: 'AIRCRAFT',
//                       value: 'Boeing 787',
//                     ),
//                     FlightDetail(
//                       title: 'SERIAL NUMBER',
//                       value: '32413',
//                     ),
//                     FlightDetail(
//                       title: 'REGISTRATION',
//                       value: 'RG-REF',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FlightDetail extends StatelessWidget {
//   final String title;
//   final String value;
//
//   FlightDetail({required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey[600],
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: FlightInfoCard(),
//   ));
// }
