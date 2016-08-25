From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 16/16] ARM64: dts: Define CPU power domain for MSM8916
Date: Thu, 25 Aug 2016 14:03:25 -0600
Message-ID: <1472155405-41841-17-git-send-email-lina.iyer@linaro.org>
References: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36478 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757665AbcHYUEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 16:04:24 -0400
Received: by mail-pf0-f179.google.com with SMTP id h186so20681498pfg.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Aug 2016 13:04:21 -0700 (PDT)
In-Reply-To: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org

Define power domain and the power states for the domain as defined by
the PSCI firmware. The 8916 firmware supports OS initiated method of
powering off the CPU clusters.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 3029773..506c712 100644
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
@@ -107,12 +111,33 @@
 				min-residency-us = <2000>;
 				local-timer-stop;
 			};
+
+			CLUSTER_RET: cluster_retention {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWR_DWN: cluster_gdhs {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
 		};
 	};
 
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD: cpu-pd@0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+		};
 	};
 
 	timer {
-- 
2.7.4

