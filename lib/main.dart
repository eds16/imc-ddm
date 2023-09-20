import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "IMC",
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";

  void resetFields() {
    _formKey.currentState!.reset();
    weightController.clear();
    heightController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _textInfo = "Under Weight (${imc.toStringAsPrecision(4)})";
      } else if (imc < 24.9) {
        _textInfo = "Ideal Weight(${imc.toStringAsPrecision(4)})";
      } else if (imc < 29.9) {
        _textInfo = "Slightly Overweight(${imc.toStringAsPrecision(4)})";
      } else if (imc < 34.9) {
        _textInfo = "Grade I Obesity(${imc.toStringAsPrecision(4)})";
      } else if (imc < 39.9) {
        _textInfo = "Grade II Obesity(${imc.toStringAsPrecision(4)})";
      } else {
        _textInfo = "Grade III Obesity(${imc.toStringAsPrecision(4)})";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC Calculator"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(
                Icons.person,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Weight(KG)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insert a value";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Height",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insert a value.";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ButtonTheme(
                  height: 50.0,
                  highlightColor: Colors.amber,
                  child: ElevatedButton(
                    child: const Text(
                      "Calculater",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _textInfo,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
