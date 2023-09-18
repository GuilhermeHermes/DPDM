import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "BFCalc",
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: CalculadoraBFApp(),
  ));
}

class CalculadoraBFApp extends StatefulWidget {
  @override
  _CalculadoraBFAppState createState() => _CalculadoraBFAppState();
}

class _CalculadoraBFAppState extends State<CalculadoraBFApp> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pescocoController = TextEditingController();
  TextEditingController cinturaController = TextEditingController();
  TextEditingController quadrilController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController resultadoBFController = TextEditingController();
  TextEditingController resultadoIMCController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String resultadoBF = '';
  String resultadoIMC = "";
  void _resetCampos() {
    _formKey.currentState!.reset();
    pesoController.clear();
    alturaController.clear();
    pescocoController.clear();
    cinturaController.clear();
    quadrilController.clear();
    sexoController.clear();
    resultadoBFController.clear();
    resultadoIMCController.clear();
    setState(() {
      resultadoBF = '';
      resultadoIMC = '';
    });
  }

  double log10(num x) {
    return log(x) / ln10;
  }

  void calcularBF() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text);
    double pescoco = double.tryParse(pescocoController.text) ?? 0;
    double cintura = double.tryParse(cinturaController.text) ?? 0;
    double quadril = double.tryParse(quadrilController.text) ?? 0;
    double bf;
    if (sexoController.text == 'M' || sexoController.text == 'm') {
      bf = 86.010 * log10((cintura / 2.54) - (pescoco / 2.54)) -
          70.041 * log10(altura / 2.54) +
          36.76;
    } else {
      bf = 86.010 *
              log10((cintura / 2.54) + (quadril / 2.54) - (pescoco / 2.54)) -
          97.684 * log10(altura / 2.54) +
          78.387;
    }

    double imc = peso / ((altura / 100) * (altura / 100));
    setState(() {
      resultadoBF = 'O seu percentual de gordura é: ${bf.toStringAsFixed(2)}%';
      resultadoIMC = 'O seu IMC é: ${imc.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("BFcalc"),
        centerTitle: true,
        leading: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(Icons.account_circle), // Ícone de usuário
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ], //<Widget>[]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Sexo(M/F)",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: sexoController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira seu sexo!";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira seu peso!";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira sua altura!";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Circuferência do pescoço (cm)",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: pescocoController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira seu pescoço!";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Insira a medida da sua cintura (cm)",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: cinturaController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira a medida da sua cintura!";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "insira a medida do seu quadril (cm)",
                      labelStyle: TextStyle(color: Colors.indigo)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                  controller: quadrilController,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Insira a medida do seu quadril!";
                    else
                      return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ButtonTheme(
                      height: 50.0,
                      highlightColor: Colors.white,
                      buttonColor: Colors.amber,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) calcularBF();
                        },
                        child: Text(
                          "Calcular",
                          style:
                              TextStyle(color: Colors.indigo, fontSize: 25.0),
                        ),
                      )),
                ),
                Text(
                  resultadoBF,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                ),
                Text(
                  resultadoIMC,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo, fontSize: 25.0),
                )
              ],
            )),
      ),
    );
  }
}
