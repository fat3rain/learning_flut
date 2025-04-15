part of 'user_age_bloc.dart';

class UserAgeState {}

class UserAgeInitial extends UserAgeState {}

class UserAgeLoading extends UserAgeState {}

class UserAgeLoaded extends UserAgeState {
  UserAgeLoaded(this.age);
  final String age;
}

class UserAgeLoadingFailure extends UserAgeState {
  UserAgeLoadingFailure(this.message);

  String message;
}
