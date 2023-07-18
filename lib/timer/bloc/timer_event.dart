part of 'timer_bloc.dart';

sealed class TimerEvent {
  TimerEvent();
}

final class TimerStarted extends TimerEvent {
  final int duration;
  TimerStarted({required this.duration});
}

final class TimerPaused extends TimerEvent {
  TimerPaused();
}

final class TimerResumed extends TimerEvent {
  TimerResumed();
}

final class TimerReset extends TimerEvent {
  TimerReset();
}

class _TimerTicket extends TimerEvent {
  final int duration;
  _TimerTicket({required this.duration});
}
