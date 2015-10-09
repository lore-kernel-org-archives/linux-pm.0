From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 8/8] arm64: dts: msm8916: Add thermal zones, tsens and qfprom nodes
Date: Fri,  9 Oct 2015 15:11:10 +0530
Message-ID: <1444383670-32693-9-git-send-email-rnayak@codeaurora.org>
References: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: edubezval@gmail.com, agross@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add thermal zones, tsens and qfprom nodes

Cc: Andy Gross <agross@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 66 +++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 3e7083c..63b5262 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -68,6 +68,49 @@
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
@@ -392,6 +435,29 @@
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
+			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
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
