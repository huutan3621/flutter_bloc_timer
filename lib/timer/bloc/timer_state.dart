part of 'timer_bloc.dart';

sealed class TimerState {
  final int duration;
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration}';
}

final class TimeRunPause extends TimerState {
  TimeRunPause(super.duration);

  @override
  String toString() => 'TimeRunPause { duration: $duration}';
}

final class TimeRunInProgress extends TimerState {
  TimeRunInProgress(super.duration);

  @override
  String toString() => 'TimeRunInProgess { duration: $duration}';
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
