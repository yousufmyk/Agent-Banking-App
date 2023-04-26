import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomerChartPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomerChartPage({Key? key}) : super(key: key);

  @override
  CustomerChartPageState createState() => CustomerChartPageState();
}

class CustomerChartPageState extends State<CustomerChartPage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('JAN', 12),
      _ChartData('FEB', 15),
      _ChartData('MAR', 30),
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
                  name: 'Customers',
                  color: Color.fromARGB(255, 56, 47, 189))
            ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}