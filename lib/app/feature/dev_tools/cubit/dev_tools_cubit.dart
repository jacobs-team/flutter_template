import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'dev_tools_cubit.g.dart';
part 'dev_tools_cubit.freezed.dart';

@singleton
class DevToolsCubit extends HydratedCubit<DevToolsState> {
  DevToolsCubit() : super(const DevToolsState());

  void toggleDebugApi() => emit(state.copyWith(isApiDebug: !state.isApiDebug));
  void toggleDarkMode() => emit(state.copyWith(isDarkMode: !state.isDarkMode));

  @override
  DevToolsState fromJson(Map<String, dynamic> json) =>
      DevToolsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(DevToolsState state) => state.toJson();
}

@freezed
abstract class DevToolsState with _$DevToolsState {
  const factory DevToolsState({
    @Default(true) bool isApiDebug,
    @Default(false) bool isDarkMode,
  }) = _DevToolsState;

  const DevToolsState._();

  factory DevToolsState.fromJson(Map<String, dynamic> json) =>
      _$DevToolsStateFromJson(json);
}
