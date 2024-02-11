import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:passportal/core/network/graphql_service.dart';
import 'data/datasources/boarding_remote_datasource.dart';
import 'data/repositories/boarding_repository_impl.dart';
import 'presentation/register/register_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  Get.put(GraphQLService());

  // Data Source
  Get.put(BoardingRemoteDatasourceImpl(service: Get.find()));

  // Repository
  Get.put(BoardingRepositoryImpl(remoteDataSource: Get.find<BoardingRemoteDatasourceImpl>()));

  // State management
  Get.put(RegisterController(repository: Get.find<BoardingRepositoryImpl>()));
}
