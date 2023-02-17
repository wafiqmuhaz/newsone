// ignore_for_file: cascade_invocations, unnecessary_new, prefer_single_quotes, prefer_final_locals, omit_local_variable_types, always_use_package_imports, lines_longer_than_80_chars, file_names

import '../constans.dart';
import '../models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> myCategories = [];
  CategoryModel categoryModel;

  //1
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Terkini";
  categoryModel.imageAssetUrl = kAllImage;
  categoryModel.category = 'terkini';
  myCategories.add(categoryModel);

  //2
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Top News";
  categoryModel.imageAssetUrl = kTopNewsImage;
  categoryModel.category = 'top-news';
  myCategories.add(categoryModel);

  //3
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Politik";
  categoryModel.imageAssetUrl = kPolitikImage;
  categoryModel.category = 'politik';
  myCategories.add(categoryModel);

  //4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Indonesia";
  categoryModel.imageAssetUrl = kIndonesiaImage;
  categoryModel.category = 'warta-bumi';
  myCategories.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Hukum";
  categoryModel.imageAssetUrl = kHukumImage;
  categoryModel.category = 'hukum';
  myCategories.add(categoryModel);

  //6
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Ekonomi";
  categoryModel.imageAssetUrl = kEkonomiImage;
  categoryModel.category = 'ekonomi';
  myCategories.add(categoryModel);

  //7
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Metro";
  categoryModel.imageAssetUrl = kMetroImage;
  categoryModel.category = 'metro';
  myCategories.add(categoryModel);

  //8
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Dunia";
  categoryModel.imageAssetUrl = kWorldImage;
  categoryModel.category = 'dunia';
  myCategories.add(categoryModel);

  //9
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sepak Bola";
  categoryModel.imageAssetUrl = kSepakBolaImage;
  categoryModel.category = 'sepakbola';
  myCategories.add(categoryModel);

  //10
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Olahraga";
  categoryModel.imageAssetUrl = kOlahragaImage;
  categoryModel.category = 'olahraga';
  myCategories.add(categoryModel);

  //11
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Humaniora";
  categoryModel.imageAssetUrl = kHumanioraImage;
  categoryModel.category = 'humaniora';
  myCategories.add(categoryModel);

  //12
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Lifestyle";
  categoryModel.imageAssetUrl = kLifestyleImage;
  categoryModel.category = 'lifestyle';
  myCategories.add(categoryModel);

  //13
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Hiburan";
  categoryModel.imageAssetUrl = kHiburanImage;
  categoryModel.category = 'hiburan';
  myCategories.add(categoryModel);

  //15
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Tekno";
  categoryModel.imageAssetUrl = kTeknoImage;
  categoryModel.category = 'tekno';
  myCategories.add(categoryModel);

  //16
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Otomotif";
  categoryModel.imageAssetUrl = kOtomotifImage;
  categoryModel.category = 'otomotif';
  myCategories.add(categoryModel);

  //17
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Rilis - Pers";
  categoryModel.imageAssetUrl = kRilisPersImage;
  categoryModel.category = 'rilis-pers';
  myCategories.add(categoryModel);

  return myCategories;
}
