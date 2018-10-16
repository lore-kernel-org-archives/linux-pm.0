From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 10/11] DT: arm: exynos: add support for thermal trip
 irq-mode
Date: Tue, 16 Oct 2018 16:56:21 +0200
Message-ID: <20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4~eHqQRcy8z2133821338eucas1p2W@eucas1p2.samsung.com>
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch adds support for new flash which indicates
that trip point triggers irq when temperature is met.
Exynos5433 supports 8 trip point which will trigger irq.
Above that number other trip points should be registered
without 'irq-mode' flag.
That will force the thermal framework to start polling
the temperature sensor under configured conditions and
handle the trip point.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 40 +++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c..dbce706ed 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -59,22 +59,26 @@
 				cpu0_alert0: cpu-alert-0 {
 					temperature = <50000>; /* millicelsius */
 					hysteresis = <5000>; /* millicelsius */
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu0_alert1: cpu-alert-1 {
 					temperature = <60000>; /* millicelsius */
 					hysteresis = <5000>; /* millicelsius */
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu0_alert2: cpu-alert-2 {
 					temperature = <70000>; /* millicelsius */
 					hysteresis = <5000>; /* millicelsius */
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu0_crit0: cpu-crit-0 {
 					temperature = <120000>; /* millicelsius */
 					hysteresis = <0>; /* millicelsius */
 					type = "critical";
+					irq-mode;
 				};
 				/*
 				 * Exynos542x supports only 4 trip-points
@@ -142,22 +146,26 @@
 				cpu1_alert0: cpu-alert-0 {
 					temperature = <50000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu1_alert1: cpu-alert-1 {
 					temperature = <60000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu1_alert2: cpu-alert-2 {
 					temperature = <70000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu1_crit0: cpu-crit-0 {
 					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
+					irq-mode;
 				};
 				cpu1_alert3: cpu-alert-3 {
 					temperature = <70000>;
@@ -209,22 +217,26 @@
 				cpu2_alert0: cpu-alert-0 {
 					temperature = <50000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu2_alert1: cpu-alert-1 {
 					temperature = <60000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu2_alert2: cpu-alert-2 {
 					temperature = <70000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu2_crit0: cpu-crit-0 {
 					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
+					irq-mode;
 				};
 				cpu2_alert3: cpu-alert-3 {
 					temperature = <70000>;
@@ -276,22 +288,26 @@
 				cpu3_alert0: cpu-alert-0 {
 					temperature = <50000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu3_alert1: cpu-alert-1 {
 					temperature = <60000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu3_alert2: cpu-alert-2 {
 					temperature = <70000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu3_crit0: cpu-crit-0 {
 					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
+					irq-mode;
 				};
 				cpu3_alert3: cpu-alert-3 {
 					temperature = <70000>;
-- 
2.7.4
