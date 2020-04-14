/*
 * based on http://tkitao.hatenablog.com/entry/2014/09/21/125829
 */
import java.io.*;
import java.awt.image.*;
import javax.imageio.*;
import hypermedia.net.*;

final int PORT = 5555;
UDP udp;
PImage video;

void setup() {
  size(400, 296);
  udp = new UDP(this, PORT);
  udp.listen(true);
  video = createImage(400, 296, RGB);
}

void draw() {
  background(0);
  image(video, 0, 0);
}

void receive(byte[] data) {
  video.loadPixels();
  ByteArrayInputStream bais = new ByteArrayInputStream(data);
  try {
    ImageIO.read(bais).getRGB(0, 0, video.width, video.height, video.pixels, 0, video.width);
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  video.updatePixels();
}
