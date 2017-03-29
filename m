From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH v4 1/2] power: supply: ltc2941-battery-gauge: Add vendor to compatibles in binding
Date: Wed, 29 Mar 2017 12:00:56 -0400
Message-ID: <20170329160057.8298-1-javier@osg.samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The DT binding document for LTC2941 and LTC2943 battery gauges did not use
a vendor prefix in the listed compatible strings. The driver says that the
manufacturer is Linear Technology which is "lltc" in vendor-prefixes.txt.

There isn't an upstream Device Tree source file that has nodes defined for
these devices, so there's no need to keep the old compatible strings.

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/power/supply/ltc2941.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
index ea42ae12d924..a9d7aa60558b 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
+++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
@@ -6,8 +6,8 @@ temperature monitoring, and uses a slightly different conversion
 formula for the charge counter.
 
 Required properties:
-- compatible: Should contain "ltc2941" or "ltc2943" which also indicates the
-    type of I2C chip attached.
+- compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which also
+    indicates the type of I2C chip attached.
 - reg: The 7-bit I2C address.
 - lltc,resistor-sense: The sense resistor value in milli-ohms. Can be a 32-bit
     negative value when the battery has been connected to the wrong end of the
@@ -20,7 +20,7 @@ Required properties:
 Example from the Topic Miami Florida board:
 
 	fuelgauge: ltc2943@64 {
-		compatible = "ltc2943";
+		compatible = "lltc,ltc2943";
 		reg = <0x64>;
 		lltc,resistor-sense = <15>;
 		lltc,prescaler-exponent = <5>; /* 2^(2*5) = 1024 */
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
