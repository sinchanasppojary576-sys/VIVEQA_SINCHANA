#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "Y";
const char* password = "Z";

String cameraIP = "x.x.x.x";

void setup()
{
  Serial.begin(115200);

  WiFi.begin(ssid,password);

  while(WiFi.status()!=WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi Connected");
  Serial.println(WiFi.localIP());
}

void loop()
{
  if(Serial.available())
  {
    char cmd = Serial.read();

    Serial.print("Received = ");
    Serial.println(cmd);

    if(cmd == 'D')
    {
      triggerCamera();
    }
  }
}

void triggerCamera()
{
  HTTPClient http;

  String url =
  "http://" +
  cameraIP +
  "/capture";

  Serial.println("Triggering Camera");

  http.begin(url);

  int code = http.GET();

  Serial.print("HTTP Code = ");
  Serial.println(code);

  http.end();
}
