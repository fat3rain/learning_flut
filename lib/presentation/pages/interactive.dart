import 'package:flutter/material.dart';
import 'package:flutter_learning_app/presentation/pages/graph_screen.dart';
import 'package:flutter_learning_app/presentation/pages/money_tracker_screen.dart';

class InteractiveScreen extends StatelessWidget {
  const InteractiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'х',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
            boundaryMargin:
                const EdgeInsets.symmetric(horizontal: 200, vertical: 300),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MoneyTrackerScreen())),
              child: Container(
                // width: 200,
                // height: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Colors.red,
                      Colors.orange,
                    ])),
              ),
            )),
      ),
    );
  }
}
