class Data<T> {
  T? data;
  String? error;
  Data({this.data, this.error});
}

mixin Mixin2 {}
mixin Mixin1 {}
mixin Mixin3 {
  String? cusomerName;
  void callFnc() {}
}

class A with Mixin1, Mixin2, Mixin3 {
  void accessingVariablesFnc() {
    print(cusomerName);
    callFnc();
  }
}
