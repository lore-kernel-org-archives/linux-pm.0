From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v2 1/7] dt-bindings: power: supply: bq24190_charger: add bq24192 and usb-otg-vbus
Date: Wed, 31 Oct 2018 20:11:43 -0400
Message-ID: <20181101001149.13453-2-masneyb@onstation.org>
References: <20181101001149.13453-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101001149.13453-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca, masneyb@onstation.org
List-Id: linux-pm@vger.kernel.org

Add support for the ti,bq24192 variant and a child node for the
usb-otg-vbus regulator.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../devicetree/bindings/power/supply/bq24190.txt         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
index 9e517d307070..c8ac028bd3c7 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
@@ -3,6 +3,7 @@ TI BQ24190 Li-Ion Battery Charger
 Required properties:
 - compatible: contains one of the following:
     * "ti,bq24190"
+    * "ti,bq24192"
     * "ti,bq24192i"
 - reg: integer, I2C address of the charger.
 - interrupts[-extended]: configuration for charger INT pin.
@@ -19,6 +20,12 @@ Optional properties:
 - ti,system-minimum-microvolt: when power is connected and the battery is below
   minimum system voltage, the system will be regulated above this setting.
 
+child nodes:
+- usb-otg-vbus:
+  Usage: optional
+  Description: Regulator that is used to control the VBUS voltage direction for
+               either USB host mode or for charging on the OTG port.
+
 Notes:
 - Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
   charge current on USB SDP ports, among other features). To simulate this on
@@ -39,6 +46,8 @@ Example:
 		interrupts-extended = <&gpiochip 10 IRQ_TYPE_EDGE_FALLING>;
 		monitored-battery = <&bat>;
 		ti,system-minimum-microvolt = <3200000>;
+
+		usb_otg_vbus: usb-otg-vbus { };
 	};
 
 	&twl_gpio {
-- 
2.17.2
