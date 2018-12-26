# LoRa Environmental Sensors 


<a href="https://spielhuus.github.io/LoRa-Environmental-Sensors/final%20product.jpg"><img src="https://spielhuus.github.io/LoRa-Environmental-Sensors/final%20product.jpg" width="90%"></img></a>


Arduino based board for a Atmospheric Sensor BME280 LoRaWan Node. The LoRa Node measures barometric pressure, humidity, and temperature every 5 min. After the measurements, the ATtiny85 goes into sleep mode and is awakened by the watchdog timer. The RFM module sends the values to the TTN backend with Activation by Personalization (ABP) a fixed spreading factor and one of the four random channels. This project is based on the TinyLoRa-BME280 project [1].

## BOM

|Ref|Value|Description|
| --- | --- | --- | 
|BT1| [3034](https://spielhuus.github.io/LoRa-Environmental-Sensors/3034.pdf) |Battery Cell Holder|3034 1x20mm](https://www.keyelco.com/product.cfm/product_id/798)| 
|BT1| [CR2032]() |Battery Cell CR2032 (210 – 230 mAh)| 
|U1| [BME280](https://spielhuus.github.io/LoRa-Environmental-Sensors/BST-BME280_DS001-10.pdf) | [SparkFun BME280](https://github.com/sparkfun/SparkFun_BME280_Breakout_Board)|
|U2| [ATtiny85-20SU](https://spielhuus.github.io/LoRa-Environmental-Sensors/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf) | Atmel 8-bit AVR Microcontroller|
|U3| [RFM95W-868S2](https://spielhuus.github.io/LoRa-Environmental-Sensors/RFM95_96_97_98W.pdf) | Low Power Long Range Transceiver Module |
| - | Wire | Wire for the antenna, 8.6 cm |

The ATmega microprocessor needs an arduino bootloader. To burn a bootloader to the blank chip see [2]

## Wiring

<a href="https://spielhuus.github.io/LoRa-Environmental-Sensors/schema.png"><img src="https://spielhuus.github.io/LoRa-Environmental-Sensors/schema.png" width="30%"/></a>

| HopeRF RFM95 LoRa transceiver module |	ATmega8 Pin |   |	   	HopeRF RFM95 LoRa transceiver module |	ATmega8 Pin |
| ----- | ---- | --- | ---- | ---- |
| ANT |	- |   |	   	GND |	- |
| GND |	GND |   |	   	DIO5 | 	- |
| DIO3 |	- 	 |   |  	RESET |	PD5 (11) |
| DIO4 |	- 	  |   | 	NSS |	PB2 (16) |
| 3.3V |	3.3V 	|   |   	SCK |	PB5 (19) |
| DIO0 |	PD2 (4) |   | 	MOSI 7	PB3 (17) |
| DIO1 |	PD3 (5) |   | 	MISO |	PB4 (18) |
| DIO2 |	- 	  |   | 	GND |	- |

## Installation

The Arduino IDE has to be properly installed. 

Add the Libraries to you IDE:

- Install the Attiny Baord Manager
  - Under Preferences > Additional Boards Manager URLs: https://raw.githubusercontent.com/damellis/attiny/ide-1.6.x-boards-manager/package_damellis_attiny_index.json

  Multiple managers can be separated with a comma.

- Install TinyLoRa-BME280 v1.1
  - Download the ZIP archive from [TinyLoRa-BME280 v1.1](https://github.com/ClemensRiederer/TinyLoRa-BME280_v1.1)
  - Install the ZIP archive in the Arduino Library Manager

- Open Examples > TinyLoRa-BME280_v1.1-master > ATtiny_LoRa_BME280
  - Edit NwkSkey, AppSkey, DevAddr
  - Change the Spreading Factor in ATtinyLoRa.cpp
  - The Sleep time can be set with the SLEEP_TOTAL var.

- Burn the sketch to the Chip using an Arduino UNO [2]
  - Burn a bootloader first to set the fuses correctly

## Payload Format

The Payload is encoded as byte array.

| byte | content |
| ---- | ------- |
| 0..1 | temperature (*100) |
| 2..3 | humidity (*100) |
| 4..8 | barometric pressure |

To decode the values add this code in the TTM Console as decoder under Paload Formats.

```
function Decoder(bytes, port) {
  temp = ((bytes[0]) << 8)
              + ((bytes[1]));
  hum = ((bytes[2]) << 8)
              + ((bytes[3]));
  pres = ((bytes[4]) << 24)
              + ((bytes[5]) << 16)
              + ((bytes[6]) << 8)
              + ((bytes[7]));

  return {
    pressure: ( pres / 100 ),
    temperature: ( temp / 100 ),
    humidity: ( hum / 100 )
  };
}
```

## Links

1. [TinyLoRa-BME280 v1.1](https://github.com/ClemensRiederer/TinyLoRa-BME280_v1.1)
2. [Programming ATtiny85 with Arduino Uno](https://www.hackster.io/arjun/programming-attiny85-with-arduino-uno-afb829)

## License

[License CC BY 4.0](http://creativecommons.org/licenses/by/4.0/) - Attribution 4.0 International

