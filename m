From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] ARM: dts: bcm283x: Add critical thermal zone for GPU
Date: Sat,  4 Feb 2017 14:16:27 +0000
Message-ID: <1486217787-15703-2-git-send-email-stefan.wahren@i2se.com>
References: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
 <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdBDORh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 09:17:37 -0500
In-Reply-To: <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org
Cc: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

As suggested by Eduardo Valentin this adds the thermal zone for
the bcm2835 SoC. Since we currently don't have any cooling devices
leave this section empty.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm283x.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9c7ec7e..359da9d 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -19,6 +19,25 @@
 		bootargs = "earlyprintk console=ttyAMA0";
 	};
 
+	thermal-zones {
+		gpu_thermal: gpu-thermal {
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
-- 
1.7.9.5

