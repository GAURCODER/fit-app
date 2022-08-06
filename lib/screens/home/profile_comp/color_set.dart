import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_app/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Animation Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Playground(title: 'Curved Drawer Demo'),
    );
  }
}

class Playground extends StatefulWidget {
  Playground({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.title, style: const TextStyle(color: Colors.black)),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current index is $index',
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Left Width = $leftWidth"),
              Slider(
                label: "Left Drawer Width",
                activeColor: Colors.blue,
                min: 50.0,
                max: 100.0,
                divisions: 50,
                value: leftWidth,
                onChanged: (value) => setState(() => leftWidth = value),
              ),
              const SizedBox(
                height: 15,
              ),
              SliderTheme(
                  data: const SliderThemeData(
                      valueIndicatorTextStyle: TextStyle(color: Colors.grey)),
                  child: Slider(
                    label: "Left Drawer Background Color",
                    activeColor: colorPallete[leftBackgroundColor],
                    min: 0,
                    max: colorPallete.length.toDouble() - 1.0,
                    divisions: colorPallete.length,
                    value: leftBackgroundColor.toDouble(),
                    onChanged: (value) => setState(() {
                      leftBackgroundColor = value.toInt();
                    }),
                  )),
              const SizedBox(
                height: 15,
              ),
              SliderTheme(
                  data: const SliderThemeData(
                      valueIndicatorTextStyle: TextStyle(color: Colors.grey)),
                  child: Slider(
                    label: "Left Drawer Label Color",
                    activeColor: colorPallete[leftTextColor],
                    min: 0,
                    max: colorPallete.length.toDouble() - 1.0,
                    divisions: colorPallete.length,
                    value: leftTextColor.toDouble(),
                    onChanged: (value) => setState(() {
                      leftTextColor = value.toInt();
                    }),
                  )),
              const SizedBox(
                height: 15,
              ),
            ]),
      ),
    );
  }
}
