import 'package:cineminfo/screen/actor/actor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({Key? key}) : super(key: key);

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cineminfo'),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SearchMovieScreen()));
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'trending person of the day'.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                ActorDayWidget(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'trending person of the week'.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                ActorWeekWidget(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'popular actors'.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                ActorPopularWidget(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
