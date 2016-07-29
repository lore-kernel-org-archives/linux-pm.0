From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 14/14] ARM64: dts: Define CPU power domain for MSM8916
Date: Fri, 29 Jul 2016 15:56:25 -0600
Message-ID: <1469829385-11511-15-git-send-email-lina.iyer@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35434 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbcG2V5E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 17:57:04 -0400
Received: by mail-pa0-f41.google.com with SMTP id iw10so34514714pac.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Jul 2016 14:57:04 -0700 (PDT)
In-Reply-To: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org

Define power domain and the power states for the domain as defined by
the PSCI firmware. The 8916 firmware supports OS initiated method of
powering off the CPU clusters.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 3029773..d122fa1 100644
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
@@ -110,6 +114,29 @@
 		};
 	};
 
+	CPU_PD: cpu-pd@0 {
+		#power-domain-cells = <0>;
+		domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+	};
+
+	cpu-domain-states {
+		CLUSTER_RET: domain_ret {
+			compatible = "arm,idle-state";
+			arm,psci-suspend-param = <0x1000010>;
+			entry-latency-us = <500>;
+			exit-latency-us = <500>;
+			residency-us = <2000>;
+		 };
+
+		CLUSTER_PWR_DWN: domain_gdhs {
+			compatible = "arm,idle-state";
+			arm,psci-suspend-param = <0x1000030>;
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

