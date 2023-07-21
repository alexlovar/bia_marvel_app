import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marvel_app/controller/movie_remote_repository_controller.dart';
import 'package:marvel_app/screens/explore_series_screen/search_series_screen.dart';
import 'package:marvel_app/screens/series_detail_screen/series_detail_screen.dart';
import 'package:marvel_app/widget/series_error_widget.dart';
import 'package:marvel_app/widget/series_thumbs_widget.dart';
import '../../common/constants.dart';
import '../../providers/providers.dart';
import '../../widget/series_list_widget.dart';

class ExploreSeriesView extends StatelessWidget {
   const ExploreSeriesView({super.key});


  @override
  Widget build(BuildContext context) {
    final listView = StateProvider<bool>((ref){return false;});
    final sortBy = StateProvider<bool>((ref){return false;});

    return Consumer(builder: (context, ref, _) {
      final notifier = ref.watch(movieRemoteRepositoryController.notifier);
      final  listViewSelector = ref.watch(listView);
      final  sortByTitle = ref.watch(sortBy);

      return Scaffold(
        body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        appTitle,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      IconButton(
                            onPressed: () { ref.watch(listView.notifier).state = !listViewSelector; } ,
                            icon:  Icon(listViewSelector ?  Icons.grid_view : Icons.list_outlined)) ,
                      IconButton(
                          onPressed: () { ref.watch(sortBy.notifier).state = !sortByTitle; } ,
                          icon:  const Icon(Icons.sort_by_alpha_outlined)) ,
                      IconButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => const SearchSeries())),
                          icon: const Icon(Icons.search))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton(
                          'Series!', () => notifier.setSelectedIndex(0), ref, 0),
                    ],
                  ),
                  const SizedBox(height: 20),
                   ref.watch(
                       sortByTitle ?
                       allSeriesSortByTitleFutureProvider(ref):
                       allSeriesFutureProvider(ref))
                       .when(
                          data: (data) => GestureDetector(
                                onHorizontalDragUpdate: (details) =>
                                    notifier.setSelectedIndex(1),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child:
                                  listViewSelector ?
                                  ListView.builder(
                                      itemCount: data.data.results.length,
                                      itemBuilder: (context, i) {
                                        return
                                          SeriesListWidget(
                                            title: data.data.results[i].title,
                                            startYear: data.data.results[i].startYear.toString(),
                                            endYear: data.data.results[i].endYear.toString(),
                                            child: SeriesDetailView(
                                                id: data.data.results[i].id),
                                          );})
                                      :
                                  MasonryGridView.count(
                                      physics:
                                          const ScrollPhysics(),
                                      itemCount: data.data.results.length,
                                      crossAxisCount: 2,
                                      itemBuilder: (ctx, i) =>
                                      SeriesThumbsWidget(
                                            image: '${data.data.results[i].thumbnail.path}.${data.data.results[i].thumbnail.extension}',
                                            child: SeriesDetailView(
                                                id: data.data.results[i].id),
                                          ),
                                  ) ,
                                ),
                              ),
                          error: (e, t) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 150),
                                  SeriesErrorWidget(
                                      onTap: () => ref.refresh(
                                          allSeriesFutureProvider(ref))),
                                ],
                              ),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ))

                ],
              ),
            )),
      );
    });
  }
}

Widget buildButton(String text, VoidCallback onTap, WidgetRef ref, int i) {
  final index = ref.watch(movieRemoteRepositoryController);
  return Expanded(
    child: AnimatedContainer(
      height: 50,
      width: 155,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 3, color: index == i ? Colors.red : Colors.grey))),
      duration: const Duration(milliseconds: 650),
      child: MaterialButton(
        onPressed: onTap,
        padding: const EdgeInsets.all(0),
        child: Text(text),
      ),
    ),
  );
}
