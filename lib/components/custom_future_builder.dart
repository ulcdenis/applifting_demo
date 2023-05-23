// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T) builder;
  // final Widget Function(Object?)? onError;
  // final Widget? onLoading;
  // final bool withConnectionState;

  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
    // this.onError,
    // this.onLoading,
    // this.withConnectionState = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //TODO: on error
        }

        if (snapshot.hasData) {
          return builder(snapshot.data as T);
        }

        return const Padding(padding: EdgeInsets.all(10.0), child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
