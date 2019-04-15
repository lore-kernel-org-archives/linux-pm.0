From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: qcs404: Add interconnect provider DT nodes
Date: Mon, 15 Apr 2019 13:43:56 +0300
Message-ID: <20190415104357.5305-4-georgi.djakov@linaro.org>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415104357.5305-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, bjorn.andersson@linaro.org, georgi.djakov@linaro.org
Cc: vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on qcs404-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v2:
- No changes.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index e8fd26633d57..706e918f79f6 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/interconnect/qcom,qcs404.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -226,6 +227,30 @@
 			compatible = "qcom,rpm-qcs404";
 			qcom,glink-channels = "rpm_requests";
 
+			bimc: interconnect@0 {
+				compatible = "qcom,qcs404-bimc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+					<&rpmcc RPM_SMD_BIMC_A_CLK>;
+			};
+
+			pcnoc: interconnect@1 {
+				compatible = "qcom,qcs404-pcnoc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+					<&rpmcc RPM_SMD_PNOC_A_CLK>;
+			};
+
+			snoc: interconnect@2 {
+				compatible = "qcom,qcs404-snoc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+					<&rpmcc RPM_SMD_SNOC_A_CLK>;
+			};
+
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-qcs404";
 				#clock-cells = <1>;
