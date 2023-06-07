import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:supermarket_sales_data/app_services.dart';
import 'package:supermarket_sales_data/realm_services.dart';
import 'package:supermarket_sales_data/schemas.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore_for_file: prefer_const_constructors

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late List<_ChartData> data = [
    _ChartData('CHN', 12),
    _ChartData('GER', 15),
    _ChartData('RUS', 30),
    _ChartData('BRZ', 6.4),
    _ChartData('IND', 14)
  ];

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    return Provider.of<RealmServices?>(context, listen: false) == null
        ? Container()
        : Scaffold(
            appBar: AppBar(
              title: Text('Supermarket Sales Data Visualizer'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log out',
                  onPressed: () async => await logOut(context, realmServices),
                ),
              ],
            ),
            body: Center(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 40, interval: 10),
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: 'Gold',
                    color: Color.fromRGBO(8, 142, 255, 1),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> logOut(BuildContext context, RealmServices realmServices) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    appServices.logOut();
    await realmServices.close();
    Navigator.pushReplacementNamed(context, '/login');
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

Container waitingIndicator() {
  return Container(
    color: Colors.black.withOpacity(0.2),
    child: const Center(child: CircularProgressIndicator()),
  );
}
