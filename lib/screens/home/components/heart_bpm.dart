import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_bpm/chart.dart';

class Valbp {
  static int x = 0;
  static get valer => x;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart BPM Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HeartPage(),
    );
  }
}

class HeartPage extends StatefulWidget {
  const HeartPage({Key? key}) : super(key: key);

  @override
  _HeartPageState createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  //  Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
  Widget? dialog;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              isBPMEnabled
                  ? dialog = HeartBPMDialog(
                      context: context,
                      onRawData: (value) {
                        setState(() {
                          if (data.length >= 100) data.removeAt(0);
                          data.add(value);
                        });
                        // chart = BPMChart(data);
                      },
                      onBPM: (value) => setState(() {
                        Valbp.x = value;
                        if (bpmValues.length >= 100) bpmValues.removeAt(0);
                        bpmValues.add(SensorValue(
                            value: value.toDouble(), time: DateTime.now()));
                      }),
                      // sampleDelay: 1000 ~/ 20,
                      // child: Container(
                      //   height: 50,
                      //   width: 100,
                      //   child: BPMChart(data),
                      // ),
                    )
                  : const SizedBox(
                      height: 150,
                    ),
              isBPMEnabled && data.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(border: Border.all()),
                      height: 180,
                      child: BPMChart(data),
                    )
                  : const SizedBox(),
              isBPMEnabled && bpmValues.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(border: Border.all()),
                      constraints: const BoxConstraints.expand(height: 180),
                      child: BPMChart(bpmValues),
                    )
                  : const SizedBox(),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.favorite_rounded),
                  label: Text(isBPMEnabled ? "Stop measurement" : "Measure BPM",
                      style: const TextStyle(color: Colors.white)),
                  onPressed: () => setState(() {
                    if (isBPMEnabled) {
                      isBPMEnabled = false;
                      // dialog.
                    } else {
                      isBPMEnabled = true;
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
