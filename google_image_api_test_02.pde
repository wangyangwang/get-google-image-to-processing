import httprocessing.*;

import org.jsoup.*;
import org.jsoup.examples.*;
import org.jsoup.helper.*;
import org.jsoup.nodes.*;
import org.jsoup.parser.*;
import org.jsoup.safety.*;
import org.jsoup.select.*;

import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

// can only grab first 100 results
String keyword = "zzyw";
String userAgent = "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36";
String url = "https://www.google.com/search?site=imghp&tbm=isch&source=hp&q="+keyword+"&gws_rd=cr";

List<String> resultUrls = new ArrayList<String>();
List<PImage> imgs = new ArrayList<PImage>();
PImage image;
int index = 0;


void setup() {
  size(900, 900);
  try {
    Document doc = Jsoup.connect(url).userAgent(userAgent).referrer("https://www.google.com/").get();

    Elements elements = doc.select("div.rg_meta");

    JSONObject jsonObject;
    for (Element element : elements) {
      if (element.childNodeSize() > 0) {
        jsonObject = (JSONObject) new JSONParser().parse(element.childNode(0).toString());
        resultUrls.add((String) jsonObject.get("ou"));
      }
    }

    System.out.println("number of results: " + resultUrls.size());

    for (String imageUrl : resultUrls) {
      System.out.println(imageUrl);
    }
  }
  catch(Exception e) {
    println(e);
  }
}

void draw() {

  index++;
  String imgurl = resultUrls.get(index);
  if (imgurl.contains(".jpg") ||  imgurl.contains(".png") || imgurl.contains(".jpeg") || imgurl.contains(".gif")) {
    PImage img = loadImage(imgurl);
    if (img!=null) {
      image(img, 0, 0);
    }
  };
}