import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning_app/data/entities/user.dart';
import 'package:http/http.dart' as http;

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
  }

  Future<void> _onLoadUsers(
      LoadUsersEvent event, Emitter<UserListState> emit) async {
    emit(UserListLoading());
    try {
      const url = 'https://randomuser.me/api/?results=10';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final results = json['results'] as List<dynamic>;

      final users = results.map((e) {
        final picture = Picture(
            large: e['picture']['large'],
            medium: e['picture']['medium'],
            thumbnail: e['picture']['thumbnail']);
        final name = Name(
            title: e['name']['title'],
            first: e['name']['first'],
            last: e['name']['last']);
        final street = Street(name: e['location']['street']['name']);
        final location = Location(city: e['location']['city'], street: street);

        return User(
          gender: e['gender'],
          email: e['email'],
          name: name,
          picture: picture,
          location: location,
        );
      }).toList();

      emit(UserListLoaded(users));
    } catch (e) {
      emit(UserListLoadingFailure('Попробуйте снова'));
    }
  }
}
