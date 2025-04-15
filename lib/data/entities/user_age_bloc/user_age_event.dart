part of 'user_age_bloc.dart';

class UserAgeEvent {}

class GetAgeEvent extends UserAgeEvent {
  String name;
  GetAgeEvent(this.name);
}
