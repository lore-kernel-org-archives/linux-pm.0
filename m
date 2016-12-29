From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] ARM: dts: Add CPU OPPs for Exynos4412 Prime
Date: Thu, 29 Dec 2016 14:36:51 +0100
Message-ID: <1483018611-27998-3-git-send-email-b.zolnierkie@samsung.com>
References: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161229133734epcas5p1e893904353c23170e82ece54a06aebed@epcas5p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43390 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbcL2Nhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2016 08:37:39 -0500
In-reply-to: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Ben Gamari <ben@smart-cactus.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Add CPU operating points for Exynos4412 Prime (it supports
additional 1704MHz & 1600MHz OPPs and 1500MHz OPP is just
a regular non-turbo OPP on this SoC).  Also update relevant
cooling maps to account for new OPPs.

ODROID-X2/U2/U3 boards use Exynos4412 Prime SoC version so
update their board files accordingly.

Based on Hardkernel's kernel for ODROID-X2/U2/U3 boards.

Cc: Doug Anderson <dianders@chromium.org>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 +--
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  5 +--
 arch/arm/boot/dts/exynos4412-odroidx2.dts       |  1 +
 arch/arm/boot/dts/exynos4412-prime.dtsi         | 41 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
 5 files changed, 48 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 8aa19ba..5282d69e 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -97,11 +97,11 @@
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			cooling-maps {
-				map0 {
+				cooling_map0: map0 {
 				     /* Corresponds to 800MHz at freq_table */
 				     cooling-device = <&cpu0 7 7>;
 				};
-				map1 {
+				cooling_map1: map1 {
 				     /* Corresponds to 200MHz at freq_table */
 				     cooling-device = <&cpu0 13 13>;
 			       };
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 99634c5..7504a5a 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 #include "exynos4412-odroid-common.dtsi"
+#include "exynos4412-prime.dtsi"
 
 / {
 	model = "Hardkernel ODROID-U3 board based on Exynos4412";
@@ -47,11 +48,11 @@
 			cooling-maps {
 				map0 {
 				     trip = <&cpu_alert1>;
-				     cooling-device = <&cpu0 7 7>;
+				     cooling-device = <&cpu0 9 9>;
 				};
 				map1 {
 				     trip = <&cpu_alert2>;
-				     cooling-device = <&cpu0 13 13>;
+				     cooling-device = <&cpu0 15 15>;
 				};
 				map2 {
 				     trip = <&cpu_alert0>;
diff --git a/arch/arm/boot/dts/exynos4412-odroidx2.dts b/arch/arm/boot/dts/exynos4412-odroidx2.dts
index 4d22885..d6e92ebc 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx2.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx2.dts
@@ -12,6 +12,7 @@
 */
 
 #include "exynos4412-odroidx.dts"
+#include "exynos4412-prime.dtsi"
 
 / {
 	model = "Hardkernel ODROID-X2 board based on Exynos4412";
diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
new file mode 100644
index 0000000..e75bc17
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Samsung's Exynos4412 Prime SoC device tree source
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Exynos4412 Prime SoC revision supports higher CPU frequencies than
+ * non-Prime version.  Therefore we need to update OPPs table and
+ * thermal maps accordingly.
+ */
+
+&cpu0_opp_1500 {
+	/delete-property/turbo-mode;
+};
+
+&cpu0_opp_table {
+	opp@1600000000 {
+		opp-hz = /bits/ 64 <1600000000>;
+		opp-microvolt = <1350000>;
+		clock-latency-ns = <200000>;
+	};
+	opp@1704000000 {
+		opp-hz = /bits/ 64 <1704000000>;
+		opp-microvolt = <1350000>;
+		clock-latency-ns = <200000>;
+	};
+};
+
+&cooling_map0 {
+	cooling-device = <&cpu0 9 9>;
+};
+
+&cooling_map1 {
+	cooling-device = <&cpu0 15 15>;
+};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 40beede..3ebdf01 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -130,7 +130,7 @@
 			opp-microvolt = <1287500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1500000000 {
+		cpu0_opp_1500: opp@1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1350000>;
 			clock-latency-ns = <200000>;
-- 
1.9.1

