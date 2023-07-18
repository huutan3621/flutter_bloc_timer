import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_timer/ticket.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubcription;
  //handler the event
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<_TimerTicket>(_onTicked);
  }

  //override the close method to cancel _ticketSubcription when the TimerBloc is closed
  @override
  Future<void> close() {
    _tickerSubcription?.cancel();
    return super.close();
  }

  //if a timer blco receive an event, it pushes a TimerRunInProgress state with the start duration
  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimeRunInProgress(event.duration));

    //already opned tickedSubcription, cancel it to deallocate the memory
    _tickerSubcription?.cancel();

    //listen to the _ticker.tick stream, everytick add the timer with the remain duration
    _tickerSubcription = _ticker.tick(ticks: event.duration).listen(
          (duration) => add(
            _TimerTicket(duration: duration),
          ),
        );
  }

  //if state is TimeRunInProgress, pause the tickerSubcription, push the TimeRunPause with the rest duration
  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimeRunInProgress) {
      _tickerSubcription?.pause();
      emit(TimeRunPause(state.duration));
    }
  }

  //similar to _onPaused()
  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimeRunPause) {
      _tickerSubcription?.resume();
      emit(TimeRunInProgress(state.duration));
    }
  }

  //timẻbloc receive a TimerReset event, cancel tickerSubcription, push TimerInitial with the orginal duration
  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubcription?.cancel();
    emit(const TimerInitial(_duration));
  }

  //when _TimerTicket is received, the tick > 0, update TimeRunInProgress, else the duration is 0 TimerRunComplete
  void _onTicked(_TimerTicket event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimeRunInProgress(event.duration)
        : const TimerRunComplete());
  }
}
