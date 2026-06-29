#include <WiFi.h>
#include <WebServer.h>
#include <WiFiClientSecure.h>
#include "esp_camera.h"

const char* ssid = "Pranam";
const char* password = "1234567890";

String BOTtoken = "YOUR_NEW_BOT_TOKEN";
String CHAT_ID  = "xxx";

WebServer server(80);

/////////////////////////////////////////////////
// RHYX M21-45 Pins
/////////////////////////////////////////////////

#define PWDN_GPIO_NUM     32
#define RESET_GPIO_NUM    -1
#define XCLK_GPIO_NUM      0
#define SIOD_GPIO_NUM     26
#define SIOC_GPIO_NUM     27

#define Y9_GPIO_NUM       35
#define Y8_GPIO_NUM       34
#define Y7_GPIO_NUM       39
#define Y6_GPIO_NUM       36
#define Y5_GPIO_NUM       21
#define Y4_GPIO_NUM       19
#define Y3_GPIO_NUM       18
#define Y2_GPIO_NUM        5

#define VSYNC_GPIO_NUM    25
#define HREF_GPIO_NUM     23
#define PCLK_GPIO_NUM     22

void sendTelegramPhoto();

/////////////////////////////////////////////////
// HTTP Request
/////////////////////////////////////////////////

void handleCapture()
{
  Serial.println("Capture Request");

  sendTelegramPhoto();

  server.send(200, "text/plain", "PHOTO SENT");
}

/////////////////////////////////////////////////
// Setup
/////////////////////////////////////////////////

void setup()
{
  Serial.begin(115200);

  camera_config_t config;

  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer   = LEDC_TIMER_0;

  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;

  config.pin_xclk  = XCLK_GPIO_NUM;
  config.pin_pclk  = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href  = HREF_GPIO_NUM;

  config.pin_sscb_sda = SIOD_GPIO_NUM;
  config.pin_sscb_scl = SIOC_GPIO_NUM;

  config.pin_pwdn  = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;

  config.xclk_freq_hz = 10000000;

  config.pixel_format = PIXFORMAT_YUV422;
  config.frame_size   = FRAMESIZE_QVGA;

  config.jpeg_quality = 12;
  config.fb_count     = 1;

  esp_err_t err = esp_camera_init(&config);

  if(err != ESP_OK)
  {
    Serial.printf("Init Failed = 0x%x\n", err);
    return;
  }

  Serial.println("Camera Init OK");

  WiFi.begin(ssid,password);

  while(WiFi.status()!=WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi Connected");

  Serial.print("IP Address : ");
  Serial.println(WiFi.localIP());

  server.on("/capture", handleCapture);

  server.begin();

  Serial.println("Camera Ready");
}

/////////////////////////////////////////////////
// Loop
/////////////////////////////////////////////////

void loop()
{
  server.handleClient();
}

/////////////////////////////////////////////////
// Send Telegram Photo
/////////////////////////////////////////////////

void sendTelegramPhoto()
{
  Serial.println("Capturing...");

  camera_fb_t *fb = esp_camera_fb_get();

  if(!fb)
  {
    Serial.println("Capture Failed");
    return;
  }

  Serial.print("Raw Size = ");
  Serial.println(fb->len);

  uint8_t *jpg_buf = NULL;
  size_t jpg_len = 0;

  if(!frame2jpg(fb,15,&jpg_buf,&jpg_len))
  {
    Serial.println("JPEG Conversion Failed");
    esp_camera_fb_return(fb);
    return;
  }

  esp_camera_fb_return(fb);

  Serial.println("JPEG Conversion OK");

  Serial.print("JPEG Size = ");
  Serial.println(jpg_len);

  WiFiClientSecure client;

  client.setInsecure();

  Serial.println("Connecting Telegram...");

  if(!client.connect("api.telegram.org",443))
  {
    Serial.println("Telegram Connection Failed");
    free(jpg_buf);
    return;
  }

  Serial.println("Telegram Connected");

  String head =
  "--boundary\r\n"
  "Content-Disposition: form-data; name=\"chat_id\"\r\n\r\n"
  + CHAT_ID +
  "\r\n--boundary\r\n"
  "Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n"
  "Content-Type: image/jpeg\r\n\r\n";

  String tail =
  "\r\n--boundary--\r\n";

  uint32_t totalLen =
      head.length() +
      jpg_len +
      tail.length();

  client.println(
      "POST /bot" + BOTtoken +
      "/sendPhoto HTTP/1.1");

  client.println("Host: api.telegram.org");
  client.println("Content-Type: multipart/form-data; boundary=boundary");
  client.println("Content-Length: " + String(totalLen));
  client.println();

  client.print(head);

  Serial.println("Uploading...");

  client.write(jpg_buf, jpg_len);

  client.print(tail);

  free(jpg_buf);

  unsigned long timeout = millis();

  while(client.connected() &&
        millis() - timeout < 10000)
  {
    while(client.available())
    {
      char c = client.read();
      Serial.write(c);
      timeout = millis();
    }
  }

  client.stop();

  Serial.println();
  Serial.println("Telegram Sent");
}
