import 'package:flutter/material.dart';

void main() {
  runApp(const SquareOrCubeApp());
}

class SquareOrCubeApp extends StatelessWidget {
  const SquareOrCubeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Square or Triangle',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

int _checksquareOrCube(int value) {
  bool isCube = false, isSquare = false;

  if (value == 1) {
    isSquare = true;
    isCube = true;
  }

  for (int i = 1; i <= value / 2; i++) {
    if (value % i == 0) {
      if (value / i == i) {
        isSquare = true;
      }
    }
     if ((value / i) % i == 0) {
      if ((value / i) / i == i) {
        isCube = true;
      }
    }
  }

  if (!isSquare && !isCube) {
    return 0;
  } else if (isSquare && !isCube) {
    return 1;
  } else if (!isSquare && isCube) {
    return 2;
  } else {
    // is Square and Cube
    return 3;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            child: Text('Number Shapes'),
            alignment: Alignment.center,
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text(
                "Please input a number to see if it is\nSquare or Cube.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  suffix: IconButton(
                    iconSize: 23,
                    onPressed: () => controller.clear(),
                    icon: const Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            int result = _checksquareOrCube(int.parse(controller.text));
            String dialogText = '';

            switch (result) {
              case 0:
                {
                  dialogText =
                      'Number ${controller.text} is neither Square nor Cube';
                }
                break;
              case 1:
                {
                  dialogText = 'Number ${controller.text} is Square';
                }
                break;
              case 2:
                {
                  dialogText = 'Number ${controller.text} is Cube';
                }
                break;
              case 3:
                {
                  dialogText =
                      'Number ${controller.text} is both Square and Cube';
                }
                break;
            }

            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(controller.text),
                content: Text(dialogText),
              ),
            );
          },
        ),
      ),
    );
  }
}