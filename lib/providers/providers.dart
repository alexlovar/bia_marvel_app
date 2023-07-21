import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/movie_remote_repository_controller.dart';

// Home view provider

final allSeriesFutureProvider = FutureProvider.family.autoDispose(
        (ref, WidgetRef n) =>
        ref.watch(movieRemoteRepositoryController.notifier).getAllSeries(n));

final allSeriesSortByTitleFutureProvider = FutureProvider.family.autoDispose(
        (ref, WidgetRef n) =>
        ref.watch(movieRemoteRepositoryController.notifier).getAllSeriesSortByTitle(n));

//detail providers
final seriesByIdFutureProvider = FutureProvider.family.autoDispose(
    (ref, String id) => ref
        .watch(movieRemoteRepositoryController.notifier)
        .getSeriesDetailsById(id));


//search view providers
final searchSeriesFutureProvider = FutureProvider.family.autoDispose(
    (ref, WidgetRef n) => ref
        .watch(movieRemoteRepositoryController.notifier)
        .searchSeriesByTitle(n));


