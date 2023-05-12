import 'package:flutter/material.dart';
import 'dart:async';

import 'game_screen.dart';

class palyerScreen extends StatefulWidget {
  const palyerScreen({super.key});

  @override
  State<palyerScreen> createState() => _palyerScreenState();
}

class _palyerScreenState extends State<palyerScreen> {
  final myControllerX = TextEditingController();
  final myControllerY = TextEditingController();
  String errorMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    // myControllerX.dispose();
    // myControllerY.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ajouter les Joueurs",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            inputFieldX("Nom du joueur X"),
            inputFieldY("Nom du joueur Y"),
            if (errorMessage != null)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 14,
                child: ElevatedButton(
                  onPressed: () {
                    Validation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Commencez",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  inputFieldX(String labelText) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: myControllerX,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  inputFieldY(String labelText) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: myControllerY,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void Validation() async {
    final textX = myControllerX.text;
    final textY = myControllerY.text;

    if (textX.isEmpty && textY.isEmpty) {
      setState(() {
        errorMessage = "Les champs sont vide";
      });
    } else if (textX.isEmpty || textY.isEmpty ) 
    {
      setState(() {
        errorMessage = "L'un des champs est vide";
      });
      return;
    }
    if (textX.isNotEmpty && textY.isNotEmpty) {
     setState(() {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              gameCreen(nom1: myControllerX.text, nom2: myControllerY.text),
        ),
      );
     });
      return;
    }
    setState(() {
      //  errorMessage = null;
    });
  }
}
