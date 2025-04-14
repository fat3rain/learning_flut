// import 'dart:convert';

// import 'package:flutter_learning_app/data/entities/user.dart';
// import 'package:http/http.dart' as http;

// void pressActionButton() async {
//   const String url = 'https://randomuser.me/api/?results=10';
//   final uri = Uri.parse(url);
//   final response = await http.get(uri);
//   final body = response.body;
//   final json = jsonDecode(body);
//   final result = json['results'] as List<dynamic>;
//   final transform = result.map((e) {
//     final name = Name(
//         title: e['name']['title'],
//         first: e['name']['first'],
//         last: e['name']['last']);
//     final picture = Picture(
//         large: e['picture']['large'],
//         medium: e['picture']['medium'],
//         thumbnail: e['picture']['thumbnail']);
//     final user = User(
//         gender: e['gender'], email: e['email'], name: name, picture: picture);
//   });
// }
// {
//   "results": [
//     {
//       "gender": "female",
//       "name": {
//         "title": "Mrs",
//         "first": "Stephanie",
//         "last": "Gregory"
//       },
//       "location": {
//         "street": {
//           "number": 4403,
//           "name": "North Road"
//         },
//         "city": "Ballina",
//         "state": "Galway",
//         "country": "Ireland",
//         "postcode": 65392,
//         "coordinates": {
//           "latitude": "-0.8915",
//           "longitude": "91.6481"
//         },
//         "timezone": {
//           "offset": "-9:00",
//           "description": "Alaska"
//         }
//       },