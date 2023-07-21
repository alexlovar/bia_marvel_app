import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/constants.dart';
import '../common/utils.dart';
import '../model/series_model.dart';
import '../service/remote_movie_repository_service.dart';

final movieRemoteRepositoryController =
    StateNotifierProvider.autoDispose<MovieRemoteRepositoryController, int>(
        (ref) => MovieRemoteRepositoryController());

class MovieRemoteRepositoryController extends StateNotifier<int> {
  MovieRemoteRepositoryController() : super(0);
  final ctrl = TextEditingController();
  WidgetRef? ref;

  void setSelectedIndex(int index) => state = index;

  Future<SeriesResponseModel> searchSeriesByTitle(WidgetRef ref) async {
    try {
      return await ref
          .watch(movieRepositoryProvider)
          .searchMCUSeriesByTitle(ctrl.text);
    } on SocketException catch (_) {
      showDialogFlash();
      rethrow;
    } catch (_) {
      showBottomFlash(content: someWrong);
      rethrow;
    }
  }


  Future<SeriesResponseModel> getSeriesDetailsById(String id) async {
    try {
      return await ref!
          .watch(movieRepositoryProvider)
          .getMCUSeriesDetailsById(id);
    } on SocketException catch (_) {
      showDialogFlash();
      rethrow;
    } catch (_) {
      showBottomFlash(content: someWrong);
      rethrow;
    }
  }

  Future<SeriesResponseModel> getAllSeries(WidgetRef ref) async {
    try {
      return await ref.watch(movieRepositoryProvider).getMCUSeries();
    } on SocketException catch (_) {
      showDialogFlash();
      rethrow;
    } catch (_) {
      showBottomFlash(content: someWrong);
      rethrow;
    }
  }

  Future<SeriesResponseModel> getAllSeriesSortByTitle(WidgetRef ref) async {
    try {
      return await ref.watch(movieRepositoryProvider).getMCUSeriesSortByTitle();
    } on SocketException catch (_) {
      showDialogFlash();
      rethrow;
    } catch (_) {
      showBottomFlash(content: someWrong);
      rethrow;
    }
  }

}
