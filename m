From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: dts: Add missing CPU frequencies for Exynos5422/5800
Date: Tue, 13 Dec 2016 17:52:29 +0100
Message-ID: <5220084.l31t5oJbsy@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Thomas Abraham <thomas.ab@samsung.com>, Andreas Faerber <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add missing 2000MHz & 1900MHz OPPs (for A15 cores) and 1400MHz OPP
(for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4 thermal
cooling maps to account for new OPPs.

Since new OPPs are not available on all Exynos5422/5800 boards modify
dts files for Odroid-XU3 Lite (limited to 1.8 GHz / 1.3 GHz) & Peach
Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.

Tested on Odroid-XU3 and XU3 Lite.

Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   14 +++++++-------
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   17 +++++++++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    4 ++++
 arch/arm/boot/dts/exynos5800.dtsi                  |   15 +++++++++++++++
 4 files changed, 43 insertions(+), 7 deletions(-)

Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-13 15:59:33.779763261 +0100
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-13 15:59:33.775763261 +0100
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
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-13 15:59:33.779763261 +0100
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-13 15:59:33.775763261 +0100
@@ -21,6 +21,23 @@
 	compatible = "hardkernel,odroid-xu3-lite", "samsung,exynos5800", "samsung,exynos5";
 };
 
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
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-13 15:59:33.779763261 +0100
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-13 15:59:33.779763261 +0100
@@ -146,6 +146,10 @@
 	vdd-supply = <&ldo9_reg>;
 };
 
+&cluster_a7_opp_table {
+	/delete-property/opp@1400000000;
+};
+
 &cpu0 {
 	cpu-supply = <&buck2_reg>;
 };
Index: b/arch/arm/boot/dts/exynos5800.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5800.dtsi	2016-12-13 15:59:33.779763261 +0100
+++ b/arch/arm/boot/dts/exynos5800.dtsi	2016-12-13 15:59:33.779763261 +0100
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
+	opp_a7_14: opp@1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-microvolt = <1250000>;
+		clock-latency-ns = <140000>;
+	};
 	opp@1300000000 {
 		opp-microvolt = <1250000>;
 	};
