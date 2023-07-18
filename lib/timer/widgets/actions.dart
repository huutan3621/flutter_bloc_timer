import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timer_bloc.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, state) => previous.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
                  ),
                ],
              TimeRunInProgress() => [
                  FloatingActionButton(
                      child: const Icon(Icons.pause),
                      onPressed: () =>
                          context.read<TimerBloc>().add(TimerPaused())),
                  FloatingActionButton(
                      child: const Icon(Icons.replay),
                      onPressed: () =>
                          context.read<TimerBloc>().add(TimerReset())),
                ],
              TimeRunPause() => [
                  FloatingActionButton(
                      child: const Icon(Icons.play_arrow),
                      onPressed: () =>
                          context.read<TimerBloc>().add(TimerResumed())),
                  FloatingActionButton(
                      child: const Icon(Icons.replay),
                      onPressed: () =>
                          context.read<TimerBloc>().add(TimerReset())),
                ],
              TimerRunComplete() => [
                  FloatingActionButton(
                      child: const Icon(Icons.replay),
                      onPressed: () =>
                          context.read<TimerBloc>().add(TimerReset())),
                ],
            }
          ],
        );
      },
    );
  }
}
