From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 2/3] ARM: dts: Add cooling levels for CPUs on exynos5422/5800
Date: Thu, 18 Feb 2016 14:13:02 +0900
Message-ID: <1455772383-20598-2-git-send-email-k.kozlowski@samsung.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:8215 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbcBRFNY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 00:13:24 -0500
In-reply-to: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Exynos5422 and Exynos5800 we support 12 cpufreq steps (200-1300 MHz) for LITTLE
and 18 steps for big core (200-1700 MHz). Add respective cooling cells.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. Add cooling properties to all CPUs (suggested by Viresh).
---
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 9b46b9fbac4e..bf3c6f1ec4ee 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -32,6 +32,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu1: cpu@101 {
@@ -41,6 +44,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu2: cpu@102 {
@@ -50,6 +56,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu3: cpu@103 {
@@ -59,6 +68,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <11>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu4: cpu@0 {
@@ -69,6 +81,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu5: cpu@1 {
@@ -78,6 +93,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu6: cpu@2 {
@@ -87,6 +105,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu7: cpu@3 {
@@ -96,6 +117,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 };
-- 
2.5.0

