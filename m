From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 3/3] ARM: dts: imx6sx: Add DISPLAY power domain support
Date: Mon,  1 Oct 2018 23:56:18 +0300
Message-ID: <a55920b698eaf64809440613315f3182374282e6.1538426534.git.leonard.crestez@nxp.com>
References: <cover.1538426534.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538426534.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

This was implemented in the driver but not actually defined and
referenced in dts. This makes it always on.

>From reference manual in section "10.4.1.4.1 Power Distribution":

"Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
PCIe, DCIC, and LDB. It is supplied by internal regulator."

The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
actually inside the DISPLAY domain. Handle this by adding the pcie node
in both power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 844caa39364f..054d812bcdbc 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -778,10 +778,22 @@
 						#power-domain-cells = <0>;
 						power-supply = <&reg_soc>;
 						clocks = <&clks IMX6SX_CLK_GPU>;
 					};
 
+					pd_disp: power-domain@2 {
+						reg = <2>;
+						#power-domain-cells = <0>;
+						clocks = <&clks IMX6SX_CLK_PXP_AXI>,
+							 <&clks IMX6SX_CLK_DISPLAY_AXI>,
+							 <&clks IMX6SX_CLK_LCDIF1_PIX>,
+							 <&clks IMX6SX_CLK_LCDIF_APB>,
+							 <&clks IMX6SX_CLK_LCDIF2_PIX>,
+							 <&clks IMX6SX_CLK_CSI>,
+							 <&clks IMX6SX_CLK_VADC>;
+					};
+
 					pd_pci: power-domain@3 {
 						reg = <3>;
 						#power-domain-cells = <0>;
 						power-supply = <&reg_pcie>;
 					};
@@ -1196,10 +1208,11 @@
 					reg = <0x02218000 0x4000>;
 					interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_PXP_AXI>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names = "pxp-axi", "disp-axi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 
 				csi2: csi@221c000 {
 					reg = <0x0221c000 0x4000>;
@@ -1217,10 +1230,11 @@
 					interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
 					clocks = <&clks IMX6SX_CLK_LCDIF1_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names = "pix", "axi", "disp_axi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 
 				lcdif2: lcdif@2224000 {
 					compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
@@ -1228,19 +1242,21 @@
 					interrupts = <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>;
 					clocks = <&clks IMX6SX_CLK_LCDIF2_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names = "pix", "axi", "disp_axi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 
 				vadc: vadc@2228000 {
 					reg = <0x02228000 0x4000>, <0x0222c000 0x4000>;
 					reg-names = "vadc-vafe", "vadc-vdec";
 					clocks = <&clks IMX6SX_CLK_VADC>,
 						 <&clks IMX6SX_CLK_CSI>;
 					clock-names = "vadc", "csi";
+					power-domains = <&pd_disp>;
 					status = "disabled";
 				};
 			};
 
 			adc1: adc@2280000 {
@@ -1361,10 +1377,11 @@
 			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,
 				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
-			power-domains = <&pd_pci>;
+			power-domains = <&pd_disp>, <&pd_pci>;
+			power-domain-names = "pcie", "pcie_phy";
 			status = "disabled";
 		};
 	};
 };
-- 
2.17.1
