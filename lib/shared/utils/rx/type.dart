import 'package:flutter/foundation.dart' show ValueNotifier;

/// Rx not null
class Rx<T> extends ValueNotifier<T> {
  Rx(super.value);
}

class RxBool extends Rx<bool> {
  RxBool(super.value);
}

class RxInt extends Rx<int> {
  RxInt(super.value);
}

class RxDouble extends Rx<double> {
  RxDouble(super.value);
}

/// Rx nullable
class Rxn<T> extends ValueNotifier<T?> {
  Rxn(super.value);
}

class RxnBool extends Rxn<bool?> {
  RxnBool([super.value]);
}

class RxnInt extends Rxn<int?> {
  RxnInt([super.value]);
}

class RxnDouble extends Rxn<double?> {
  RxnDouble([super.value]);
}
