import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marvel_app/controller/movie_remote_repository_controller.dart';
import 'package:marvel_app/providers/providers.dart';
import 'package:marvel_app/widget/series_error_widget.dart';
import 'package:any_link_preview/any_link_preview.dart';

import '../../common/constants.dart';

class SeriesDetailView extends StatelessWidget {
  final int id;
  const SeriesDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      ref.watch(movieRemoteRepositoryController.notifier).ref = ref;

      return Scaffold(
          body: ref.watch(seriesByIdFutureProvider(id.toString())).when(
              data: (data) => Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.8),
                          Colors.black,
                          Colors.black,
                          Colors.black,
                        ])),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            alignment: Alignment.topCenter,
                            placeholder: (context, url) => const Center(
                                child: SpinKitDoubleBounce(color: Colors.grey)),
                            fit: BoxFit.cover,
                            imageUrl:  '${data.data.results[0].thumbnail.path}.${data.data.results[0].thumbnail.extension}',
                            errorWidget: ((context, url, error) => Container()),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.data.results[0].title ,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      data.data.results[0].description ?? notAvailable,
                                      style: const TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        DateFormat('EEEE, MMMM d, yyyy').format(DateTime.parse(data.data.results[0].modified)) ?? '',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      webSite,
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(height: 8),
                                    AnyLinkPreview(
                                      link: data.data.results[0].urls[0].url,
                                      displayDirection: UIDirection.uiDirectionHorizontal,
                                      cache: Duration(hours: 1),
                                      backgroundColor: Colors.grey[300],
                                      errorWidget: Container(
                                        color: Colors.grey[300],
                                        child: Text('Oops!'),
                                      ),
                                      //errorImage: _errorImage,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
              error: (e, t) => Center(
                    child: SeriesErrorWidget(
                        onTap: () => ref
                            .refresh(seriesByIdFutureProvider(id.toString()))),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  )));
    });
  }


}
