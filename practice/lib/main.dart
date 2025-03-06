import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 這是我們的主要 Widget，代表整個 App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 隱藏 debug 標籤
      home: HomeScreen(), // 設定首頁
    );
  }
}

// 這是我們的首頁（StatefulWidget），允許 UI 變動
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// 這裡是狀態管理類別，負責控制 UI 的變化
class _HomeScreenState extends State<HomeScreen> {
  int counter = 0; // 計數器變數

  // 增加計數的函式
  void incrementCounter() {
    setState(() {
      counter++; // 更新計數器數值
    });
    changeColor();
  }

  // 重置計數的函式
  void resetCounter() {
    setState(() {
      counter = 0; // 將計數器歸零
    });
    changeColor();
  }

  void decreaceCounter() {
    setState(() {
      counter--;
    });
    changeColor();
  }

  void changeColor() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("計數器 App"), // 設定 AppBar 標題
        backgroundColor: Colors.blueGrey, // 更改 AppBar 背景顏色
      ),
      body: Container(
        color: Colors.lightBlue[50], // 設定背景顏色
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
            onPressed: incrementCounter, // 點擊時增加計數
            child: Icon(Icons.add),
            backgroundColor: Colors.green, // 按鈕顏色
          ),
          SizedBox(width: 10), // 按鈕間距
          FloatingActionButton(
            onPressed: resetCounter, // 點擊時重置計數
            child: Icon(Icons.refresh),
            backgroundColor: Colors.red, // 按鈕顏色
          ),
          SizedBox(width: 10), // 按鈕間距
          FloatingActionButton(
            onPressed: decreaceCounter, // 點擊時重置計數
            child: Icon(Icons.delete),
            backgroundColor: Colors.yellow[900], // 按鈕顏色
          ),
        ],
      ),
    );
  }
}
