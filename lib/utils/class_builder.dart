// import 'package:password_manager/pages/Dashboard/dashboard.dart';
import 'package:password_manager/pages/SignIn/sign_in.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    // register<SignIn>(() => SignIn());
    // register<Dashboard>(() => Dashboard());
    // register<SettingsPage>(() => SettingsPage());
  }

  static dynamic fromString(String type) {
    if (_constructors[type] != null) return _constructors[type]!();
  }
}
