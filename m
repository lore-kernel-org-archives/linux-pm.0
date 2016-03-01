From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v3 12/12] ARM64: dts: Define CPU power domain for MSM8916
Date: Tue,  1 Mar 2016 14:15:31 -0700
Message-ID: <1456866931-37851-14-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36042 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbcCAVQc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 16:16:32 -0500
Received: by mail-pa0-f45.google.com with SMTP id yy13so118700482pab.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 13:16:31 -0800 (PST)
In-Reply-To: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org

Define power domain and the power states for the domain as defined by
the PSCI firmware. The 8916 firmware supports OS initiated method of
powering off the CPU clusters.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index b7839a8..62dade8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -63,6 +63,7 @@
 			reg = <0x0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU1: cpu@1 {
@@ -71,6 +72,7 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU2: cpu@2 {
@@ -79,6 +81,7 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU3: cpu@3 {
@@ -87,6 +90,7 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		idle-states {
@@ -101,6 +105,27 @@
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
2.1.4

