//használom
const String ApiUrl =
    //'https://core-api-static.dkefe.com/api/en/level/level-one-beginner-practice/index.json';
    'https://core-api-static.dkefe.com/api/en/level/vocabulary-builder/index.json';

//használom
const assetsBaseUrl = 'https://d31xcz200zq3ks.cloudfront.net';

//api mindegyik ezzel kezdődik
const apiBaseUrl = 'https://core-api-static.dkefe.com/api/en/level';

//könyvek
const apiBooksUrl = '$apiBaseUrl/index.json';

//használom a book-ban
//olyan formátomut használ ami http hivashoz megfelelő
String getApiRouteOfBook(String book) {
  return '$apiBaseUrl/$book/index.json';
}
