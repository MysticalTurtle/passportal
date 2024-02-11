import 'package:intl/intl.dart';
import 'package:passportal/core/error/failure.dart';
import 'package:passportal/core/network/graphql_service.dart';
import 'package:passportal/data/models/boarding_model.dart';
import 'package:passportal/domain/entities/boarding_entity.dart';

abstract class BoardingRemoteDatasource {
  Future<List<BoardingModel>> getBoardingList();
  Future<bool> addBoardingPass(BoardingEntity boarding);
}

class BoardingRemoteDatasourceImpl extends BoardingRemoteDatasource {
  BoardingRemoteDatasourceImpl({required this.service});

  final GraphQLService service;

  @override
  Future<List<BoardingModel>> getBoardingList() async {
    List<BoardingModel> boardingList = [];

    const String query = r'''
query BoardingPass {
    BoardingPass {
        age
        airport
        arrivalTime
        departureTime
        email
        flight
        id
        lastName
        name
    }
}
''';

    try {
      final response = await service.performQuery(query);

      print("response: $response");

      final data = response['BoardingPass'];
      for (var item in data) {
        boardingList.add(BoardingModel.fromJson(item));
      }

      if (boardingList.isEmpty) {
        throw Failure(message: 'No se encontraron boarding passes');
      }

      return boardingList;
    } catch (e) {
      print(e.toString());
      throw Failure(message: 'Error al obtener los boarding passes');
    }
  }

  @override
  Future<bool> addBoardingPass(BoardingEntity boarding) async {
    try {
      final response = await service.performMutation("""
mutation Insert_BoardingPass_one {
    insert_BoardingPass_one(
        object: {
            age: ${boarding.age.toString()},
            airport: "${boarding.airport}",
            arrivalTime: "${DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(boarding.arrivalTime!)}",
            departureTime: "${DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(boarding.departureTime!)}",
            email: "${boarding.email}",
            flight: "${boarding.flight}",
            lastName: "${boarding.lastName}",
            name: "${boarding.name}"
        }
    ) {
        age
        airport
        arrivalTime
        departureTime
        email
        flight
        id
        lastName
        name
    }
}
""");
      print("graphql response: $response");
      return true;
    } catch (e) {
      throw Failure(message: 'Error al agregar el boarding pass');
    }
  }
}
