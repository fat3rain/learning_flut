import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';
class UserList extends Bloc<UserListEvent, UserListState> {
  UserList() : super(UserListInitial()) {
    on<UserListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}