import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/bloc/login/login_cubit.dart';
import 'package:flutter_template/ui/components/button.dart';
import 'package:flutter_template/ui/screens/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'mocks/context_mock.dart';
import '../bloc/mocks/login_bloc_mock.dart';

void main() {
  final LoginCubit loginCubit = MockLoginCubit();

  testWidgets('Login Widget', (WidgetTester tester) async {
    // Define initial cubit state
    when(() => loginCubit.state).thenAnswer((invocation) => LoginInitial());

    // Render widget with mocked Login cubit
    await tester.pumpWidget(BlocProvider(
      create: (_) => loginCubit,
      child: const ContextMock(
        child: LoginWidget(),
      ),
    ));

    // Should display email widgets labels, text fields and buttons
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(Button), findsOneWidget);

    // Tap the login button and trigger a frame.
    await tester.tap(find.byType(Button));
    await tester.pumpAndSettle();

    // The widget state should change, displaying an error
    // on the screen. This is exclusively a Widget (UI) test
    // and NOT a bloc test. Those ones should be tested separately.
    expect(find.text("Please write an email and a password"), findsOneWidget);
  });
}
