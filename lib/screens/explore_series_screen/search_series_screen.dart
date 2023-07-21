import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../controller/movie_remote_repository_controller.dart';
import '../../providers/providers.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/series_error_widget.dart';
import '../../widget/series_thumbs_widget.dart';
import '../series_detail_screen/series_detail_screen.dart';
import 'explore_series_screen.dart';

class SearchSeries extends StatelessWidget {
  const SearchSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final movieRepositoryCtrl =
          ref.watch(movieRemoteRepositoryController.notifier);
      final notifier = ref.watch(movieRemoteRepositoryController.notifier);
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(70, 70),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: CustomTextField(controller: movieRepositoryCtrl.ctrl),
            )),
        body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 12),
            child: movieRepositoryCtrl.ctrl.text.isEmpty
                ? Container()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButton('Busqueda por titulo',
                              () => notifier.setSelectedIndex(0), ref, 0),
                        ],
                      ),
                      const SizedBox(height: 8),
                       ref.watch(searchSeriesFutureProvider(ref)).when(
                              data: (data) => Expanded(
                                    child: GestureDetector(
                                      onHorizontalDragUpdate: (details) =>
                                          notifier.setSelectedIndex(1),
                                      child: MasonryGridView.count(
                                          physics:
                                          const ScrollPhysics(),
                                          itemCount: data.data.results.length,
                                          crossAxisCount: 2,
                                          itemBuilder: (ctx, i) =>
                                              SeriesThumbsWidget(
                                                image:  '${data.data.results[i].thumbnail.path}.${data.data.results[i].thumbnail.extension}',
                                                child: SeriesDetailView(
                                                    id: data.data.results[i].id),
                                              )),
                                    ),
                                  ),
                              error: (e, t) {

                               return   Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 150),
                                      SeriesErrorWidget(
                                          onTap: () => ref.refresh(
                                              searchSeriesFutureProvider(
                                                  ref))),
                                    ],
                                  );},
                              loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  )),

                      const SizedBox(height: 20),
                    ],
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.search, color: Colors.white),
        ),
      );
    });
  }
}
