import 'package:dartz/dartz.dart';
import 'package:passportal/core/error/failure.dart';
import 'package:passportal/domain/entities/boarding_entity.dart';

abstract class BoardingRepository {
  Future<Either<Failure, bool>> createPass(BoardingEntity boardingEntity);
  Future<Either<Failure,List<BoardingEntity>>> getBoardingList();
}