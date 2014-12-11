part of dslink.api;

class Value {
  final DateTime timestamp;
  final ValueType type;
  final dynamic _value;
  final String status;
  
  Value(this.timestamp, this.type, dynamic value, {this.status: "ok"}) : _value = value;
  
  @override
  String toString() {
    if (_value == null) {
      return "null";
    } else {
      return _value.toString();
    }
  }
  
  int toInteger() {
    if (_value is! int) {
      throw new Exception("NOT THE RIGHT TYPE!");
    }
    return _value;
  }
  
  double toDouble() {
    if (_value.runtimeType != double) {
      throw new Exception("NOT THE RIGHT TYPE!");
    }
    return _value;
  }
  
  bool toBoolean() {
    if (_value is! bool) {
      throw new Exception("NOT THE RIGHT TYPE!");
    }
    return _value;
  }
  
  dynamic toPrimitive() {
    return _value == null ? null : ([
      int,
      double,
      bool
    ].contains(_value.runtimeType) ? _value : _value.toString());
  }
  
  static Value of(input) {
    if (input is String) {
      return new Value(new DateTime.now(), ValueType.STRING, input);
    } else if (input is int) {
      return new Value(new DateTime.now(), ValueType.INTEGER, input);
    } else if (input.runtimeType == double) {
      return new Value(new DateTime.now(), ValueType.DOUBLE, input);
    } else if (input is bool) {
      return new Value(new DateTime.now(), ValueType.BOOLEAN, input);
    } else if (input == null) {
      return new Value(new DateTime.now(), ValueType.NULL, input);
    } else {
      throw new Exception("Unsupported Type: ${input.runtimeType}");
    }
  }
}

class ValueType {
  static const ValueType STRING = const ValueType("string");
  static const ValueType INTEGER = const ValueType("integer");
  static const ValueType DOUBLE = const ValueType("double");
  static const ValueType BOOLEAN = const ValueType("bool", enumValues: const ["true", "false"]);
  static const ValueType NULL = const ValueType("null");
  
  const ValueType(this.name, {this.enumValues});
  
  final String name;
  final List<String> enumValues;
}