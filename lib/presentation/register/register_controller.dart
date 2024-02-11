import 'package:passportal/core/network/check_internet.dart';
import 'package:passportal/domain/entities/boarding_entity.dart';
import 'package:passportal/domain/repositories/boarding_repository.dart';
import 'package:get/get.dart';

class RegisterController {
  final BoardingRepository repository;
  var isLoading = false.obs;

  String? name;
  String? lastName;
  String? email;
  String? age;
  String? airport;
  String? flight;
  DateTime? departureTime;
  DateTime? arrivalTime;

  RegisterController({
    required this.repository,
  });

  void register() async {
    if (isLoading.isTrue) return;
    if (validateForm()) {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 1000));
      bool hasInternet = await CheckInternet.checkInternet();
      if (!hasInternet) {
        Get.snackbar(
          "Error",
          "No hay conexión a internet",
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
        return;
      }
      
      try {
        final response = await repository.createPass(
          BoardingEntity(
            name: name!,
            lastName: lastName!,
            email: email!,
            age: int.parse(age!),
            airport: airport!,
            flight: flight!,
            departureTime: departureTime!,
            arrivalTime: arrivalTime!,
          ),
        );
        response.fold(
          (l) => Get.snackbar(
            "Error",
            "Ocurrió un error al registrar el pase",
            snackPosition: SnackPosition.BOTTOM,
          ),
          (r) {
            Get.back();
            Get.snackbar(
            "Éxito",
            "Abordo registrado correctamente",
            snackPosition: SnackPosition.BOTTOM,
          );
          resetValues();
          
          },
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "Ocurrió un error al registrar el pase",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      isLoading.value = false;
    } else {
      print("form invalida");
    }
  }

  bool validateForm() {
    print("name: $name");
    print("lastName: $lastName");
    print("email: $email");
    print("age: $age");
    print("airport: $airport");
    print("flight: $flight");
    print("departureTime: $departureTime");
    print("arrivalTime: $arrivalTime");

    return name != null &&
        lastName != null &&
        email != null &&
        age != null &&
        airport != null &&
        flight != null &&
        departureTime != null &&
        arrivalTime != null;
  }

  void changeName(String value) {
    name = value;
  }

  void changeLastName(String value) {
    lastName = value;
  }

  void changeEmail(String value) {
    email = value;
  }

  void changeAge(String value) {
    age = value;
  }

  void changeAirport(String value) {
    airport = value;
  }

  void changeFlight(String value) {
    flight = value;
  }

  void changeDepartureTime(DateTime value) {
    departureTime = value;
  }

  void changeArrivalTime(DateTime value) {
    arrivalTime = value;
  }

  void resetValues() {
    name = null;
    lastName = null;
    email = null;
    age = null;
    airport = null;
    flight = null;
    departureTime = null;
    arrivalTime = null;
  }
}
