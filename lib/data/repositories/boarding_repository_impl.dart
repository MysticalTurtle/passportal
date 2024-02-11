import 'package:dartz/dartz.dart';
import 'package:passportal/core/error/failure.dart';
import 'package:passportal/data/datasources/boarding_remote_datasource.dart';
import 'package:passportal/data/models/boarding_model.dart';
import 'package:passportal/domain/entities/boarding_entity.dart';
import 'package:passportal/domain/repositories/boarding_repository.dart';

class BoardingRepositoryImpl implements BoardingRepository {
  final BoardingRemoteDatasource remoteDataSource;

  @override
  Future<Either<Failure, bool>> createPass(BoardingEntity boardingEntity) async {
    try {
      await remoteDataSource.addBoardingPass(boardingEntity);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BoardingModel>>> getBoardingList() async {
    List<BoardingModel> boardings = [];
    try {
      boardings = await remoteDataSource.getBoardingList();
      return Right(boardings);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  BoardingRepositoryImpl({
    required this.remoteDataSource,
  });
}

