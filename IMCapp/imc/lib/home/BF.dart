import 'package:flutter/material.dart';

class CalculadoraIMCApp extends StatefulWidget {
  @override
  _CalculadoraIMCAppState createState() => _CalculadoraIMCAppState();
}

class _CalculadoraIMCAppState extends State<CalculadoraIMCApp> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String resultadoIMC = '';

  String determinarEstadoIMC(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc < 24.9) {
      return 'Peso normal';
    } else if (imc < 29.9) {
      return 'Sobrepeso';
    } else if (imc < 34.9) {
      return 'Obesidade grau 1';
    } else if (imc < 39.9) {
      return 'Obesidade grau 2';
    } else {
      return 'Obesidade grau 3';
    }
  }

  void _calcularIMC() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) /
        100; // Converter altura para metros
    double imc = peso / (altura * altura);

    String estadoIMC =
        determinarEstadoIMC(imc); // Determinar o estado com base no IMC

    setState(() {
      resultadoIMC = 'Seu IMC é: ${imc.toStringAsFixed(2)}';
      resultadoIMC += '\nEstado: $estadoIMC'; // Adicionar o estado ao resultado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                ),
                controller: pesoController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira seu peso';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                ),
                controller: alturaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira sua altura';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _calcularIMC();
                  }
                },
                child: Text('Calcular'),
              ),
              SizedBox(height: 20.0),
              Text(
                resultadoIMC,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalculadoraIMCApp(),
  ));
}
