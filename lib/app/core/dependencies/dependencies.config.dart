// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_template/app/core/bloc/auth_cubit.dart' as _i598;
import 'package:flutter_template/app/core/bloc/connectivity_cubit.dart'
    as _i566;
import 'package:flutter_template/app/core/core.dart' as _i483;
import 'package:flutter_template/app/core/dependencies/modules/hydrated_bloc_module.dart'
    as _i569;
import 'package:flutter_template/app/core/networking/api.dart' as _i92;
import 'package:flutter_template/app/core/networking/repository/coffee_repository.dart'
    as _i700;
import 'package:flutter_template/app/core/networking/rest_client.dart' as _i922;
import 'package:flutter_template/app/core/service/file_cache_service.dart'
    as _i96;
import 'package:flutter_template/app/feature/coffee/bloc/coffee_bloc.dart'
    as _i720;
import 'package:flutter_template/app/navigation/app_router.dart' as _i693;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hydrated_bloc/hydrated_bloc.dart' as _i67;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hydratedBlocModule = _$HydratedBlocModule();
    await gh.factoryAsync<_i67.HydratedStorage>(
      () => hydratedBlocModule.init(),
      preResolve: true,
    );
    gh.singleton<_i598.AuthCubit>(() => _i598.AuthCubit());
    gh.singleton<_i566.ConnectivityCubit>(() => _i566.ConnectivityCubit());
    gh.singleton<_i96.FileCacheService>(() => _i96.FileCacheService());
    gh.singleton<_i693.AppRouter>(() => _i693.AppRouter());
    gh.singleton<_i922.RestClient>(
      () => _i922.RestClient(gh<_i483.AuthCubit>()),
    );
    gh.singleton<_i92.API>(() => _i92.API(gh<_i483.RestClient>()));
    gh.lazySingleton<_i700.CoffeeRepository>(
      () => _i700.CoffeeRepository(gh<_i483.API>()),
    );
    gh.singleton<_i720.CoffeeBloc>(
      () => _i720.CoffeeBloc(
        gh<_i700.CoffeeRepository>(),
        gh<_i96.FileCacheService>(),
      ),
    );
    return this;
  }
}

class _$HydratedBlocModule extends _i569.HydratedBlocModule {}
