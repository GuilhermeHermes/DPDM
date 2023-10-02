import 'package:flutter/material.dart';
import 'service.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.amber),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Variáveis para armazenar os valores das moedas
  double dolar = 0;
  double euro = 0;

  Map<String, dynamic> apiData = {}; // Armazene os dados da API aqui

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        apiData = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  // Variáveis para armazenar as seleções do usuário
  String moedaOrigem = 'Real';
  String moedaDestino = 'Real';

  // Controladores de texto para as entradas do usuário
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  // Método para realizar a conversão de moeda
  void _realizarConversao() {
    double valorReal = double.tryParse(realController.text) ?? 0;
    double resultado = 0;

    // Lógica para converter moeda de origem para moeda de destino
    if (moedaOrigem == 'Real') {
      if (moedaDestino == 'Dolar') {
        resultado = valorReal / dolar;
      } else if (moedaDestino == 'Euro') {
        resultado = valorReal / euro;
      } else {
        resultado = valorReal;
      }
    } else if (moedaOrigem == 'Dolar') {
      if (moedaDestino == 'Real') {
        resultado = valorReal * dolar;
      } else if (moedaDestino == 'Euro') {
        resultado = (valorReal * dolar) / euro;
      } else {
        resultado = valorReal;
      }
    } else if (moedaOrigem == 'Euro') {
      if (moedaDestino == 'Real') {
        resultado = valorReal * euro;
      } else if (moedaDestino == 'Dolar') {
        resultado = (valorReal * euro) / dolar;
      } else {
        resultado = valorReal;
      }
    }

    // Atualiza os controladores de texto com os resultados
    dolarController.text = resultado.toStringAsFixed(2);
    euroController.text = resultado.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        // Substitua isso pelo seu método de busca de taxas de câmbio
        // Use um Future para buscar as taxas de câmbio da API
        // e atualizar os valores de dolar e euro
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar dados"),
            );
          } else {
            // Atualiza os valores de dolar e euro com os valores da API
            dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
            euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  DropdownButton<String>(
                    value: moedaOrigem,
                    onChanged: (newValue) {
                      setState(() {
                        moedaOrigem = newValue!;
                      });
                      _realizarConversao();
                    },
                    items: ['Real', 'Dolar', 'Euro']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: moedaDestino,
                    onChanged: (newValue) {
                      setState(() {
                        moedaDestino = newValue!;
                      });
                      _realizarConversao();
                    },
                    items: ['Real', 'Dolar', 'Euro']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: realController,
                    decoration: InputDecoration(
                      labelText: 'Valor em Reais',
                    ),
                    onChanged: (text) {
                      _realizarConversao();
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: dolarController,
                    decoration: InputDecoration(
                      labelText: 'Valor em Dólares',
                    ),
                    onChanged: (text) {
                      // Lógica de conversão inversa, se necessário
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: euroController,
                    decoration: InputDecoration(
                      labelText: 'Valor em Euros',
                    ),
                    onChanged: (text) {
                      // Lógica de conversão inversa, se necessário
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Substitua isso pelo seu método de busca de taxas de câmbio
  Future<Map<String, dynamic>> fetchExchangeRates() async {
    // Simule uma chamada de API para buscar as taxas de câmbio
    await Future.delayed(Duration(seconds: 2));
    return {
      'USD': {'buy': 5.10, 'sell': 5.30},
      'EUR': {'buy': 6.00, 'sell': 6.20},
    };
  }
}
