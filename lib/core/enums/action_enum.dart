enum ActionEnum {
  create(route: "/"),
  edit(route: "/discountDetail");
 
  const ActionEnum({required this.route});
  final String route;
}
