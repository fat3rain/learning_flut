import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning_app/data/entities/user_age_bloc/user_age_bloc.dart';
import 'package:flutter_learning_app/data/entities/user_list_bloc/user_list_bloc.dart';
import 'package:flutter_learning_app/data/entities/user.dart';
import 'package:flutter_learning_app/presentation/pages/interactive.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userListBloc = UserListBloc();
  final TextEditingController _nameController = TextEditingController();
  final _userAgeBloc = UserAge();
  List<User> listUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'узнай api',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)))),
                ),
              ),
              IconButton(
                onPressed: () => {
                  _userAgeBloc.add(GetAgeEvent(_nameController.text.trim())),
                  BlocBuilder<UserAge, UserAgeState>(
                    bloc: _userAgeBloc,
                    builder: (context, state) {
                      if (state is UserAgeLoaded) {
                        final snackBar = SnackBar(content: Text(state.age));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                },
                icon: const Icon(Icons.check),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () async {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return TimePickerDialog(initialTime: TimeOfDay.now());
                      });
                }
                //  TimePickerDialog(initialTime: TimeOfDay.now()),
                ,
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const InteractiveScreen()));
                  },
                  icon: const Icon(Icons.forward))
            ],
          ),
          Expanded(
            child: BlocBuilder<UserListBloc, UserListState>(
              bloc: _userListBloc,
              builder: (context, state) {
                if (state is UserListLoaded) {
                  return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          title: Text(
                            '${user.email} ${user.gender}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${user.name.first} ${user.location.street.name}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: Image.network(user.picture.large),
                        );
                      });
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          FloatingActionButton(
            onPressed: pressActionBut,
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  void pressIconBut(String name) async {
    String url = 'https://api.agify.io/?name=$name';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    print(json['age']);
    final snackBar = SnackBar(content: Text(json['age'].toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void pressActionBut() {
    print('sss');
    _userListBloc.add(LoadUsersEvent());
  }
}
