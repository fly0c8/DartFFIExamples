import 'dart:ffi' as ffi;

// ffi signature of the hello world c function
typedef hello_world_func = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();

// ffi sig
typedef example_foo = ffi.Int32 Function(
  ffi.Int32 bar, ffi.Pointer<ffi.NativeFunction<example_callback>>);
// dart sig
typedef ExampleFoo = int Function(
  int bar,
  ffi.Pointer<ffi.NativeFunction<example_callback>>);

typedef example_callback = ffi.Int32 Function(ffi.Pointer<ffi.Void>, ffi.Int32);


int callback(ffi.Pointer<ffi.Void> ptr, int i) {
  print("in callback i=$i");
  return i+1;
}

main() {
	final dylib = ffi.DynamicLibrary.open("./libhello.so");
	final HelloWorld hello =
    dylib.lookup<ffi.NativeFunction<hello_world_func>>('hello_world').asFunction();
  final ExampleFoo nativeFoo =
    dylib.lookup<ffi.NativeFunction<example_foo>>("foo").asFunction();

  hello();
  const except = -1;
  nativeFoo(123, ffi.Pointer.fromFunction<example_callback>(callback,except));



}
