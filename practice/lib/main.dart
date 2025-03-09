import 'package:flutter/material.dart';
import 'dart:math'; // 用於隨機變色
import 'package:shared_preferences/shared_preferences.dart'; // 儲存數據

void main() {
  runApp(MyApp());
}

// 主要 App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 隱藏 debug 標籤
      home: HomeScreen(), // 設定首頁
    );
  }
}

// 主畫面 StatefulWidget
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0; // 計數器變數
  Color _backgroundColor = Colors.lightBlue[50]!; // 初始背景顏色
  bool light = true;

  @override
  void initState() {
    super.initState();
    loadCounter(); // 讀取儲存的計數值
    loadLight();
    loadBackgroundColor();
  }

  // 增加計數
  void incrementCounter() {
    setState(() {
      counter++;
    });
    changeColor();
    saveCounter();
  }

  // 減少計數
  void decreaseCounter() {
    setState(() {
      counter--;
    });
    changeColor();
    saveCounter();
  }

  // 重置計數
  void resetCounter() {
    setState(() {
      counter = 0;
    });
    changeColor();
    saveCounter();
  }

  // 隨機改變背景顏色
  void changeColor() {
    Color lightColors =
        [
          Colors.blue[100]!,
          Colors.purple[100]!,
          Colors.pink[100]!,
          Colors.teal[100]!,
          Colors.indigo[100]!,
          Colors.cyan[100]!,
        ][Random().nextInt(5)]; // 隨機選擇一種顏色
    Color darkColors =
        [
          Colors.blue[500]!,
          Colors.purple[500]!,
          Colors.pink[500]!,
          Colors.teal[500]!,
          Colors.indigo[500]!,
          Colors.cyan[500]!,
        ][Random().nextInt(5)]; // 隨機選擇一種顏色
    setState(() {
      _backgroundColor = light ? lightColors : darkColors;
    });
    saveBackgroundColor();
  }

  // 儲存計數值到本地存儲
  void saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
  }

  // 載入儲存的計數值
  void loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0; // 預設值為 0
    });
  }

  void saveLight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('light', light);
  }

  void loadLight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      light = prefs.getBool('light') ?? true;
    });
  }

  void changeLight() {
    setState(() {
      light = !light;
    });
    saveLight();
  }

  void saveBackgroundColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('backgroundColor', _backgroundColor.value);
  }

  void loadBackgroundColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      int colorValue =
          prefs.getInt('backgroundColor') ?? Colors.lightBlue[50]!.value;
      _backgroundColor = Color(colorValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("計數器 App"),
        backgroundColor: light ? Colors.blueGrey : Colors.black,
      ),

      body: Container(
        color: _backgroundColor, // 設定動態背景顏色
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("你點擊的次數：", style: TextStyle(fontSize: 20)),
              Text(
                "$counter",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: incrementCounter,
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: resetCounter,
            child: Icon(Icons.refresh),
            backgroundColor: Colors.red,
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: decreaseCounter,
            child: Icon(Icons.remove),
            backgroundColor: Colors.orange,
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: changeLight,
            child: Icon(Icons.sunny),
            backgroundColor: light ? Colors.yellow : Colors.grey[800],
          ),
        ],
      ),
    );
  }
}
