enum TypeDiscountEnum {
  percentual(stringValue: "Percentual",stringEnum: "percentual"),
  precodeprecopor(stringValue: "Preço de Preço por",stringEnum: "precodeprecopor"),
  levemaispaguemenos(stringValue: "Leve mais Pague menos",stringEnum: "levemaispaguemenos");

  const TypeDiscountEnum({required this.stringValue, required this.stringEnum});
  final String stringValue;
  final String stringEnum;
}
