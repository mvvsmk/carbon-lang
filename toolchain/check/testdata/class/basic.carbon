// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

class Class {
  fn F(n: i32) -> i32 {
    return n;
  }

  fn G(n: i32) -> i32;

  var k: i32;
}

fn Class.G(n: i32) -> i32 {
  return n;
}

fn Run() -> i32 {
  return Class.F(4);
}

// CHECK:STDOUT: --- basic.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.loc15: type = struct_type {.k: i32}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.Class = %Class.decl, .Run = %Run}
// CHECK:STDOUT:   %Class.decl = class_decl @Class, ()
// CHECK:STDOUT:   %Class: type = class_type @Class
// CHECK:STDOUT:   %G: <function> = fn_decl @G
// CHECK:STDOUT:   %Run: <function> = fn_decl @Run
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Class {
// CHECK:STDOUT:   %F: <function> = fn_decl @F
// CHECK:STDOUT:   %G: <function> = fn_decl @G
// CHECK:STDOUT:   %.loc14_8.1: type = unbound_element_type Class, i32
// CHECK:STDOUT:   %.loc14_8.2: <unbound element of class Class> = field_decl k, element0
// CHECK:STDOUT:   %k: <unbound element of class Class> = bind_name k, %.loc14_8.2
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .F = %F
// CHECK:STDOUT:   .G = %G
// CHECK:STDOUT:   .k = %k
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%n: i32) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %n.ref: i32 = name_ref n, %n
// CHECK:STDOUT:   return %n.ref
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G(%n: i32) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %n.ref: i32 = name_ref n, %n
// CHECK:STDOUT:   return %n.ref
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Run() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Class.ref: type = name_ref Class, file.%Class
// CHECK:STDOUT:   %F.ref: <function> = name_ref F, @Class.%F
// CHECK:STDOUT:   %.loc22_18: i32 = int_literal 4
// CHECK:STDOUT:   %.loc22_17: init i32 = call %F.ref(%.loc22_18)
// CHECK:STDOUT:   %.loc22_20.1: i32 = value_of_initializer %.loc22_17
// CHECK:STDOUT:   %.loc22_20.2: i32 = converted %.loc22_17, %.loc22_20.1
// CHECK:STDOUT:   return %.loc22_20.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
