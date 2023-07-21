import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marvel_app/controller/movie_remote_repository_controller.dart';
import 'package:marvel_app/screens/series_detail_screen/series_detail_screen.dart';
import 'package:marvel_app/widget/custom_textfield.dart';
import 'package:marvel_app/widget/series_error_widget.dart';
import '../../providers/providers.dart';

class SeriesSearchView extends StatelessWidget {
  const SeriesSearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final movieRepositoryCtrl =
          ref.watch(movieRemoteRepositoryController.notifier);
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(60, 60),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.keyboard_backspace, size: 32)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: CustomTextField(
                    controller: movieRepositoryCtrl.ctrl,
                  )),
                ],
              ),
            )),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child:  ref.watch(searchSeriesFutureProvider(ref)).when(
                  data: (data) =>  Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.builder(
                              itemCount: data.data.results.length,
                              itemBuilder: (ctx, i) => ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  SeriesDetailView(
                                                      id: data.data
                                                          .results[i].id)));
                                    },
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        alignment: Alignment.topCenter,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child: SpinKitDoubleBounce(
                                                    color: Colors.grey)),
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                        imageUrl:  '${data.data.results[i].thumbnail.path}.${data.data.results[i].thumbnail.extension}',
                                        errorWidget: ((context, url, error) =>
                                            Container()),
                                      ),
                                    ),
                                    title: Text(data.data.results[i].title),
                                    trailing:
                                        const Icon(Icons.keyboard_arrow_right),
                                  )),
                        ),
                  error: (e, t) => Center(
                        child: SeriesErrorWidget(
                            onTap: () => ref
                                .refresh(searchSeriesFutureProvider(ref))),
                      ),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),),
        ),
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
