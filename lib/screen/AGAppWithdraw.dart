import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WithdrawChartPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  WithdrawChartPage({Key? key}) : super(key: key);

  @override
  WithdrawChartPageState createState() => WithdrawChartPageState();
}

class WithdrawChartPageState extends State<WithdrawChartPage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('JAN', 40),
      _ChartData('FEB', 25),
      _ChartData('MAR', 10),
      // _ChartData('APR', 6.4),
      // _ChartData('MAY', 14)
      // _ChartData('JUN', 14)
      // _ChartData('JUL', 14)
      // _ChartData('MAY', 14)
      // _ChartData('MAY', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Despoit',
                  color: Color.fromARGB(255, 0, 223, 48))
            ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}