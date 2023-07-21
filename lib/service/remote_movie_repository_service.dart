import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../api/apikey.dart';
import '../api/api.dart';
import '../model/series_model.dart';

final movieRepositoryProvider =
    Provider((ref) => RemoteMovieRepositoryServiceImpl(Client()));

abstract class RemoteMovieRepositoryService {
  Future searchMCUSeriesByTitle(String name);
  Future getMCUSeries();
  Future getMCUSeriesDetailsById(String id);
}

class RemoteMovieRepositoryServiceImpl implements RemoteMovieRepositoryService {
  final Client client;
  RemoteMovieRepositoryServiceImpl(this.client);
  
  @override
  Future<SeriesResponseModel> searchMCUSeriesByTitle(String name) async {
    final response = await client.get(Uri.parse(
        "$apiBaseUrl?titleStartsWith=$name&$apikey"));
    return seriesResponseModelFromMap(response.body);
  }

  @override
  Future<SeriesResponseModel> getMCUSeries() async {
    final response = await client.get( Uri.parse("$apiBaseUrl?&orderBy=title&$apikey"));
    return seriesResponseModelFromMap(response.body);
  }

  @override
  Future<SeriesResponseModel> getMCUSeriesDetailsById(String id) async {
    final response = await client.get(Uri.parse("$apiBaseUrl/$id?$apikey"));
    return seriesResponseModelFromMap(response.body);
  }
  @override
  Future<SeriesResponseModel> getMCUSeriesSortByTitle() async {
    final response = await client.get(Uri.parse(
        "$apiBaseUrl?&orderBy=-title&$apikey"));
    return seriesResponseModelFromMap(response.body);
  }

}
