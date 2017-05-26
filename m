From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 3/4] dt-bindings: power: tps65217_charger: add NTC type for battery temperature measurement.
Date: Fri, 26 May 2017 13:04:12 +0200
Message-ID: <20170526110413.24836-3-enric.balletbo@collabora.com>
References: <20170526110413.24836-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526110413.24836-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh@kernel.org
Cc: mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@networkimprov.net
List-Id: linux-pm@vger.kernel.org

The TS pin of the TPS56217 connects to the NTC resistor in the battery
pack. By default the device is setup to support a 10-kohm but can also
be configured to support a 100-kohm. Add a propietry to configure the
connected NTC resistor. Therefore, the charger would get the wrong
temperature information.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v2:
 - Requested by Sebastian Reichel
   - Get rid of common properties and only maintain ntc-type.
Changes since v1:
 - None

 .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
index a11072c..851f5c7 100644
--- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
@@ -6,6 +6,12 @@ Required Properties:
              Should be <0> for the USB charger and <1> for the AC adapter.
 -interrupt-names: Should be "USB" and "AC"
 
+Optional properties:
+-ti,ntc-type: set the NTC type for battery temperature measurement. The value
+	must be 0 or 1, where:
+	  0 – 100k (curve 1, B = 3960)
+	  1 – 10k  (curve 2, B = 3480) (default)
+
 This node is a subnode of the tps65217 PMIC.
 
 Example:
@@ -14,4 +20,5 @@ Example:
 		compatible = "ti,tps65217-charger";
 		interrupts = <0>, <1>;
 		interrupt-names = "USB", "AC";
+		ti,ntc-type = <1>;
 	};
-- 
2.9.3
