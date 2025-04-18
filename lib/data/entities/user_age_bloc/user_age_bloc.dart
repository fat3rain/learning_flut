import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

part 'user_age_state.dart';
part 'user_age_event.dart';

class UserAge extends Bloc<UserAgeEvent, UserAgeState> {
  UserAge() : super(UserAgeInitial()) {
    on<GetAgeEvent>(loadAge);
  }

  Future<void> loadAge(GetAgeEvent event, Emitter<UserAgeState> emit) async {
    emit(UserAgeLoading());
    print('object');
    try {
      String url = 'https://api.agify.io/?name=${event.name}';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final age = json['age'];
      emit(UserAgeLoaded(age.toString()));
      print(age);
    } catch (e) {
      emit(UserAgeLoadingFailure('не удалось получить данные...'));
    }
  }
}
   //   LoadUsersEvent event, Emitter<UserListState> emit) async {