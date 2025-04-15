import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_age_state.dart';
part 'user_age_event.dart';
class UserAge extends Bloc<UserAgeEvent, UserAgeState> {
  UserAge() : super(UserAgeInitial()) {
    on<UserAgeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}