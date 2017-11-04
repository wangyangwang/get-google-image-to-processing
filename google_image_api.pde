import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

ArrayList<String> urls = new ArrayList<String>();
PImage image;
int index = 0;


void setup() {
  size(900, 900);
  urls = GetImageURLs("zhenzhenqi");
}

void draw() {
  String imageURL = urls.get(index);
  PImage img = loadImage(imageURL);
  if (img!=null) {
    image(img, 0, 0);
  }
  if (index<urls.size()) {
    index++;
  }
}