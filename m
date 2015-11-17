From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 26/27] ARM64: dts: Add PSCI cpuidle support for MSM8916
Date: Tue, 17 Nov 2015 15:37:50 -0700
Message-ID: <1447799871-56374-27-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34582 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643AbbKQWjQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:39:16 -0500
Received: by padhx2 with SMTP id hx2so22149864pad.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:39:15 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>

Add device bindings for CPUs to suspend using PSCI as the enable-method.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7be7c23..5806438 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -51,25 +51,49 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x1>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x2>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x3>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc",
+						"arm,idle-state";
+				arm,psci-suspend-param = <0x40000002>;
+				entry-latency-us = <130>;
+				exit-latency-us = <150>;
+				min-residency-us = <2000>;
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
2.1.4

