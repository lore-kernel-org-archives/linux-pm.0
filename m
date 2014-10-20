From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v11 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
Date: Mon, 20 Oct 2014 17:11:18 +0530
Message-ID: <1413805281-6269-4-git-send-email-thomas.ab@samsung.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-2-git-send-email-thomas.ab@samsung.com>
 <1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57485 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaJTLaQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 07:30:16 -0400
In-reply-to: <1413805281-6269-3-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>

For Exynos 4210/5250/5420 based platforms, add CPU operating points and CPU
regulator supply properties for migrating from Exynos specific cpufreq driver
to using generic cpufreq drivers.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Andreas Farber <afaerber@suse.de>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Chander Kashyap <k.chander@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts         |    4 ++
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 ++
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 ++
 arch/arm/boot/dts/exynos4210.dtsi               |   14 ++++++++-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    4 ++
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 ++
 arch/arm/boot/dts/exynos5250-snow.dts           |    4 ++
 arch/arm/boot/dts/exynos5250.dtsi               |   25 ++++++++++++++-
 arch/arm/boot/dts/exynos5420.dtsi               |   38 +++++++++++++++++++++++
 9 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index f767c42..887dded 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -334,3 +334,7 @@
 		};
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&buck1_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index f516da9..66119dd 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -446,3 +446,7 @@
 		};
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&varm_breg>;
+};
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index d50eb3a..bf0a39c 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -492,3 +492,7 @@
 &mdma1 {
 	reg = <0x12840000 0x1000>;
 };
+
+&cpu0 {
+	cpu0-supply = <&vdd_arm_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index bcc9e63..69bac07 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -35,10 +35,22 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@900 {
+		cpu0: cpu@900 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x900>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <160000>;
+
+			operating-points = <
+				1200000 1250000
+				1000000 1150000
+				800000	1075000
+				500000	975000
+				400000	975000
+				200000	950000
+			>;
 		};
 
 		cpu@901 {
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7e728a1..ac07cdf 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -548,6 +548,10 @@
 	cap-sd-highspeed;
 };
 
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
+
 &rtc {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index bc27cc2..d91db82 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -410,3 +410,7 @@
 		};
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index f9bc04b..8459fb6 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -599,6 +599,10 @@
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 012b021..bccdd22 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -58,11 +58,34 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1700000000>;
+
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <140000>;
+
+			operating-points = <
+				1700000 1300000
+				1600000 1250000
+				1500000 1225000
+				1400000 1200000
+				1300000 1150000
+				1200000 1125000
+				1100000 1100000
+				1000000 1075000
+				 900000 1050000
+				 800000 1025000
+				 700000 1012500
+				 600000 1000000
+				 500000  975000
+				 400000  950000
+				 300000  937500
+				 200000  925000
+			>;
 		};
 		cpu@1 {
 			device_type = "cpu";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8617a03..1df164e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -59,8 +59,26 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu-cluster.0";
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			clock-latency = <140000>;
+
+			operating-points = <
+				1800000 1250000
+				1700000 1212500
+				1600000 1175000
+				1500000 1137500
+				1400000 1112500
+				1300000 1062500
+				1200000 1037500
+				1100000 1012500
+				1000000 987500
+				 900000 962500
+				 800000 937500
+				 700000 912500
+			>;
 		};
 
 		cpu1: cpu@1 {
@@ -69,6 +87,7 @@
 			reg = <0x1>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			clock-latency = <140000>;
 		};
 
 		cpu2: cpu@2 {
@@ -77,6 +96,7 @@
 			reg = <0x2>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			clock-latency = <140000>;
 		};
 
 		cpu3: cpu@3 {
@@ -85,14 +105,29 @@
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			clock-latency = <140000>;
 		};
 
 		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
+			clocks = <&clock CLK_KFC_CLK>;
+			clock-names = "cpu-cluster.1";
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			clock-latency = <140000>;
+
+			operating-points = <
+				1300000 1275000
+				1200000 1212500
+				1100000 1162500
+				1000000 1112500
+				 900000 1062500
+				 800000 1025000
+				 700000 975000
+				 600000 937500
+			>;
 		};
 
 		cpu5: cpu@101 {
@@ -101,6 +136,7 @@
 			reg = <0x101>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			clock-latency = <140000>;
 		};
 
 		cpu6: cpu@102 {
@@ -109,6 +145,7 @@
 			reg = <0x102>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			clock-latency = <140000>;
 		};
 
 		cpu7: cpu@103 {
@@ -117,6 +154,7 @@
 			reg = <0x103>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			clock-latency = <140000>;
 		};
 	};
 
-- 
1.6.6.rc2

