import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences_android/shared_preferences_android.dart';

class MoneyTrackerScreen extends StatefulWidget {
  const MoneyTrackerScreen({super.key});

  @override
  State<MoneyTrackerScreen> createState() => _MoneyTrackerScreenState();
}

class _MoneyTrackerScreenState extends State<MoneyTrackerScreen> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  Map<String, double> results = {};
  String jsonEncoded = '';
  List<String> allTargers = [];
  List<double> allSums = [];

  // Map<String, double> resultsAfter = {};

  void _addToRes(String target, double money) async {
    if (results.containsKey(target)) {
      results[target] = results[target]! + money;
    } else {
      results[target] = money;
    }

    final snackbar = SnackBar(content: Text(results.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    await _jsonEncode(results);
    await _jsonDecode();

    setState(() {});
  }

  Future<void> _jsonEncode(Map<String, dynamic> jsonNotReady) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonBefore = jsonEncode(jsonNotReady);

    jsonEncoded = jsonBefore;
    prefs.setString('pie_data', jsonBefore);
  }

  Future<void> _jsonDecode() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('pie_data');
    if (jsonString == null) return;

    final Map<String, dynamic> decoded = jsonDecode(jsonString);
    results =
        decoded.map((key, value) => MapEntry(key, (value as num).toDouble()));
    allSums.clear();
    allTargers.clear();
    results.forEach((key, value) {
      allTargers.add(key);
      allSums.add(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _jsonDecode().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Key PieChartKey = UniqueKey();
    List<PieChartSectionData> sections = results.entries
        .map((e) => PieChartSectionData(
              value: e.value,
              title: e.key,
              color: Colors.primaries[results.keys.toList().indexOf(e.key) %
                  Colors.primaries.length],
            ))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.red,
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'money tracker',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 300,
                height: 60,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  controller: _moneyController,
                  decoration: InputDecoration(
                      label: const Text('Write a sum you spended'),
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(96, 255, 255, 255)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (_moneyController.text.trim() != '') {
                      // allTargers.add(_targetController.text.trim());
                      _addToRes(_targetController.text.trim(),
                          double.parse(_moneyController.text.trim()));
                    }
                  },
                  icon: Icon(
                    Icons.money,
                    color: Colors.green[300],
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 300,
                height: 60,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _targetController,
                  decoration: InputDecoration(
                      label: const Text('Write a subject for spending'),
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(96, 255, 255, 255)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              IconButton(
                  onPressed: () {
                    deleteInfo();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
          if (results.isNotEmpty)
            SizedBox(
                key: PieChartKey,
                width: 200,
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40,
                  ),
                  swapAnimationDuration: const Duration(seconds: 2),
                  swapAnimationCurve: Curves.bounceInOut,
                )),
          Center(
            child: Text(
              allSums.isNotEmpty ? 'Все расходы:' : 'Данных пока что нет...',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // SizedBox(
          //     height: 20,
          //     width: 30,
          //     child: TimePickerDialog(
          //       initialTime: TimeOfDay.now(),
          //     )),
          if (allSums.isNotEmpty)
            Flexible(
                child: ListView.builder(
                    itemCount: allTargers.length,
                    itemBuilder: (context, index) {
                      final double sum = allSums[index];
                      final String target = allTargers[index];

                      return ListTile(
                        title: Text(
                          target,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(sum.toString()),
                      );
                    })),
        ],
      ),
    );
  }

  void deleteInfo() {
    results.clear();
    allTargers.clear();
    allSums.clear();
    setState(() {});
  }
}
