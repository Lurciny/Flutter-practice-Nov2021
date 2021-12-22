import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo-Nov2021',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: DemoSensorsPlusPage(),
    );
  }
}

///代码清单
class DemoSensorsPlusPage extends StatefulWidget {
  @override
  _DemoSensorsPlusPageState createState() => _DemoSensorsPlusPageState();
}

class _DemoSensorsPlusPageState extends State<DemoSensorsPlusPage> {
  bool _isShow = false;

  @override
  void initState() {
    super.initState();

    //加速度 受重力影响
    accelerometerEvents.listen((AccelerometerEvent event) async {
      //[AccelerometerEvent (x: 0.0992431640625, y: 0.11407470703125, z: 9.776962280273438)]
      // print(event);
      int value = 10;
      if (event.x.abs() > value ||
          event.y.abs() > value ||
          event.z.abs() > value) {
        if (!_isShow) {
          _isShow = true;
          dynamic result = await showDialog<bool>(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text("摇一摇"),
                  content: Image.asset(
                    "images/banner1.png",
                    width: 200,
                  ),
                );
              },
              context: context,
              barrierDismissible: true);
          _isShow = false;
        }
      }
    });

    //加速度 不受重力影响
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {});

    //陀螺仪传感器
    gyroscopeEvents.listen((GyroscopeEvent event) {
      //[GyroscopeEvent (x: 0.00042724609375, y: 0.0005340576171875, z: -0.0003204345703125)]
      // print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    ///使用 Scaffold 组件来构建应用的基本页面
    /// 页面的架构
    return Scaffold(
      appBar: myAppBar(),
      body: Center(
        child: Text("测试"),
      ),
    );
  }
}


String sett="button状态";

// 创建一个AppBar
AppBar myAppBar() {
  return new AppBar(
    //按钮
    actions: <Widget>[
      new IconButton(
        icon: new Icon(
          Icons.favorite,
          color: Colors.yellow,
        ),
        onPressed: () {
          sett = "like";
        },
        // 长按进行提示文字
        tooltip: '我喜欢',
      ),
      new IconButton(
        icon:new Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.red,
        ),
        onPressed: () {
          sett="unlike";
        },
        // 长按进行提示文字
        tooltip: '我不喜欢',
      ),
    ],
    //标题
    title: Text(sett),
    // 标题居中
    centerTitle: true,
  );
}

