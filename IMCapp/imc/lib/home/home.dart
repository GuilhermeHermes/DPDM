import 'package:flutter/material.dart';
import 'imc.dart';
import 'BF.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool selected = false;
  bool selected2 = false;
  Color secundaryColor = Colors.orange;
  Color primaryColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/backgroundimcbf.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            // Defina a posição vertical desejada
            top: 450,

            child: AnimatedContainer(
              width: selected ? 450 : 450,
              height: selected ? 50 : 50,
              color: selected ? Colors.black : Colors.black,
              duration: Duration(seconds: 1), // Duração da animação
              curve: Curves.elasticInOut, // Curva de animação
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: MediaQuery.of(context).size.width /
                        2, // Divide a largura ao meio
                    color: selected
                        ? selected2
                            ? Colors.green
                            : Colors.red
                        : Colors.orange, // Cor de fundo do primeiro botão
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          selected ? Colors.black : Colors.white,
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.white.withOpacity(0.04);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.white.withOpacity(0.12);
                            return null;
                          },
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selected = !selected;
                          selected2 = true;
                          if (selected && selected2 == true) {
                            // Executar ação quando selected for verdadeiro
                            // Por exemplo, navegar para outra tela

                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CalculadoraBFApp(),
                                ),
                              );
                            });
                          }
                        });
                      },
                      child: selected
                          ? selected2
                              ? Icon(Icons.check)
                              : Icon(Icons.close)
                          : Text('Calcular BF',
                              style: TextStyle(
                                fontSize: 24.0, // Tamanho da fonte maior
                                fontFamily: 'Arial',
                                color: Colors.black,
                              )),
                      // Ícone "X"
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: MediaQuery.of(context).size.width /
                        2, // Divide a largura ao meio
                    color: selected
                        ? selected2
                            ? Colors.red
                            : Colors.green
                        : Colors.yellow, // Cor de fundo do segundo botão
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          selected ? Colors.black : Colors.white,
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.white.withOpacity(0.04);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.white.withOpacity(0.12);
                            return null;
                          },
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selected = !selected;
                          selected2 = false;
                        });
                        if (selected && selected2 == false) {
                          // Executar ação quando selected for verdadeiro
                          // Por exemplo, navegar para outra tela

                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalculadoraIMCApp(),
                              ),
                            );
                          });
                        }
                      },
                      child: selected
                          ? selected2
                              ? Icon(Icons.close)
                              : Icon(Icons.check)
                          : Text('Calcular IMC',
                              style: TextStyle(
                                  fontSize: 24.0, // Tamanho da fonte maior
                                  fontFamily: 'Arial',
                                  color: Colors.black)), // Ícone de "check"
                    ),
                  ),
                ],
              ), // Substitua 'YourChildWidget' pelo conteúdo desejado
            ),
          ),
        ],
      ),
    );
  }
}
