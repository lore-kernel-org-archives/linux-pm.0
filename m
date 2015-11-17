From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 27/27] ARM64: dts: Define CPU power domain for MSM8916
Date: Tue, 17 Nov 2015 15:37:51 -0700
Message-ID: <1447799871-56374-28-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Define power domain and the power states for the domain as defined by
the PSCI firmware.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 48 ++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5806438..3ea8126 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -47,12 +47,32 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				cluster = <&CLUSTER0>;
+
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+		};
+
 		CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CLUSTER0>;
 		};
 
 		CPU1: cpu@1 {
@@ -61,6 +81,7 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CLUSTER0>;
 		};
 
 		CPU2: cpu@2 {
@@ -69,6 +90,7 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CLUSTER0>;
 		};
 
 		CPU3: cpu@3 {
@@ -77,6 +99,7 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CLUSTER0>;
 		};
 
 		idle-states {
@@ -89,8 +112,31 @@
 				min-residency-us = <2000>;
 			};
 		};
+
+		CLUSTER0: cluster@0 {
+			#power-domain-cells = <0>;
+			power-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+		};
+
+		cluster-power-states {
+			CLUSTER_RET: power-state@1 {
+				compatible = "linux,domain-state";
+				state-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				residency-us = <2000>;
+			 };
+
+			CLUSTER_PWR_DWN: power-state@2 {
+				compatible = "linux,domain-state";
+				state-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				residency-us = <6000>;
+			};
+		};
 	};
-	
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.1.4
