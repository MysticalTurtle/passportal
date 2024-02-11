import 'package:flutter/material.dart';
import 'package:passportal/data/models/boarding_model.dart';

class FLightTile extends StatelessWidget {
  const FLightTile({super.key, required this.boardingModel});

  final BoardingModel boardingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue[100],
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre: ${getFullName()}"),
            Text("Edad: ${boardingModel.age ?? 'Desconocido'}"),
            Text("Vuelo: ${boardingModel.flight ?? 'Desconocido'}"),
            boardingModel.email != null
                ? Text("Correo: ${boardingModel.email}")
                : Container(),
            Text("Aeropuerto: ${boardingModel.airport ?? 'Desconocido'}"),
            Text("Hora de salida: ${boardingModel.departureTime ?? 'Desconocido'}"),
            Text("Hora de llegada: ${boardingModel.arrivalTime ?? 'Desconocido'}"),

            
          ],
        ));
  }

  String getFullName() {
    String name = "${boardingModel.name ?? ''} ${boardingModel.lastName ?? ''}";
    return name.trim() == '' ? 'Desconocido' : name;
  }
}
