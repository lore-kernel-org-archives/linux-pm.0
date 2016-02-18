From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
Date: Thu, 18 Feb 2016 14:13:01 +0900
Message-ID: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
12 steps for big core (700-1800 MHz). Add respective cooling cells.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. Add cooling properties to all CPUs (suggested by Viresh).
---
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 261d25173f61..5c052d7ff554 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -33,6 +33,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu@1 {
@@ -42,6 +45,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu2: cpu@2 {
@@ -51,6 +57,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu3: cpu@3 {
@@ -60,6 +69,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu4: cpu@100 {
@@ -70,6 +82,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu5: cpu@101 {
@@ -79,6 +94,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu6: cpu@102 {
@@ -88,6 +106,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu7: cpu@103 {
@@ -97,6 +118,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 };
-- 
2.5.0
