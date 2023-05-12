import 'dart:ffi';

import 'package:flutter/material.dart';

class gameCreen extends StatefulWidget {
  final String nom1;
  final String nom2;
  gameCreen({super.key, required this.nom1, required this.nom2});

  @override
  State<gameCreen> createState() => _gameCreenState();
}

class _gameCreenState extends State<gameCreen> {
  static const String Player_X = "X";
  static const String Player_y = "O";
  late String actuPlayer;
  late List<String> click;
  late bool endGame;
  late int scoreX = 0;
  late int scoreY = 0;

  @override
  void initState() {
    initialGame();
    scoreX = 0;
    scoreY = 0;
    super.initState();
  }

  initialGame() {
    actuPlayer = Player_X;
    endGame = false;
    click = ["", "", "", "", "", "", "", "", ""];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            headText(),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Text(
                    "${widget.nom1} : $scoreX",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Text(
                    "${widget.nom2} : $scoreY",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            changePlayer(),
            gameContainer(),
            restartGame(),
          ],
        ),
      ),
    );
  }

  Widget headText() {
    return RichText(
      text: const TextSpan(
          style: TextStyle(
            color: Colors.green,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(text: 'Tic', style: TextStyle(color: Colors.green)),
            TextSpan(text: 'Toc', style: TextStyle(color: Colors.amber)),
            TextSpan(text: 'Toe', style: TextStyle(color: Colors.black)),
          ]),
    );
  }

  changePlayer() {
    return SizedBox(
      child: Text(
        "Joueur : $actuPlayer",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      width: MediaQuery.of(context).size.width / 1.1,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
        ),
        itemCount: 9,
        itemBuilder: ((context, index) {
          return box(index);
        }),
      ),
    );
  }

  Widget box(int index) {
    return InkWell(
      onTap: () {
        if (endGame || click[index].isNotEmpty) {
          return;
        }
        setState(() {
          click[index] = actuPlayer;
          changeValue();
          Winner();
        });
      },
      child: Container(
        // decoration: BoxDecoration(
        //   // borderRadius: BorderRadius.all(5.0),
        // ),
        color: click[index].isEmpty
            ? Colors.black26
            : click[index] == Player_X
                ? Colors.green
                : Colors.amber,
        child: Center(
            child: Text(
          click[index],
          style: const TextStyle(fontSize: 50, color: Colors.white),
        )),
      ),
    );
  }

  changeValue() {
    if (actuPlayer == Player_X) {
      actuPlayer = Player_y;
    } else {
      actuPlayer = Player_X;
    }
  }

  Winner() {
    List<List<int>> winList = [
      [0, 1, 2],
      [0, 3, 6],
      [0, 4, 8],
      [6, 7, 8],
      [2, 4, 6],
      [3, 4, 5],
      [1, 4, 7],
      [3, 5, 8]
    ];

    for (var pos in winList) {
      String playerPosition0 = click[pos[0]];
      String playerPosition1 = click[pos[1]];
      String playerPosition2 = click[pos[2]];
      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          gameOverMassage("joueur $playerPosition0");
          click = ["", "", "", "", "", "", "", "", ""];
          box(0);
          if (playerPosition0 == "X") {
            scoreX++;
          }
          if (playerPosition0 == "O") {
            scoreY++;
          }
          endGame = true;
          return;
        }
      }
    }
  }

  gameOverMassage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "vous avez gagner $message",
            style: const TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }

  restartGame() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          initialGame();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      child: const Text(
        "Recommencer",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
