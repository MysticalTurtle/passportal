import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'app_textfield.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());
  DateTime? departureTime = DateTime.now();
  DateTime? arrivalTime = DateTime(2026, 12, 31);
  RegisterController controller = Get.find();
  Key formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar abordo"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(24),
          color: Colors.blueGrey[50],
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const Text("Ingrese los datos del vuelo a registrar"),
                const SizedBox(height: 30),
                AppTextField(
                  hintText: "Nombre",
                  nextFocus: focusNodes[0],
                  prefixIcon: Icons.person,
                  onChanged: controller.changeName,
                ),
                AppTextField(
                  hintText: "Apellido",
                  focusNode: focusNodes[0],
                  nextFocus: focusNodes[1],
                  prefixIcon: Icons.person,
                  onChanged: controller.changeLastName,
                ),
                AppTextField(
                  hintText: "Correo",
                  focusNode: focusNodes[1],
                  nextFocus: focusNodes[2],
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    RegExp emailRegex =
                        RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$");
                    if (!emailRegex.hasMatch(value)) {
                      return "Correo inválido";
                    }
                    return null;
                  },
                  prefixIcon: Icons.email,
                  onChanged: controller.changeEmail,
                ),
                AppTextField(
                  hintText: "Edad",
                  focusNode: focusNodes[2],
                  nextFocus: focusNodes[3],
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.person,
                  onChanged: controller.changeAge,
                ),
                AppTextField(
                  hintText: "Aeropuerto",
                  focusNode: focusNodes[3],
                  nextFocus: focusNodes[4],
                  prefixIcon: Icons.airport_shuttle,
                  onChanged: controller.changeAirport,
                ),
                AppTextField(
                  hintText: "Vuelo",
                  focusNode: focusNodes[4],
                  prefixIcon: Icons.flight,
                  onChanged: controller.changeFlight,
                ),
                const SizedBox(height: 30),

                // Date pickers
                const Text("Fecha de salida"),
                const SizedBox(height: 8),
                Container(
                  color: Colors.white,
                  child: SfDateRangePicker(
                    enablePastDates: false,
                    onSelectionChanged: (args) {
                      setState(() => departureTime = args.value);
                      controller.changeDepartureTime(args.value);
                    },
                    selectionMode: DateRangePickerSelectionMode.single,
                    maxDate: arrivalTime,
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Fecha de llegada"),
                const SizedBox(height: 8),
                Container(
                  color: Colors.white,
                  child: SfDateRangePicker(
                      enablePastDates: false,
                      onSelectionChanged: (args) {
                        setState(() => arrivalTime = args.value);
                        controller.changeArrivalTime(args.value);
                      },
                      selectionMode: DateRangePickerSelectionMode.single,
                      minDate: departureTime),
                ),
                const SizedBox(height: 16),

                // Register button
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if ((formKey as GlobalKey<FormState>)
                        .currentState!
                        .validate()) {
                      controller.register();

                    } else {
                      scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      Get.showSnackbar(
                        const GetSnackBar(
                          title: "Error",
                          message: 'Verifique los campos, por favor',
                          icon: Icon(Icons.refresh),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Obx(
                    () => controller.isLoading.value
                        ? LoadingAnimationWidget.prograssiveDots(
                            color: const Color(0xFF1A1A3F),
                            size: 40,
                          )
                        : const Text("Registrar"),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
