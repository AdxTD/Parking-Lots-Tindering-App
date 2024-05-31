import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parking_lots_rating/core/data/datasources/remote_data_source.dart';
import 'package:parking_lots_rating/core/data/repository/parkinglot_repository_impl.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';
import 'package:parking_lots_rating/features/summary_view/domain/usecases/get_labeled_parkinglots.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/get_new_parkinglots.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/save_user_decision.dart';

part 'init_dependencies.main.dart';
