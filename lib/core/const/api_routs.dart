const String apiBaseUrl="https://fakestoreapi.com";
const String getAllProducts="/products/";
String getLimitedProducts(int total)=>"/products?limit=$total"; 
String getSingleProducts(int id)=>"/products/$id";

const String addNewProduct ="/products";
String updateProduct(int id)=>"/products/$id";




