import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/feature/feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/hydrated_storage_helper.dart';
import '../../helpers/pump_app.dart';

void main() {
  group(CoffeeApp, () {
    late final DevToolsCubit devToolsCubit;

    setUp(() {
      initHydratedStorage();
      devToolsCubit = MockDevToolsCubit();
      when(() => devToolsCubit.state).thenReturn(const DevToolsState());
    });

    testWidgets('renders $CoffeeApp', (tester) async {
      await tester.pumpPumpPumpItUP(
        deps: [devToolsCubit],
        const CoffeeApp(),
      );
      expect(find.byType(CoffeeApp), findsOneWidget);
    });
  });
}
