import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    MobpushPlugin.addPushReceiver(_onEvent, _onError);

  }

  void _onEvent(Object event) {
    print('_onEvent---$event');
  }

  void _onError(Object event) {
    print('_onError---$event');
  }

  void _incrementCounter() async {
    Map regId = await MobpushPlugin.getRegistrationId();
    print(regId);
    setState(() {
      _counter++;
    });

    shareFacebookCustom(context);
  }
  void shareFacebookCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setFacebook(
          "Share SDK Link Desc",
          "http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg",
          "http://www.mob.com",
          "Share SDK",
          null,
          null,
          "#MobData",
          "Mob官网 - 全球领先的移动开发者服务平台",
          SSDKFacebookShareTypes.native,
          SSDKContentTypes.image);
    params
      ..setFacebookAssetLocalIdentifier("73EC5698-20CF-4030-8FB2-CC0C80EF8156/L0/001,B2A42CA3-FA0F-45EC-92B2-F0F94A8A5A2B/L0/001,AA97F2F3-D2E4-43BB-8C2A-06D77480D7CA/L0/001,B220D191-2D5F-43E1-BF97-E3D7E61E86DB/L0/001,F064C692-79A1-4768-9530-1EFEA8360843/L0/001", "asdf");
    SharesdkPlugin.share(ShareSDKPlatforms.facebook, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }
  void showAlert(SSDKResponseState state, Map content, BuildContext context) {
    print("--------------------------> state:" + state.toString());
    String title = "失败";
    switch (state) {
      case SSDKResponseState.Success:
        title = "成功";
        break;
      case SSDKResponseState.Fail:
        title = "失败";
        break;
      case SSDKResponseState.Cancel:
        title = "取消";
        break;
      default:
        title = state.toString();
        break;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text(title),
            content: new Text(content != null ? content.toString() : ""),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              color: Colors.grey,
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline: 50,
                    child: Text(
                      '123',
                      style: TextStyle(
                        fontFamily: 'HanaleiFill',
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline: 50,
                    child: Text(
                      'asda',
                      style: TextStyle(
                        fontFamily: 'HanaleiFill',
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Baseline(
                    baselineType: TextBaseline.alphabetic,
                    baseline: 50,
                    child: Text(
                      '我是字体',
                      style: TextStyle(
                        fontFamily: 'HanaleiFill',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
