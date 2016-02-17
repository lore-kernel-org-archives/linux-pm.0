From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
Date: Wed, 17 Feb 2016 15:55:26 +0900
Message-ID: <1455692128-28504-2-git-send-email-k.kozlowski@samsung.com>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45813 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623AbcBQGz4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 01:55:56 -0500
In-reply-to: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>

On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
12 steps for big core (700-1800 MHz). Add respective cooling cells.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 261d25173f61..498ae82e1cb2 100644
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
@@ -70,6 +73,9 @@
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
 			operating-points-v2 = <&cluster_a7_opp_table>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu5: cpu@101 {
-- 
2.5.0

