import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;

  void _onPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentInput = "";
        _operator = "";
        _num1 = 0;
        _num2 = 0;
      } else if (value == "=") {
        _num2 = double.tryParse(_currentInput) ?? 0;
        switch (_operator) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "x":
            _output = (_num1 * _num2).toString();
            break;
          case "\u00F7":
            _output = (_num2 != 0 ? (_num1 / _num2).toString() : "Erro");
            break;
        }
        _currentInput = "";
        _operator = "";
      } else if (value == "+" || value == "-" || value == "x" || value == "\u00F7") {
        _num1 = double.tryParse(_currentInput) ?? 0;
        _operator = value;
        _currentInput = "";
      } else {
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Calculadora"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            width: 300,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Text(
                    _output,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _buildButton("7", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("8", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("9", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("\u00F7", Colors.yellow),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildButton("4", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("5", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("6", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("x", Colors.yellow),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildButton("1", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("2", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("3", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("-", Colors.yellow),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildButton("0", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton(".", Colors.blue),
                          SizedBox(width: 8),
                          _buildButton("=", Colors.yellow),
                          SizedBox(width: 8),
                          _buildButton("+", Colors.yellow),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _onPressed("C"),
                  child: Text(
                    "Limpar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
