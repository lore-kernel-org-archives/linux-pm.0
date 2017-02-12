From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 2/2] ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
Date: Sun, 12 Feb 2017 19:38:48 +0000
Message-ID: <1486928328-25870-2-git-send-email-stefan.wahren@i2se.com>
References: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63350 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdBLTjt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Feb 2017 14:39:49 -0500
In-Reply-To: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org
Cc: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

As suggested by Eduardo Valentin this adds the thermal zone for
the bcm2835 SoC with its single thermal sensor. We start with
the criticial trip point and leave the cooling devices empty
since we don't have any at the moment.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---

Changes in V2:
- add missing thermal-sensor-cells property
- change gpu-thermal to cpu-thermal

 arch/arm/boot/dts/bcm283x.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index a3106aa..4dc74f6 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -19,6 +19,25 @@
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
+			cooling-maps {
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -394,6 +413,7 @@
 			compatible = "brcm,bcm2835-thermal";
 			reg = <0x7e212000 0x8>;
 			clocks = <&clocks BCM2835_CLOCK_TSENS>;
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
-- 
1.7.9.5

