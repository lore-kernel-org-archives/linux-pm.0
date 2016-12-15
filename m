From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] ARM: dts: Add missing CPU frequencies for Exynos5422/5800
Date: Thu, 15 Dec 2016 12:55:59 +0100
Message-ID: <10512254.nyUcL0zgTP@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andreas Faerber <afaerber-l3A5Bk7waGM@public.gmane.org>, Thomas Abraham <thomas.ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ben Gamari <ben-OfdNVJEh3GKkIYD+M5K+dQ@public.gmane.org>, Arjun K V <arjun.kv-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Add missing 2000MHz & 1900MHz OPPs (for A15 cores) and 1400MHz OPP
(for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4 thermal
cooling maps to account for new OPPs.

Since new OPPs are not available on all Exynos5422/5800 boards modify
dts files for Odroid-XU3 Lite (limited to 1.8 GHz / 1.3 GHz) & Peach
Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.

Tested on Odroid-XU3 and XU3 Lite.

Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: Andreas Faerber <afaerber-l3A5Bk7waGM@public.gmane.org>
Cc: Thomas Abraham <thomas.ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Gamari <ben-OfdNVJEh3GKkIYD+M5K+dQ@public.gmane.org>
Cc: Arjun K V <arjun.kv-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
v2:
- added comments about limitations of SoC revisions used by Odroid-XU3 Lite and
  Peach Pi boards (suggested by Javier)
- removed redundant opp_a7_14 label
- added Arjun to Cc:

Javier, could you test it on Peach Pi board?

 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   14 ++++++-------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   22 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    9 ++++++++
 arch/arm/boot/dts/exynos5800.dtsi                  |   15 ++++++++++++++
 4 files changed, 53 insertions(+), 7 deletions(-)

Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-15 12:43:54.365955950 +0100
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-15 12:43:54.361955949 +0100
@@ -118,7 +118,7 @@
 				/*
 				 * When reaching cpu_alert3, reduce CPU
 				 * by 2 steps. On Exynos5422/5800 that would
-				 * be: 1600 MHz and 1100 MHz.
+				 * (usually) be: 1800 MHz and 1200 MHz.
 				 */
 				map3 {
 					trip = <&cpu_alert3>;
@@ -131,16 +131,16 @@
 
 				/*
 				 * When reaching cpu_alert4, reduce CPU
-				 * further, down to 600 MHz (11 steps for big,
-				 * 7 steps for LITTLE).
+				 * further, down to 600 MHz (13 steps for big,
+				 * 8 steps for LITTLE).
 				 */
-				map5 {
+				cooling_map5: map5 {
 					trip = <&cpu_alert4>;
-					cooling-device = <&cpu0 3 7>;
+					cooling-device = <&cpu0 3 8>;
 				};
-				map6 {
+				cooling_map6: map6 {
 					trip = <&cpu_alert4>;
-					cooling-device = <&cpu4 3 11>;
+					cooling-device = <&cpu4 3 13>;
 				};
 			};
 		};
Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-15 12:43:54.365955950 +0100
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-15 12:43:54.361955949 +0100
@@ -21,6 +21,28 @@
 	compatible = "hardkernel,odroid-xu3-lite", "samsung,exynos5800", "samsung,exynos5";
 };
 
+/*
+ * Odroid XU3-Lite board uses SoC revision with lower maximum frequencies
+ * than Odroid XU3/XU4 boards: 1.8 GHz for A15 cores & 1.3 GHz for A7 cores.
+ * Therefore we need to update OPPs tables and thermal maps accordingly.
+ */
+&cluster_a15_opp_table {
+	/delete-node/opp@2000000000;
+	/delete-node/opp@1900000000;
+};
+
+&cluster_a7_opp_table {
+	/delete-node/opp@1400000000;
+};
+
+&cooling_map5 {
+	cooling-device = <&cpu0 3 7>;
+};
+
+&cooling_map6 {
+	cooling-device = <&cpu4 3 11>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
Index: b/arch/arm/boot/dts/exynos5800-peach-pi.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-15 12:43:54.365955950 +0100
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-15 12:43:54.361955949 +0100
@@ -146,6 +146,15 @@
 	vdd-supply = <&ldo9_reg>;
 };
 
+/*
+ * Peach Pi board uses SoC revision with lower maximum frequency for A7 cores
+ * (1.3 GHz instead of 1.4 GHz) than Odroid XU3/XU4 boards.  Thus we need to
+ * update A7 OPPs table accordingly.
+ */
+&cluster_a7_opp_table {
+	/delete-property/opp@1400000000;
+};
+
 &cpu0 {
 	cpu-supply = <&buck2_reg>;
 };
Index: b/arch/arm/boot/dts/exynos5800.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5800.dtsi	2016-12-15 12:43:54.365955950 +0100
+++ b/arch/arm/boot/dts/exynos5800.dtsi	2016-12-15 12:43:54.361955949 +0100
@@ -24,6 +24,16 @@
 };
 
 &cluster_a15_opp_table {
+	opp@2000000000 {
+		opp-hz = /bits/ 64 <2000000000>;
+		opp-microvolt = <1250000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@1900000000 {
+		opp-hz = /bits/ 64 <1900000000>;
+		opp-microvolt = <1250000>;
+		clock-latency-ns = <140000>;
+	};
 	opp@1700000000 {
 		opp-microvolt = <1250000>;
 	};
@@ -85,6 +95,11 @@
 };
 
 &cluster_a7_opp_table {
+	opp@1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-microvolt = <1250000>;
+		clock-latency-ns = <140000>;
+	};
 	opp@1300000000 {
 		opp-microvolt = <1250000>;
 	};

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
