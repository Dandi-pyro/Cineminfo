import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/model/cast/cast_model.dart';
import 'package:cineminfo/screen/actor/actor_popular_view_model.dart';
import 'package:cineminfo/screen/actor/actor_trending_day_view_model.dart';
import 'package:cineminfo/screen/actor/actor_trending_week_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActorDayWidget extends StatefulWidget {
  const ActorDayWidget({Key? key}) : super(key: key);

  @override
  State<ActorDayWidget> createState() => _ActorDayWidgetState();
}

class _ActorDayWidgetState extends State<ActorDayWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<ActorDayViewModel>(context, listen: false)
        .getTrendingDayActor();
  }

  @override
  Widget build(BuildContext context) {
    final actorDayProvider = Provider.of<ActorDayViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(actorDayProvider),
      ],
    );
  }

  Widget body(ActorDayViewModel viewModel) {
    final isLoading = viewModel.state == ActorDayViewState.loading;
    final isError = viewModel.state == ActorDayViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _listActors(viewModel);
  }

  Widget _listActors(ActorDayViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Container(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Person person = viewModel.actorDay[index];
            return Column(
              children: [
                person.profilePath == null
                    ? const Image(
                        image: AssetImage('assets/images/user.png'),
                        height: 100,
                        width: 100,
                      )
                    : ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w200${person.profilePath}',
                          imageBuilder: (context, imageBuilder) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  image: DecorationImage(
                                    image: imageBuilder,
                                    fit: BoxFit.cover,
                                  )),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 100,
                            height: 100,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      person.name!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: viewModel.actorDay.length,
          separatorBuilder: (BuildContext context, int index) =>
              const VerticalDivider(
            color: Colors.transparent,
            width: 12,
          ),
        ),
      ),
    );
  }
}

class ActorWeekWidget extends StatefulWidget {
  const ActorWeekWidget({Key? key}) : super(key: key);

  @override
  State<ActorWeekWidget> createState() => _ActorWeekWidgetState();
}

class _ActorWeekWidgetState extends State<ActorWeekWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<ActorWeekViewModel>(context, listen: false)
        .getTrendingWeekActor();
  }

  @override
  Widget build(BuildContext context) {
    final actorWeekProvider = Provider.of<ActorWeekViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(actorWeekProvider),
      ],
    );
  }

  Widget body(ActorWeekViewModel viewModel) {
    final isLoading = viewModel.state == ActorWeekViewState.loading;
    final isError = viewModel.state == ActorWeekViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _listActors(viewModel);
  }

  Widget _listActors(ActorWeekViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Container(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Person person = viewModel.actorWeek[index];
            return Column(
              children: [
                person.profilePath == null
                    ? const Image(
                        image: AssetImage('assets/images/user.png'),
                        height: 100,
                        width: 100,
                      )
                    : ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w200${person.profilePath}',
                          imageBuilder: (context, imageBuilder) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  image: DecorationImage(
                                    image: imageBuilder,
                                    fit: BoxFit.cover,
                                  )),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 100,
                            height: 100,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      person.name!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: viewModel.actorWeek.length,
          separatorBuilder: (BuildContext context, int index) =>
              const VerticalDivider(
            color: Colors.transparent,
            width: 12,
          ),
        ),
      ),
    );
  }
}

class ActorPopularWidget extends StatefulWidget {
  const ActorPopularWidget({Key? key}) : super(key: key);

  @override
  State<ActorPopularWidget> createState() => _ActorPopularWidgetState();
}

class _ActorPopularWidgetState extends State<ActorPopularWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<ActorPopularViewModel>(context, listen: false)
        .getPopularActor();
  }

  @override
  Widget build(BuildContext context) {
    final actorPopularProvider = Provider.of<ActorPopularViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(actorPopularProvider),
      ],
    );
  }

  Widget body(ActorPopularViewModel viewModel) {
    final isLoading = viewModel.state == ActorPopularViewState.loading;
    final isError = viewModel.state == ActorPopularViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _listActors(viewModel);
  }

  Widget _listActors(ActorPopularViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Container(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Person person = viewModel.actorPopular[index];
            return Column(
              children: [
                person.profilePath == null
                    ? const Image(
                        image: AssetImage('assets/images/user.png'),
                        height: 100,
                        width: 100,
                      )
                    : ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w200${person.profilePath}',
                          imageBuilder: (context, imageBuilder) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  image: DecorationImage(
                                    image: imageBuilder,
                                    fit: BoxFit.cover,
                                  )),
                            );
                          },
                          placeholder: (context, url) => Container(
                            width: 100,
                            height: 100,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: 100,
                  child: Center(
                    child: Text(
                      person.name!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: viewModel.actorPopular.length,
          separatorBuilder: (BuildContext context, int index) =>
              const VerticalDivider(
            color: Colors.transparent,
            width: 12,
          ),
        ),
      ),
    );
  }
}
