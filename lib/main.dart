import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpecialCalculator(),
    );
  }
}

class SpecialCalculator extends StatefulWidget {
  const SpecialCalculator({super.key});

  @override
  State<SpecialCalculator> createState() => _SpecialCalculatorState();
}

class _SpecialCalculatorState extends State<SpecialCalculator> {
  String equation = '0';
  String result = '0';
  String expression = "";
  double equationfontsize = 38.0;
  double resultfontsize = 48.0;
  buttonpressed(Buttontxt) {
    setState(() {
      if (Buttontxt == 'C') {
        equation = '0';
        result = '0';
      } else if (Buttontxt == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (Buttontxt == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'INVALID';
        }
      } else {
        if (equation == '0') {
          equation = Buttontxt;
        } else {
          equation = equation + Buttontxt;
        }
      }
    });
  }

  Widget buildbutton(String Buttontxt, double buttonheight, Color buttoncolor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonheight,
      color: buttoncolor,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          Buttontxt,
          style: TextStyle(
              color: Color.fromARGB(255, 22, 6, 6),
              fontSize: 30.0,
              fontWeight: FontWeight.normal),
        ),
        onPressed: () => buttonpressed(Buttontxt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(color: Colors.black, fontSize: equationfontsize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(color: Colors.black, fontSize: resultfontsize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbutton('C', 1, Colors.yellow),
                      buildbutton('⌫', 1, Colors.red),
                      buildbutton('÷', 1, Colors.red),
                    ]),
                    TableRow(children: [
                      buildbutton('7', 1, Colors.yellow),
                      buildbutton('8', 1, Colors.red),
                      buildbutton('9', 1, Colors.red),
                    ]),
                    TableRow(children: [
                      buildbutton('4', 1, Colors.yellow),
                      buildbutton('5', 1, Colors.red),
                      buildbutton('6', 1, Colors.red),
                    ]),
                    TableRow(children: [
                      buildbutton('1', 1, Colors.yellow),
                      buildbutton('2', 1, Colors.red),
                      buildbutton('3', 1, Colors.red),
                    ]),
                    TableRow(children: [
                      buildbutton('.', 1, Colors.yellow),
                      buildbutton('0', 1, Colors.red),
                      buildbutton('00', 1, Colors.red),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbutton('X', 1, Colors.yellow),
                    ]),
                    TableRow(children: [
                      buildbutton('-', 1, Colors.yellow),
                    ]),
                    TableRow(children: [
                      buildbutton('+', 1, Colors.yellow),
                    ]),
                    TableRow(children: [
                      buildbutton('=', 2, Colors.yellow),
                    ]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
