From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v1 3/3] dt-bindings: Interconnect device-tree bindings draft
Date: Tue, 27 Jun 2017 20:49:03 +0300
Message-ID: <20170627174903.27978-4-georgi.djakov@linaro.org>
References: <20170627174903.27978-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170627174903.27978-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, gregkh@linuxfoundation.org, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

The interconnect API is not yet using DT bindings for expressing
the relations between the API consumers and providers. This is
posted a separate patch as it needs further discussions on how
to represent this with DT.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt         | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..e38a29db981e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,75 @@
+Interconnect Provider Device Tree Bindings
+=========================================
+
+The purpose of this document is to define a common set of generic interconnect
+providers/consumers properties.
+
+
+= interconnect providers =
+
+The interconnect provider binding is intended to represent the interconnect
+controllers in the system. Each provider registers a set of interconnect
+nodes, which expose the interconnect related capabilities of the interconnect
+to consumer drivers. These capabilities can be throughput, latency, priority
+etc. The consumer drivers set constraints on interconnect path (or endpoints)
+depending on the usecase. Interconnect providers can also be interconnect
+consumers, such as in the case where two network-on-chip fabrics interface
+directly
+
+Required properties:
+- compatible : contains the interconnect provider vendor specific compatible
+	       string
+- reg : register space of the interconnect controller hardware
+- #interconnect-cells : number of cells in a interconnect specifier needed to
+		       encode the interconnect node id.
+
+Example:
+
+		snoc: snoc@0580000 {
+			compatible = "qcom,msm-bus-snoc";
+			reg = <0x580000 0x14000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
+			status = "okay";
+		};
+		bimc: bimc@0400000 {
+			compatible = "qcom,msm-bus-bimc";
+			reg = <0x400000 0x62000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
+			status = "okay";
+		};
+		pnoc: pnoc@500000 {
+			compatible = "qcom,msm-bus-pnoc";
+			reg = <0x500000 0x11000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+			status = "okay";
+		};
+
+= interconnect consumers =
+
+The interconnect consumers are device nodes which consume the interconnect
+path(s) provided by the interconnect provider. There can be multiple
+interconnect providers on a SoC and the consumer may consume multiple paths
+from different providers depending on usecase and the components it has to
+interact with.
+
+Required-properties:
+interconnect-src : A phandle and interconnect provider specifier as defined by
+		bindings of the interconnect provider specified by phandle.
+		This denotes the source device port which will be used, as the
+		device may have multiple master ports.
+interconnect-dst : A phandle and internet provider specifier pointing to the
+		local port of the target device.
+
+Example:
+
+	sdhci@07864000 {
+		...
+		interconnect-src = <&pnoc MAS_PNOC_SDCC_2>;
+		interconnect-dst = <&pnoc SLV_BLSP_1>;
+	};
