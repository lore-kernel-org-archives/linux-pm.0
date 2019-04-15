From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 4/4] dt-bindings: interconnect: qcs404: Introduce qcom,qos DT property
Date: Mon, 15 Apr 2019 13:43:57 +0300
Message-ID: <20190415104357.5305-5-georgi.djakov@linaro.org>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415104357.5305-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, bjorn.andersson@linaro.org, georgi.djakov@linaro.org
Cc: vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There are separate hardware blocks per each interconnect that allow QoS
configuration to be applied to each port (node). There are different kinds of
priorities that could be set on these ports. Each port supports also various
QoS modes such as "fixed", "limiter", "bypass" and "regulator". Depending on
the mode, there are a few additional knobs that could be configured.

Introduce the qcom,qos property, so that we describe this relation in DT and
allow the interconnect provider drivers can make use of it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v2:
- New patch.

 .../bindings/interconnect/qcom,qcs404.txt     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
index 9befcd14a5b5..b971e0ee2963 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
@@ -11,9 +11,37 @@ Required properties :
 Optional properties :
 clocks : list of phandles and specifiers to all interconnect bus clocks
 clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+qcom,qos : phandle to the QoS device-tree node
 
 Example:
 
+soc {
+	...
+	bimc_qos: interconnect@400000 {
+		compatible = "qcom,qcs404-bimc-qos";
+		reg = <0x400000 0x80000>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+			<&rpmcc RPM_SMD_BIMC_A_CLK>;
+	};
+
+	pcnoc_qos: interconnect@500000 {
+		compatible = "qcom,qcs404-pcnoc-qos";
+		reg = <0x500000 0x15080>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+			<&rpmcc RPM_SMD_PNOC_A_CLK>;
+	};
+
+	snoc_qos: interconnect@580000 {
+		compatible = "qcom,qcs404-snoc-qos";
+		reg = <0x580000 0x14000>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+			<&rpmcc RPM_SMD_SNOC_A_CLK>;
+	};
+};
+
 rpm-glink {
 	...
 	rpm_requests: glink-channel {
@@ -24,6 +52,7 @@ rpm-glink {
 			clock-names = "bus_clk", "bus_a_clk";
 			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
 				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+			qcom,qos = <&bimc_qos>;
 		};
 
 		pnoc: interconnect@1 {
@@ -32,6 +61,7 @@ rpm-glink {
 			clock-names = "bus_clk", "bus_a_clk";
 			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
 				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+			qcom,qos = <&pcnoc_qos>;
 		};
 
 		snoc: interconnect@2 {
@@ -40,6 +70,7 @@ rpm-glink {
 			clock-names = "bus_clk", "bus_a_clk";
 			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
 				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+			qcom,qos = <&snoc_qos>;
 		};
 	};
 };
