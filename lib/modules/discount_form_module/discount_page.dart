import 'package:cresce_cuts/core/const/icons_svg.dart';
import 'package:cresce_cuts/core/enums/action_enum.dart';
import 'package:cresce_cuts/core/enums/type_discount_enum.dart';
import 'package:cresce_cuts/core/models/args_model.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/core/models/products_model.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:image_picker/image_picker.dart';

class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  final _formKey = GlobalKey<FormState>();

  late Future<List<ProductsModel>> data;
  ProductsModel? productsModelSelected;
  TypeDiscountEnum? typeDiscountEnum;
  TextEditingController descripTionController = TextEditingController();
  TextEditingController leveController = TextEditingController();
  TextEditingController pagueController = TextEditingController();
  TextEditingController precoDeController = TextEditingController();
  TextEditingController precoPorController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController percentualController = TextEditingController();
  TextEditingController dateActivateController = TextEditingController();
  TextEditingController dateInactivateController = TextEditingController();

  final controller = Modular.get<DiscountController>();
  final args = (Modular.args.data as ArgsModel);
  @override
  void initState() {
    super.initState();
    data = controller.getAllProducts().then((v) async {
      initPreviousValues(v);

      return v;
    });
  }

  @override
  void dispose() {
    descripTionController.dispose();
    leveController.dispose();
    pagueController.dispose();
    precoDeController.dispose();
    precoPorController.dispose();
    priceController.dispose();
    percentualController.dispose();
    dateActivateController.dispose();
    dateInactivateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Modular.to.navigate(args.actionEnum.route,
            arguments: args.actionEnum == ActionEnum.edit
                ? args.discountsModel!.id
                : null);
      },
      child: Material(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: FutureBuilder(
              future: data,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                return Scaffold(
                    bottomNavigationBar: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 36, left: 16, right: 16),
                      child: FilledButton(
                        onPressed: () async {
                          await saveCallback();
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 16)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF007FBA)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ))),
                        child: Text(
                          "Salvar",
                          style: GoogleFonts.rubik(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    appBar: AppBar(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: InkWell(
                          child: SvgPicture.string(
                            arrow,
                          ),
                          onTap: () {
                            Modular.to.navigate(args.actionEnum.route,
                                arguments: args.actionEnum == ActionEnum.edit
                                    ? args.discountsModel!.id
                                    : null);
                          },
                        ),
                      ),
                      centerTitle: true,
                      title: Text("Cadastro desconto",
                          style: GoogleFonts.rubik(
                            fontSize: 16,
                            color: Color(0xFF403E43),
                            fontWeight: FontWeight.w700,
                          )),
                      surfaceTintColor: Colors.white,
                      elevation: 1,
                      shadowColor: Color(0xFF007FBA),
                    ),
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 36, left: 16, right: 16),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 32,
                                ),
                                Text("Nome do desconto",
                                    style: GoogleFonts.rubik(
                                      fontSize: 14,
                                      color: const Color(0xFF565656),
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                DropdownButtonFormField<ProductsModel>(
                                  value: productsModelSelected,
                                  validator: (value) =>
                                      value == null ? "" : null,
                                  isExpanded: true,
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<ProductsModel>>(
                                          (ProductsModel product) {
                                    return DropdownMenuItem(
                                      value: product,
                                      child: Text(product.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.rubik(
                                            fontSize: 14,
                                            color: const Color(0xFF565656),
                                            fontWeight: FontWeight.w400,
                                          )),
                                    );
                                  }).toList(),
                                  onChanged: (ProductsModel? product) {
                                    productsModelSelected = product;
                                    if (product != null) {
                                      descripTionController.text =
                                          product.description!;
                                      precoDeController.text =
                                          product.price!.toString();
                                      priceController.text =
                                          product.price!.toString();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text("Descrição",
                                    style: GoogleFonts.rubik(
                                      fontSize: 14,
                                      color: const Color(0xFF565656),
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? ""
                                          : null,
                                  controller: descripTionController,
                                  maxLines: 5,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text("Tipo do desconto",
                                    style: GoogleFonts.rubik(
                                      fontSize: 14,
                                      color: const Color(0xFF565656),
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                DropdownButtonFormField<TypeDiscountEnum>(
                                  value: args.discountsModel?.type,
                                  validator: (value) =>
                                      value == null ? "" : null,
                                  isExpanded: true,
                                  items: TypeDiscountEnum.values
                                      .map<DropdownMenuItem<TypeDiscountEnum>>(
                                          (TypeDiscountEnum? typeEnum) {
                                    return DropdownMenuItem(
                                      value: typeEnum,
                                      child: Text(typeEnum!.stringValue,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.rubik(
                                            fontSize: 14,
                                            color: Color(0xFF565656),
                                            fontWeight: FontWeight.w400,
                                          )),
                                    );
                                  }).toList(),
                                  onChanged: (TypeDiscountEnum? typeEnum) {
                                    typeDiscountEnum = typeEnum;
                                    controller.enumSelected = typeEnum;
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Observer(builder: (context) {
                                  return controller.enumSelected ==
                                          TypeDiscountEnum.levemaispaguemenos
                                      ? formLevePague()
                                      : controller.enumSelected ==
                                              TypeDiscountEnum.percentual
                                          ? formPercentual()
                                          : controller.enumSelected ==
                                                  TypeDiscountEnum
                                                      .precodeprecopor
                                              ? formDePor()
                                              : Container();
                                }),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Data ativação",
                                              style: GoogleFonts.rubik(
                                                fontSize: 14,
                                                color: const Color(0xFF565656),
                                                fontWeight: FontWeight.w400,
                                              )),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.datetime,
                                            inputFormatters: [
                                              DateInputFormatter()
                                            ],
                                            validator: (value) {
                                              return value == null ||
                                                      value.isEmpty ||
                                                      value.contains('-')
                                                  ? ""
                                                  : null;
                                            },
                                            controller: dateActivateController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Data inativação",
                                              style: GoogleFonts.rubik(
                                                fontSize: 14,
                                                color: const Color(0xFF565656),
                                                fontWeight: FontWeight.w400,
                                              )),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.datetime,
                                            inputFormatters: [
                                              DateInputFormatter()
                                            ],
                                            validator: (value) =>
                                                value == null ||
                                                        value.contains('-') ||
                                                        value.isEmpty
                                                    ? ""
                                                    : null,
                                            controller:
                                                dateInactivateController,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                  },
                                  child: DottedBorder(
                                    dashPattern: const [10, 4],
                                    color: const Color(0xFFCFD8DC),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.string(
                                            cloud,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                              'Clique e faça o upload da imagem!',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.rubik(
                                                fontSize: 16,
                                                color: const Color(0xFF565656),
                                                fontWeight: FontWeight.w500,
                                              )),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              'Largura X altura recomendada 1000 x 1000px. Tamanho máximo 800KB.',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.rubik(
                                                fontSize: 14,
                                                color: const Color(0xFF565656),
                                                fontWeight: FontWeight.w400,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
        ),
      ),
    );
  }

  Widget formLevePague() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Leve',
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                        color: const Color(0xFF565656),
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            !RegExp(r'^(^[0-9]+$)').hasMatch(value.trim())
                        ? ""
                        : null,
                    controller: leveController,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pague',
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                        color: const Color(0xFF565656),
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            !RegExp(r'^(^[0-9]+$)').hasMatch(value.trim())
                        ? ""
                        : null,
                    controller: pagueController,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text('Preço',
            style: GoogleFonts.rubik(
              fontSize: 14,
              color: const Color(0xFF565656),
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) => value == null || value.isEmpty ? "" : null,
          controller: priceController,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget formPercentual() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preço ',
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                        color: const Color(0xFF565656),
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? "" : null,
                    controller: priceController,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Percentual de Desconto',
                      textScaler: TextScaler.linear(0.9),
                      maxLines: 1,
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                        color: const Color(0xFF565656),
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? "" : null,
                    controller: percentualController,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget formDePor() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preço "DE"',
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                        color: const Color(0xFF565656),
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? "" : null,
                    controller: precoDeController,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preço "POR"',
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                        color: const Color(0xFF565656),
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? "" : null,
                    controller: precoPorController,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  void initPreviousValues(List<ProductsModel> value) {
    if (args.actionEnum == ActionEnum.edit) {
      productsModelSelected = value
          .firstWhere((element) => element.title == args.discountsModel!.title);
      descripTionController.text = productsModelSelected!.description!;

      priceController.text = args.discountsModel!.price!.toString();

      if (args.discountsModel!.type == TypeDiscountEnum.levemaispaguemenos) {
        leveController.text = args.discountsModel!.takeQuantity.toString();
        pagueController.text = args.discountsModel!.buyQuantity.toString();
      } else if (args.discountsModel!.type == TypeDiscountEnum.percentual) {
        percentualController.text =
            args.discountsModel!.percentageDiscount.toString();
      } else if (args.discountsModel!.type ==
          TypeDiscountEnum.precodeprecopor) {
        precoPorController.text = args.discountsModel!.priceFor.toString();
        precoDeController.text = args.discountsModel!.priceOf!.toString();
      }

      dateActivateController.text = args.discountsModel!.dateActivation!
          .toString()
          .toString()
          .split(" ")
          .first
          .split("-")
          .reversed
          .join("/");
      dateInactivateController.text = args.discountsModel!.dateInactivation!
          .toString()
          .toString()
          .split(" ")
          .first
          .split("-")
          .reversed
          .join("/");
      typeDiscountEnum = args.discountsModel?.type;
      controller.enumSelected = args.discountsModel?.type;
    }
  }

  Future saveCallback() async {
    _formKey.currentState!.validate()
        ? args.actionEnum == ActionEnum.create
            ? await controller.saveDiscount(discountsModel: DiscountsModel(title: productsModelSelected?.title, actived: true, price: priceController.text.isEmpty ? null : double.parse(priceController.text.replaceAll(",", ".")), description: descripTionController.text, type: typeDiscountEnum, priceOf: precoDeController.text.isEmpty ? null : double.parse(precoDeController.text.replaceAll(",", ".")), priceFor: precoPorController.text.isEmpty ? null : double.parse(precoPorController.text.replaceAll(",", ".")), percentageDiscount: percentualController.text.isEmpty ? null : double.parse(percentualController.text.replaceAll(",", ".")), takeQuantity: leveController.text.isEmpty ? null : int.parse(leveController.text), buyQuantity: pagueController.text.isEmpty ? null : int.parse(pagueController.text), dateActivation: dateActivateController.text.isEmpty ? null : DateTime.parse(dateActivateController.text.split("/").reversed.join("-")), dateInactivation: dateInactivateController.text.isEmpty ? null : DateTime.parse(dateInactivateController.text.split("/").reversed.join("-")), imageUrl: productsModelSelected?.image)).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Desconto Salvo!',
                            style: GoogleFonts.rubik(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ))
            : await controller
                .updateDescount(
                    discountsModel: DiscountsModel(
                        id: args.discountsModel?.id,
                        title: productsModelSelected?.title,
                        actived: args.discountsModel?.actived,
                        price: priceController.text.isEmpty
                            ? null
                            : double.parse(
                                priceController.text.replaceAll(",", ".")),
                        description: descripTionController.text,
                        type: typeDiscountEnum,
                        priceOf: precoDeController.text.isEmpty
                            ? null
                            : double.parse(
                                precoDeController.text.replaceAll(",", ".")),
                        priceFor: precoPorController.text.isEmpty
                            ? null
                            : double.parse(
                                precoPorController.text.replaceAll(",", ".")),
                        percentageDiscount: percentualController.text.isEmpty
                            ? null
                            : double.parse(
                                percentualController.text.replaceAll(",", ".")),
                        takeQuantity: leveController.text.isEmpty
                            ? null
                            : int.parse(leveController.text),
                        buyQuantity: pagueController.text.isEmpty ? null : int.parse(pagueController.text),
                        dateActivation: dateActivateController.text.isEmpty ? null : DateTime.parse(dateActivateController.text.split("/").reversed.join("-")),
                        dateInactivation: dateInactivateController.text.isEmpty ? null : DateTime.parse(dateInactivateController.text.split("/").reversed.join("-")),
                        imageUrl: productsModelSelected?.image))
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Desconto Salvo!',
                            style: GoogleFonts.rubik(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ))
        : null;
  }
}
