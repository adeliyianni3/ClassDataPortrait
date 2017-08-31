Date getDateTaken(JSONObject photoPassed) {
    String dtemp = photoPassed.getJSONObject("dates").getString("taken");
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.US);
    return df.parse(dtemp, new ParsePosition(1));
}
PImage getImage(String idPassed) {
    JSONObject datum = loadJSONObject(api + sizes + settings + "&photo_id=" + idPassed);
    return loadImage(datum.getJSONObject("sizes").getJSONArray("size").getJSONObject(1).getString("source"), "jpg");
}
String getOwner(JSONObject photoPassed) {
    return photoPassed.getJSONObject("owner").getString("nsid");
}
float getBV(String photoPassed) {
  try {
   JSONArray exif = loadJSONObject(api+eXIF+"&api_key="+api_key+"&photo_id="+photoPassed+"&format=json&nojsoncallback=1").getJSONObject("photo").getJSONArray("exif"); 
    if (exif.toString().contains("Brightness Value")) {
      for (int i = 0; i < exif.size(); i++) {
        if (exif.getJSONObject(i).getString("tag").contains("BrightnessValue")) {
          return (5*(2+parseInt(exif.getJSONObject(i).getJSONObject("raw").getString("_content"))));
        }
      }
    }
    return 6;
  } catch (Exception e ){
    return 6;
  }
}