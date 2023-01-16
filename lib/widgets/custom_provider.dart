import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CProvider<T extends BlocBase> extends StatelessWidget {
  final T Function(BuildContext) create;
  final Widget Function(BuildContext) builder;
  const CProvider({
    Key? key,
    required this.create,
    required this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: create,
      child: _Provider<T>(builder),
    );
  }
}

class _Provider<T> extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  const _Provider(this.builder);
  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
