From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 1/2] dt-bindings: Add thermal zone to bcm2835-thermal example
Date: Sun, 12 Feb 2017 19:38:47 +0000
Message-ID: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63675 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbdBLTju (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Feb 2017 14:39:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org
Cc: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

Add a thermal zone in order to make the example complete.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---

Changes in V2:
- add missing thermal-sensor-cells property
- change gpu-thermal to cpu-thermal

 .../bindings/thermal/brcm,bcm2835-thermal.txt      |   29 +++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
index 474531d..6b8607a 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
@@ -3,15 +3,36 @@ Binding for Thermal Sensor driver for BCM2835 SoCs.
 Required parameters:
 -------------------
 
-compatible: 	should be one of: "brcm,bcm2835-thermal",
-		"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
-reg:		Address range of the thermal registers.
-clocks: 	Phandle of the clock used by the thermal sensor.
+compatible: 		should be one of: "brcm,bcm2835-thermal",
+			"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
+reg:			Address range of the thermal registers.
+clocks: 		Phandle of the clock used by the thermal sensor.
+#thermal-sensor-cells:	should be 0 (see thermal.txt)
 
 Example:
 
+thermal-zones {
+	cpu_thermal: cpu-thermal {
+		polling-delay-passive = <0>;
+		polling-delay = <1000>;
+
+		thermal-sensors = <&thermal>;
+
+		trips {
+			cpu-crit {
+				temperature	= <80000>;
+				hysteresis	= <0>;
+				type		= "critical";
+			};
+		};
+		cooling-maps {
+		};
+	};
+};
+
 thermal: thermal@7e212000 {
 	compatible = "brcm,bcm2835-thermal";
 	reg = <0x7e212000 0x8>;
 	clocks = <&clocks BCM2835_CLOCK_TSENS>;
+	#thermal-sensor-cells = <0>;
 };
-- 
1.7.9.5

