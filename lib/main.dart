import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_gate_3/Ngrok_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Di Bella Gate Demo',
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
      ),
      home: const MyHomePage(title: 'App RI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var client = http.Client();
  bool opening = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: opening ? _openingProgress() : _gateButtons(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Future<void> openGate(gateNumber) async {
    setState(() {
      opening = true;
    });
    Tunnels? httpsTunnel;
    ngrokTunnels().then((value) => {
      httpsTunnel = value.tunnels?.firstWhere((element) => element.publicUrl!.contains("https")),
      callUri(Uri.https(httpsTunnel!.publicUrl!.split("https://")[1], 'open-' + gateNumber))
    });
  }
  
  Future<NgrokResponse> ngrokTunnels() async {
    var url = Uri.https('api.ngrok.com', 'tunnels');
    Map<String,String> headers = new Map<String,String>();
    headers.putIfAbsent("Authorization", () => "Bearer 2JWAWAY7NEeg4E4ZMWArvNxymkK_6nFSHSVtSRJsWQRqPhDqf");
    headers.putIfAbsent("Ngrok-Version", () => "2");
    var response = await http.get(url,headers: headers);
    print("NgRok Response: " + response.body);
    return NgrokResponse.fromJson(jsonDecode(response.body));
  }

  callUri(Uri uri) async {
    await http.get(uri);
    setState(() {
      opening = false;
    });
  }

  _gateButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(padding: EdgeInsets.all(10),
          child: new SizedBox(
            width: 200.0,
            height: 200.0,
            child: ElevatedButton(
                onPressed: () { openGate("4"); },
                child: Text("Apri Casa", style: TextStyle(color: Colors.white, fontSize: 20),)
            ),),),
        new Padding(padding: EdgeInsets.all(10),
          child: new SizedBox(
            width: 200.0,
            height: 200.0,
            child: ElevatedButton(
                onPressed: () { openGate("6"); },
                child: Text("Apri Condominio", style: TextStyle(color: Colors.white, fontSize: 20),)
            ),),),
      ],
    );
  }

  _openingProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox.fromSize(size: Size(40, 40),),
        Text("Si sta aprendo...", style: TextStyle(fontSize: 40),)
      ],
    );
  }
}

