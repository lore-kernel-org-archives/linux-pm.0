From: "Wendy Ng" <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: Add TMON driver support to bcm281xx
Date: Fri, 25 Oct 2013 17:00:29 -0700
Message-ID: <1382745629-1123-4-git-send-email-wendy.ng@broadcom.com>
References: <1382745629-1123-1-git-send-email-wendy.ng@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382745629-1123-1-git-send-email-wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wendy Ng <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This adds the support of Temperature Monitor (TMON) driver for
Broadcom bcm281xx SoCs to the DT node. This also adds the
thermal framework device-tree binding such that TMON driver
can be used within the thermal framework.

Signed-off-by: Wendy Ng <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/bcm11351-brt.dts |    4 ++++
 arch/arm/boot/dts/bcm11351.dtsi    |   29 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm28155-ap.dts  |    4 ++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 5a269c7..c24fd12 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -43,6 +43,10 @@
 		status = "okay";
 	};
 
+	tmon: tmon@34008000 {
+		status = "okay";
+	};
+
 	usbotg@3f120000 {
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 29987e2..0f17beb 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -13,6 +13,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "skeleton.dtsi"
 
@@ -25,6 +26,24 @@
 		bootargs = "console=ttyS0,115200n8";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <250>; /* msec */
+			polling-delay = <1000>; /* msec */
+
+					   /* sensor */
+			thermal-sensors = <&tmon>;
+
+			trips {
+				cpu_crit: cpu_crit {
+				        temperature = <105000>; /* mCelsius */
+				        hysteresis = <2000>; /* mCelsius */
+				        type = THERMAL_TRIP_CRITICAL;
+				};
+			};
+		};
+	};
+
 	gic: interrupt-controller@3ff00100 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
@@ -285,6 +304,15 @@
 		};
 	};
 
+	tmon: tmon@34008000 {
+		compatible = "brcm,bcm11351-tmon", "brcm,kona-tmon";
+		reg = <0x34008000 0x0024>;
+		clocks = <&tmon_1m_clk>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+		#thermal-sensor-cells = <0>;
+		status = "disabled";
+	};
+
 	usbotg: usbotg@3f120000 {
 		compatible = "snps,dwc2";
 		reg = <0x3f120000 0x10000>;
@@ -305,4 +333,5 @@
 		compatible = "brcm,kona-usb2";
 		status = "disabled";
 	};
+
 };
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 02ebaaf..7151c25 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -63,6 +63,10 @@
 		status = "okay";
 	};
 
+	tmon: tmon@34008000 {
+		status = "okay";
+	};
+
 	usbotg@3f120000 {
 		status = "okay";
 	};
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
