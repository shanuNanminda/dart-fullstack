import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_server/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLogin = true;
  String? uname;
  String? pass;
  final fkey = GlobalKey<FormState>();

  auth() async {try{
    Response res = await post(
      Uri.parse('http://127.0.0.1:8080/${isLogin?'login':'signUp'}'),
      body: jsonEncode(
        {'userName': uname, 'password': pass},
      ),
    );
    print(res.body);
    if(isLogin){
    if(jsonDecode(res.body)['message']){
      Services.toast(context: context,message: 'You\'re in');
    }else{
      Services.toast(context: context, message: 'Who are you');
    }}}on Exception catch(err){
      print(err);
      Services.toast(message: 'Check connection and code', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30),
                child: TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "enter somthing";
                    }
                  },
                  onChanged: (v) {
                    uname = v;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('usrename'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: TextFormField(
                  onChanged: (v) {
                    pass = v;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('pass'),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "enter somthing";
                    }
                  },
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (fkey.currentState!.validate()) {
                    auth();
                  }
                },
                child: Text(isLogin ? 'login' : 'SignUp'),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin ? 'singUp instead' : 'login instead'))
            ],
          ),
        ),
      ),
    );
  }
}
