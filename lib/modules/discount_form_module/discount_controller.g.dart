// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DiscountController on DiscountControllerBase, Store {
  late final _$enumSelectedAtom =
      Atom(name: 'DiscountControllerBase.enumSelected', context: context);

  @override
  TypeDiscountEnum? get enumSelected {
    _$enumSelectedAtom.reportRead();
    return super.enumSelected;
  }

  @override
  set enumSelected(TypeDiscountEnum? value) {
    _$enumSelectedAtom.reportWrite(value, super.enumSelected, () {
      super.enumSelected = value;
    });
  }

  @override
  String toString() {
    return '''
enumSelected: ${enumSelected}
    ''';
  }
}
