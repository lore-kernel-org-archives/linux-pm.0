From: Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 3/3] dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
Date: Wed, 13 Mar 2019 20:34:08 +0100
Message-ID: <20190313193408.23740-4-abailon@baylibre.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, georgi.djakov@linaro.org
Cc: mturquette@baylibre.com, ptitiano@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com, ccaione@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Document the device-tree bindings interconnect driver for i.MX8MM SoC.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../bindings/interconnect/imx8mm.txt          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx8mm.txt

diff --git a/Documentation/devicetree/bindings/interconnect/imx8mm.txt b/Documentation/devicetree/bindings/interconnect/imx8mm.txt
new file mode 100644
index 000000000000..81f0cf134de2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/imx8mm.txt
@@ -0,0 +1,24 @@
+i.MX busfreq driver binding
+----------------------------------------------------
+
+Required properties :
+- compatible : must be "fsl,busfreq-imx8mm"
+- #interconnect-cells : should contain 1
+- clocks : list of phandles and specifiers to all interconnect bus clocks
+- clock-names : clock names must include "dram-alt", "dram-apb", "dram-core",
+                "noc", "ahb" and "axi"
+
+Examples:
+
+	icc0: icc {
+		compatible = "fsl,busfreq-imx8mm";
+		#interconnect-cells = <1>;
+		clocks = <&clk IMX8MM_CLK_DRAM_ALT>,
+			 <&clk IMX8MM_CLK_DRAM_APB>,
+			 <&clk IMX8MM_CLK_DRAM_CORE>,
+			 <&clk IMX8MM_CLK_NOC_DIV>,
+			 <&clk IMX8MM_CLK_AHB_DIV>,
+			 <&clk IMX8MM_CLK_MAIN_AXI>;
+		clock-names = "dram-alt", "dram-apb", "dram-core", "noc",
+			 "ahb", "axi";
+	};
-- 
2.19.2
