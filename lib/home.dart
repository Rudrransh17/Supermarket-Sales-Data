import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:supermarket_sales_data/app_services.dart';
import 'package:supermarket_sales_data/data.dart';
import 'package:supermarket_sales_data/realm_services.dart';
import 'package:supermarket_sales_data/schemas.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore_for_file: prefer_const_constructors

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<BarData> data;
  late List<BarData> barData = [
    BarData('CHN', 12),
    BarData('GER', 15),
    BarData('RUS', 30),
    BarData('BRZ', 6.4),
    BarData('IND', 14)
  ];

  final List<PieData> pieData = [
    PieData('David', 25),
    PieData('Steve', 38),
    PieData('Jack', 34),
    PieData('Others', 52)
  ];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = getBarData("Branch", "Total");
    double maxVal = data[0].y;

    for (int i = 1; i < data.length; i++) {
      if (data[i].y > maxVal) {
        maxVal = data[i].y;
      }
    }
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
            body: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis:
                          NumericAxis(minimum: 0, maximum: maxVal*1.2, interval: maxVal/10),
                      series: <ChartSeries<BarData, String>>[
                        ColumnSeries<BarData, String>(
                          dataSource: data,
                          xValueMapper: (BarData data, _) => data.x,
                          yValueMapper: (BarData data, _) => data.y,
                          name: 'Gold',
                          color: Color.fromRGBO(8, 142, 255, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SfCircularChart(
                        series: <CircularSeries>[
                          // Render pie chart
                          PieSeries<PieData, String>(
                              dataSource: pieData,
                              xValueMapper: (PieData data, _) => data.x,
                              yValueMapper: (PieData data, _) => data.y
                          )
                        ]
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Text('Edit Bar Chart'),
                        Text('Edit Pie Chart')
                      ],
                    ),
                  ),
                ),
              ],
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

// class BarData {
//   BarData(this.x, this.y);
//
//   final String x;
//   final double y;
// }

class PieData {
  PieData(this.x, this.y);
  final String x;
  final double y;
}

Container waitingIndicator() {
  return Container(
    color: Colors.black.withOpacity(0.2),
    child: const Center(child: CircularProgressIndicator()),
  );
}
