From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 9/9] arm64: dts: msm8916: Add thermal zones, tsens and eeprom nodes
Date: Wed,  8 Jul 2015 15:17:18 +0530
Message-ID: <1436348838-22671-10-git-send-email-rnayak@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54979 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933819AbbGHJss (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 05:48:48 -0400
In-Reply-To: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>

Add thermal zones, tsens and eeprom nodes

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0f49ebd..9ff9979 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -63,6 +63,49 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				cpu_alert0: trip@0 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit0: trip@1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				cpu_alert1: trip@0 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit1: trip@1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -215,5 +258,28 @@
 			interrupt-controller;
 			#interrupt-cells = <4>;
 		};
+
+		qfprom: qfprom@5c000 {
+			compatible = "qcom,qfprom";
+			reg = <0x5c000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			tsens_caldata: caldata@d0 {
+				reg = <0xd0 0x8>;
+			};
+			tsens_calsel: calsel@ec {
+				reg = <0xec 0x4>;
+			};
+		};
+
+		tsens: thermal-sensor@4a8000 {
+			compatible = "qcom,msm8916-tsens";
+			reg = <0x4a8000 0x2000>;
+			nvmem-cell = <&tsens_caldata>, <&tsens_calsel>;
+			nvmem-cell-names = "calib", "calib_sel";
+			qcom,tsens-slopes = <3200 3200 3200 3200 3200>;
+			qcom,sensor-id = <0 1 2 4 5>;
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

