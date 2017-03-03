From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V10 4/6] ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
Date: Fri,  3 Mar 2017 23:18:47 +0000
Message-ID: <1488583129-4159-5-git-send-email-stefan.wahren@i2se.com>
References: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdCCXVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2017 18:21:12 -0500
In-Reply-To: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

As suggested by Eduardo Valentin this adds the thermal zone for
the bcm2835 SoC with its single thermal sensor. We start with
the criticial trip point and leave the cooling devices empty
since we don't have any at the moment. Since the coefficients
could vary depending on the SoC we need to define them separate.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
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
