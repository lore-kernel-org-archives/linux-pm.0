From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 3/3] ARM: dts: Don't overheat the Odroid XU3-Lite on high
 load
Date: Thu, 18 Feb 2016 14:13:03 +0900
Message-ID: <1455772383-20598-3-git-send-email-k.kozlowski@samsung.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

After adding cpufreq-dt support to Exynos542x, the Odroid XU3-Lite can
be easily overheated when launching eight CPU-intensive tasks:
	thermal thermal_zone3: critical temperature reached(121 C),shutting down

This seems to be specific to Odroid XU3-Lite board which officially
supports lower frequencies than regular XU3 or XU4. When working at
maximum CPU speed (1800 MHz big and 1300 MHz LITTLE) in warmer place for
longer time, the fan fails to cool down the board and it reaches
critical temperature.

Add CPU cooling to Exynos5422/5800 to fix this issue. When reaching last
interrupt-driven trip-point (70 degrees of Celsius) start passive
cooling in polling mode (slowing CPU by 2 steps). When reaching 85
degrees of Celsius, start slowing even more, down to 600 MHz.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. Use polling mode for passive cooling (number of configurable trip
   points in TMU exceeded).

2. Adjust the values (temperature and cooling levels).
---
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 46 ++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
index 2b289d7c0d13..3e4c4ad96d63 100644
--- a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
@@ -16,7 +16,7 @@
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
 			thermal-sensors = <&tmu_cpu0 0>;
-			polling-delay-passive = <0>;
+			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
 				cpu_alert0: cpu-alert-0 {
@@ -39,6 +39,23 @@
 					hysteresis = <0>; /* millicelsius */
 					type = "critical";
 				};
+				/*
+				 * Exyunos542x support only 4 trip-points
+				 * so for these polling mode is required.
+				 * Start polling at temperature level of last
+				 * interrupt-driven trip: cpu_alert2
+				 */
+				cpu_alert3: cpu-alert-3 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <10000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_alert4: cpu-alert-4 {
+					temperature = <85000>; /* millicelsius */
+					hysteresis = <10000>; /* millicelsius */
+					type = "passive";
+				};
+
 			};
 			cooling-maps {
 				map0 {
@@ -53,6 +70,33 @@
 				     trip = <&cpu_alert2>;
 				     cooling-device = <&fan0 2 3>;
 				};
+				/*
+				 * When reaching cpu_alert3, reduce CPU
+				 * by 2 steps. On Exynos5422/5800 that would
+				 * be: 1500 MHz and 1100 MHz.
+				 */
+				map3 {
+				     trip = <&cpu_alert3>;
+				     cooling-device = <&cpu0 0 2>;
+				};
+				map4 {
+				     trip = <&cpu_alert3>;
+				     cooling-device = <&cpu4 0 2>;
+				};
+
+				/*
+				 * When reaching cpu_alert4, reduce CPU
+				 * further, down to 600 MHz (11 steps for big,
+				 * 7 steps for LITTLE).
+				 */
+				map5 {
+				     trip = <&cpu_alert4>;
+				     cooling-device = <&cpu0 3 7>;
+				};
+				map6 {
+				     trip = <&cpu_alert4>;
+				     cooling-device = <&cpu4 3 11>;
+				};
 			};
 		};
 	};
-- 
2.5.0
