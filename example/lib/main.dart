import 'package:example/samples/navigation/samples_router.dart';
import 'package:flutter/material.dart';
import 'package:nuvigator/nuvigator.dart';

import 'samples/modules/sample_one/navigation/sample_one_router.dart';

void main() => runApp(MyApp());

class TestObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didPush $route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didPop $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didRemove $route');
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('didReplace $oldRoute to $newRoute');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nubank',
      builder: Nuvigator(
//        debug: true,
        screenType: cupertinoDialogScreenType,
        inheritableObservers: [
          () => TestObserver(),
        ],
        router: SamplesRouter(),
        initialRoute: SamplesRoutes.home,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router.of<SamplesRouter>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('nuvigator Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Hero(
            child: FlutterLogo(),
            tag: 'HERO',
          ),
          FlatButton(
              child: const Text('Go to sample one with flutter navigation'),
              onPressed: () async {
                final result = await router.sampleOneRouter
                    .toScreenOne(testId: 'From Home');
                print('ScreenOneResult: $result');
              }),
          FlatButton(
            child: const Text('Go to sample one with deepLink'),
            onPressed: () async {
              final result = await router
                  .openDeepLink<String>(Uri.parse(screenOneDeepLink));
              print('ScreenOneDeepLinkResult: $result}');
            },
          ),
          FlatButton(
            child: const Text('Go to sample two with flow'),
            onPressed: () async {
              final result = await router.toSecond(testId: 'From Home');
              print('SecondRouteResult: $result');
            },
          ),
        ],
      ),
    );
  }
}
