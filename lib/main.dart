///////////////////////////////////////////
// Instagram: @invisionchip
// Github: https://github.com/chipinvision
// LIKE | SHARE | FOLLOW
///////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:humourhive/services/jokes_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Humourhive",
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _joke = '';
  late Future<String> _jokeFuture = ApiService.getJoke();

  @override
  void initState(){
    super.initState();
    _jokeFuture = ApiService.getJoke();
  }

  void generateJoke(){
    setState(() {
      _jokeFuture = ApiService.getJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDEF2F1),
      appBar: AppBar(
        backgroundColor: const Color(0xffDEF2F1),
        elevation: 0.0,
        title: const Text(
            "Humourhive",
          style: TextStyle(
            fontSize: 32,
            color: Color(0xff17242A),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: FutureBuilder<String>(
            future: _jokeFuture,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return Text("Error: ${snapshot.error}");
                }else{
                  _joke = snapshot.data!;
                  return Text(
                    _joke,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff17242A),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
              }else{
                return const CircularProgressIndicator(
                  color: Color(0xff17242A),
                );
              }
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: generateJoke,
        backgroundColor: const Color(0xff17242A),
        child: const Icon(Icons.refresh, color: Color(0xffDEF2F1)),
      ),
    );
  }
}