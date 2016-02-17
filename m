From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC 3/3] ARM: dts: Don't overheat the Odroid XU3-Lite on high load
Date: Wed, 17 Feb 2016 15:55:28 +0900
Message-ID: <1455692128-28504-4-git-send-email-k.kozlowski@samsung.com>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

After adding cpufreq-dt support to Exynos542x, the Odroid XU3-Lite can
be easily overheated when launching eight CPU-intensive tasks:
	thermal thermal_zone3: critical temperature reached(121 C),shutting down

This seems to be specific to Odroid XU3-Lite board which officially
supports lower frequencies than regular XU3 or XU4. When working at
maximum CPU speed (1800 MHz big and 1300 MHz LITTLE) in warmer place for
longer time, the fan fails to cool down the board and it reaches
critical temperature.

Add CPU cooling to Exynos5422/5800 to fix this issue. When reaching 95
degrees of Celsius, the board will slow down by 3 steps (around
1400/1000 MHz). When reaching 110 degrees of Celsius go to 600 MHz.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
index 2b289d7c0d13..66073ce29aee 100644
--- a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
@@ -34,6 +34,16 @@
 					hysteresis = <5000>; /* millicelsius */
 					type = "active";
 				};
+				cpu_alert3: cpu-alert-3 {
+					temperature = <95000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_alert4: cpu-alert-4 {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "passive";
+				};
 				cpu_crit0: cpu-crit-0 {
 					temperature = <120000>; /* millicelsius */
 					hysteresis = <0>; /* millicelsius */
@@ -53,6 +63,37 @@
 				     trip = <&cpu_alert2>;
 				     cooling-device = <&fan0 2 3>;
 				};
+
+				/*
+				 * When reaching cpu_alert3, reduce CPU
+				 * by 3 steps. On Exynos5422/5800 that would
+				 * be: 1400 MHz and 1000 MHz.
+				 */
+				map3 {
+				     trip = <&cpu_alert3>;
+				     cooling-device = <&cpu0 3 3>;
+				};
+				map4 {
+				     trip = <&cpu_alert3>;
+				     cooling-device = <&cpu4 3 3>;
+				};
+
+				/*
+				 * When reaching cpu_alert4, reduce CPU
+				 * to 600 MHz (11 steps for big, 7 steps for
+				 * LITTLE).
+				 * Exynos5420 has less OPPs and reversed
+				 * numbering of CPUs (big/LITTLE) so this
+				 * would not match.
+				 */
+				map5 {
+				     trip = <&cpu_alert4>;
+				     cooling-device = <&cpu0 7 7>;
+				};
+				map6 {
+				     trip = <&cpu_alert4>;
+				     cooling-device = <&cpu4 11 11>;
+				};
 			};
 		};
 	};
-- 
2.5.0
