From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V10 3/6] dt-bindings: Add thermal zone to bcm2835-thermal example
Date: Fri,  3 Mar 2017 23:18:46 +0000
Message-ID: <1488583129-4159-4-git-send-email-stefan.wahren@i2se.com>
References: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdCCXVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2017 18:21:12 -0500
In-Reply-To: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

Add a thermal zone in order to make the example complete.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/brcm,bcm2835-thermal.txt      |   32 +++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
index 474531d..da8c5b7 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
@@ -3,15 +3,39 @@ Binding for Thermal Sensor driver for BCM2835 SoCs.
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
+
+		coefficients = <(-538)	407000>;
+
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
