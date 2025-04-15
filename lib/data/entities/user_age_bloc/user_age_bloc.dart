import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'user_age_state.dart';
part 'user_age_event.dart';

class UserAge extends Bloc<UserAgeEvent, UserAgeState> {
  UserAge() : super(UserAgeInitial()) {
    on<GetAgeEvent>((event, emit) {
      emit(UserAgeLoading());
      try {
        Future<void> loadAge(String name) async {
          String url = 'https://api.agify.io/?name=${event.name}';
          final uri = Uri.parse(url);
          final response = await http.get(uri);
          final body = response.body;
          final json = jsonDecode(body);
          final age = json['age'];
          emit(UserAgeLoaded(age.toString()));
          // final snackBar = SnackBar(content: Text(json['age'].toString()));
        }
      } catch (e) {
        emit(UserAgeLoadingFailure('sorry...'));
      }
    });
  }
}
