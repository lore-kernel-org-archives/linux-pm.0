From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH V12 2/4] ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
Date: Fri, 31 Mar 2017 20:03:04 +0000
Message-ID: <1490990586-30898-3-git-send-email-stefan.wahren@i2se.com>
References: <1490990586-30898-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490990586-30898-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

As suggested by Eduardo Valentin this adds the thermal zone for
the bcm2835 SoC with its single thermal sensor. We start with
the criticial trip point and leave the cooling devices empty
since we don't have any at the moment. Since the coefficients
could vary depending on the SoC we need to define them separate.

Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |    4 ++++
 arch/arm/boot/dts/bcm2836.dtsi |    4 ++++
 arch/arm/boot/dts/bcm283x.dtsi |   21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 0890d97..659b6e9 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -24,6 +24,10 @@
 	};
 };
 
+&cpu_thermal {
+	coefficients = <(-538)	407000>;
+};
+
 /* enable thermal sensor with the correct compatible property set */
 &thermal {
 	compatible = "brcm,bcm2835-thermal";
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index 519a44f..da3deeb 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -77,6 +77,10 @@
 	interrupts = <8>;
 };
 
+&cpu_thermal {
+	coefficients = <(-538)	407000>;
+};
+
 /* enable thermal sensor with the correct compatible property set */
 &thermal {
 	compatible = "brcm,bcm2836-thermal";
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index a3106aa..9bc0a1c9 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -19,6 +19,26 @@
 		bootargs = "earlyprintk console=ttyAMA0";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature	= <80000>;
+					hysteresis	= <0>;
+					type		= "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -394,6 +414,7 @@
 			compatible = "brcm,bcm2835-thermal";
 			reg = <0x7e212000 0x8>;
 			clocks = <&clocks BCM2835_CLOCK_TSENS>;
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
