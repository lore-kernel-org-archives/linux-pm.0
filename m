From: abailon@baylibre.com
Subject: [RFC PATCH 2/2] dt-bindings: interconnect: Document imx7ulp interconnect bindings
Date: Sat, 17 Nov 2018 12:19:05 +0100
Message-ID: <20181117111905.29091-3-abailon@baylibre.com>
References: <20181117111905.29091-1-abailon@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181117111905.29091-1-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Bailon <abailon@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This documents the device tree bindings for the interconnects
present in the imx7ulp SoC.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../bindings/interconnect/imx7ulp.txt           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx7ulp.txt

diff --git a/Documentation/devicetree/bindings/interconnect/imx7ulp.txt b/Documentation/devicetree/bindings/interconnect/imx7ulp.txt
new file mode 100644
index 000000000000..c32b7becdca7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/imx7ulp.txt
@@ -0,0 +1,17 @@
+iMX7ULP interconnect driver binding
+----------------------------------------------------
+
+Required properties :
+- compatible : should be "fsl,imx7ulp-icc";
+- #interconnect-cells : should contain 1
+- clocks : list of phandles and specifiers to all interconnect bus clocks
+- clock-names : clock names should include both "nic0_div" and "nic1_div"
+
+Examples:
+	icc0: icc {
+		compatible = "fsl,imx7ulp-icc";
+		clocks = <&clks IMX7ULP_CLK_NIC0_DIV>,
+			 <&clks IMX7ULP_CLK_NIC1_DIV>;
+		clock-names = "nic0_div", "nic1_div";
+		#interconnect-cells = <1>;
+	};
-- 
2.18.1
