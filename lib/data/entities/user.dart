class User {
  final String gender;
  final String email;
  final Name name;
  final Picture picture;
  final Location location;

  User(
      {required this.location,required this.gender,
      required this.email,
      required this.name,
      required this.picture});
}

class Name {
  final String title;
  final String first;
  final String last;

  Name({required this.title, required this.first, required this.last});
}

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});
}

class Location {
  final String city;
  final Street street;

  Location({required this.city, required this.street});
}

class Street {
  final String name;

  Street({required this.name});
}
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