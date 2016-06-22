From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 13/14] ARM64: dts: Add PSCI cpuidle support for MSM8916
Date: Wed, 22 Jun 2016 13:36:48 -0600
Message-ID: <1466624209-27432-14-git-send-email-lina.iyer@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34940 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbcFVTh5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 15:37:57 -0400
Received: by mail-pa0-f50.google.com with SMTP id hl6so19556776pac.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2016 12:37:57 -0700 (PDT)
In-Reply-To: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org

Add device bindings for CPUs to suspend using PSCI as the enable-method.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9681200..3029773 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -62,6 +62,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU1: cpu@1 {
@@ -69,6 +71,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x1>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU2: cpu@2 {
@@ -76,6 +80,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x2>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU3: cpu@3 {
@@ -83,12 +89,30 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x3>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		L2_0: l2-cache {
 		      compatible = "cache";
 		      cache-level = <2>;
 		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000002>;
+				entry-latency-us = <130>;
+				exit-latency-us = <150>;
+				min-residency-us = <2000>;
+				local-timer-stop;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
 	};
 
 	timer {
-- 
2.7.4

