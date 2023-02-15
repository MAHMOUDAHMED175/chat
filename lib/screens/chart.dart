import 'package:chat/layout/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {

  late final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<UserData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
              title: ChartTitle(text: 'عدد مستخدمى التطبيق بالشهر'),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                LineSeries<UserData, double>(
                    name: 'Users',
                    dataSource: _chartData,
                    xValueMapper: (UserData count, _) => count.year,
                    yValueMapper: (UserData count, _) => count.count,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
              ),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}',
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
            )));
  }

  List<UserData> getChartData() {
    final List<UserData> chartData = [
      UserData(1, 0),
      UserData(1.2, ChatCubit.get(context).users.length.toDouble()),
      UserData(1.9,  ChatCubit.get(context).users.length.toDouble()+2),
      UserData(2.12,  ChatCubit.get(context).users.length.toDouble()+5),

    ];
    return chartData;
  }
}

class UserData {
  UserData(this.year, this.count);
  final double year;
  final double count;
}