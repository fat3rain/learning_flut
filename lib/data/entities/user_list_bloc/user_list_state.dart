part of 'user_list_bloc.dart';

class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> users;
  UserListLoaded(this.users);
}

class UserListLoadingFailure extends UserListState {
  final String message;
  UserListLoadingFailure(this.message);
}
