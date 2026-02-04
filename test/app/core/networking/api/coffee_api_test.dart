import 'package:dio/dio.dart';
import 'package:flutter_template/app/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group(CoffeeApi, () {
    late RestClient restClient;
    late CoffeeApi coffeeApi;

    setUp(() {
      initHydratedStorage();
      restClient = MockRestClient();
      coffeeApi = CoffeeApi(restClient);
    });

    test(
      'getCoffeeImageUrl calls restClient.get with correct endpoint '
      'in $CoffeeApi',
      () async {
        when(() => restClient.get<dynamic>(any())).thenAnswer(
          (_) async => Response(requestOptions: RequestOptions()),
        );

        await coffeeApi.getCoffeeImageUrl();

        verify(
          () => restClient.get<dynamic>(Endpoints.coffee.random),
        ).called(1);
      },
    );
  });
}
