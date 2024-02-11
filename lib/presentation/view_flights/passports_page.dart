import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:passportal/core/utils/check_internet.dart';
import 'package:passportal/data/datasources/boarding_remote_datasource.dart';
import 'package:passportal/data/models/boarding_model.dart';
import 'package:passportal/presentation/view_flights/flight_tile.dart';

class PassportsPage extends StatefulWidget {
  const PassportsPage({super.key});

  @override
  State<PassportsPage> createState() => _PassportsPageState();
}

class _PassportsPageState extends State<PassportsPage> {
  bool isLoading = true;
  List<BoardingModel> boardingList = [];
  bool isReversed = false;

  @override
  void initState() {
    _getPassportsList();
    super.initState();
  }

  void _getPassportsList() async {
    bool hasInternet = await CheckInternet.checkInternet();
    if (!hasInternet) {
      Get.snackbar(
        "Error",
        "No hay conexión a internet",
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading = false;
      setState(() {});
      return;
    }
    BoardingRemoteDatasource boardingRemoteDatasource =
        Get.find<BoardingRemoteDatasourceImpl>();
    boardingList = await boardingRemoteDatasource.getBoardingList();
    boardingList = boardingList.reversed.toList();
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abordos registrados'),
      ),
      body: Center(
        child: isLoading
            ? LoadingAnimationWidget.threeArchedCircle(
                size: 100,
                color: Colors.blue[300]!,
              )
            : Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      boardingList.isEmpty
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                boardingList = boardingList.reversed.toList();
                                isReversed = !isReversed;
                                setState(() {});
                              },
                              child: Row(
                                children: [
                                  Text(isReversed
                                      ? "Más antiguo"
                                      : "Más reciente"),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      isReversed
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      const SizedBox(width: 20)
                    ],
                  ),
                  
                  Expanded(
                    child: boardingList.isEmpty
                      ? const Center(
                          child: Text("No se encontraron abordos"),
                        )
                      :ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: boardingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FLightTile(
                          boardingModel: boardingList[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
