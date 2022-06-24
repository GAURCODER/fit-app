import 'dart:html';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fit_app/screens/home/components/SensorData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SensorDataChart extends StatelessWidget {
  final List<SensorData> data;

  SensorDataChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SensorData, num>> series = [
      charts.Series(
          id: "Accelerometer",
          data: data,
          domainFn: (SensorData series, _) => series.x,
          measureFn: (SensorData series, _) => series.y)
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: charts.LineChart(series,
                      domainAxis: const charts.NumericAxisSpec(
                        tickProviderSpec: charts.BasicNumericTickProviderSpec(
                            zeroBound: false),
                        viewport: charts.NumericExtents(0.0, 20.0),
                      ),
                      animate: true)),
            ],
          ),
        ),
      ),
    );
  }
}
