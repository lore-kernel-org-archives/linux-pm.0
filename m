From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 14/14] ARM64: dts: Define CPU power domain for MSM8916
Date: Wed, 22 Jun 2016 13:36:49 -0600
Message-ID: <1466624209-27432-15-git-send-email-lina.iyer@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34210 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbcFVTiA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 15:38:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id bz2so19567623pad.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2016 12:37:59 -0700 (PDT)
In-Reply-To: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org

Define power domain and the power states for the domain as defined by
the PSCI firmware. The 8916 firmware supports OS initiated method of
powering off the CPU clusters.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 3029773..208af00 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -64,6 +64,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU1: cpu@1 {
@@ -73,6 +74,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU2: cpu@2 {
@@ -82,6 +84,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU3: cpu@3 {
@@ -91,6 +94,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		L2_0: l2-cache {
@@ -110,6 +114,27 @@
 		};
 	};
 
+	CPU_PD: cpu-pd@0 {
+		#power-domain-cells = <0>;
+		power-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+	};
+
+	pd-power-states {
+		CLUSTER_RET: power-state@1 {
+			state-param = <0x1000010>;
+			entry-latency-us = <500>;
+			exit-latency-us = <500>;
+			residency-us = <2000>;
+		 };
+
+		CLUSTER_PWR_DWN: power-state@2 {
+			state-param = <0x1000030>;
+			entry-latency-us = <2000>;
+			exit-latency-us = <2000>;
+			residency-us = <6000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.7.4

