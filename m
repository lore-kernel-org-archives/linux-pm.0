From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH V11 3/6] dt-bindings: Add thermal zone to bcm2835-thermal example
Date: Sun, 12 Mar 2017 22:11:02 +0000
Message-ID: <1489356665-3175-4-git-send-email-stefan.wahren@i2se.com>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489356665-3175-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a thermal zone in order to make the example complete.

Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
