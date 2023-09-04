import 'package:flutter/material.dart';

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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 4, 37, 5)),
        useMaterial3: true,
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter == 0) {
        _counter = 0;
      } else {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Chimarrao app"),
      ),
      body: Stack(
        children: <Widget>[
          // Imagem de fundo
          Image.asset(
            'assets/chimarrao (2).png', // Substitua pelo caminho da sua imagem
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              width: 400,
              height: 400,
              color: Colors.black45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add),
                  ),
                  const Text(
                    'Number of people: ',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontFamily: 'Arial'),
                  ),
                  Text(
                    '$_counter',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontFamily: 'Arial'),
                  ),
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
