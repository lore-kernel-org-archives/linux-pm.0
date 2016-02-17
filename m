From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC 2/3] ARM: dts: Add cooling levels for CPUs on exynos5422/5800
Date: Wed, 17 Feb 2016 15:55:27 +0900
Message-ID: <1455692128-28504-3-git-send-email-k.kozlowski@samsung.com>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

On Exynos5422 and Exynos5800 we support 12 cpufreq steps (200-1300 MHz) for LITTLE
and 18 steps for big core (200-1700 MHz). Add respective cooling cells.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 9b46b9fbac4e..858bb7f57d76 100644
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
@@ -69,6 +72,9 @@
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
 			operating-points-v2 = <&cluster_a15_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu5: cpu@1 {
-- 
2.5.0
