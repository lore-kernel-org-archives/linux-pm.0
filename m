From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Date: Mon, 8 Oct 2018 18:06:23 +0000
Message-ID: <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
index 95a3c1cb877d..b7f815d82d1b 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -778,10 +778,22 @@
 						#power-domain-cells =3D <0>;
 						power-supply =3D <&reg_soc>;
 						clocks =3D <&clks IMX6SX_CLK_GPU>;
 					};
=20
+					pd_disp: power-domain@2 {
+						reg =3D <2>;
+						#power-domain-cells =3D <0>;
+						clocks =3D <&clks IMX6SX_CLK_PXP_AXI>,
+							 <&clks IMX6SX_CLK_DISPLAY_AXI>,
+							 <&clks IMX6SX_CLK_LCDIF1_PIX>,
+							 <&clks IMX6SX_CLK_LCDIF_APB>,
+							 <&clks IMX6SX_CLK_LCDIF2_PIX>,
+							 <&clks IMX6SX_CLK_CSI>,
+							 <&clks IMX6SX_CLK_VADC>;
+					};
+
 					pd_pci: power-domain@3 {
 						reg =3D <3>;
 						#power-domain-cells =3D <0>;
 						power-supply =3D <&reg_pcie>;
 					};
@@ -1196,10 +1208,11 @@
 					reg =3D <0x02218000 0x4000>;
 					interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX6SX_CLK_PXP_AXI>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pxp-axi", "disp-axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				csi2: csi@221c000 {
 					reg =3D <0x0221c000 0x4000>;
@@ -1217,10 +1230,11 @@
 					interrupts =3D <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
 					clocks =3D <&clks IMX6SX_CLK_LCDIF1_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pix", "axi", "disp_axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				lcdif2: lcdif@2224000 {
 					compatible =3D "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
@@ -1228,19 +1242,21 @@
 					interrupts =3D <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>;
 					clocks =3D <&clks IMX6SX_CLK_LCDIF2_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pix", "axi", "disp_axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				vadc: vadc@2228000 {
 					reg =3D <0x02228000 0x4000>, <0x0222c000 0x4000>;
 					reg-names =3D "vadc-vafe", "vadc-vdec";
 					clocks =3D <&clks IMX6SX_CLK_VADC>,
 						 <&clks IMX6SX_CLK_CSI>;
 					clock-names =3D "vadc", "csi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
 			};
=20
 			adc1: adc@2280000 {
@@ -1361,10 +1377,11 @@
 			clocks =3D <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,
 				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 			clock-names =3D "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
-			power-domains =3D <&pd_pci>;
+			power-domains =3D <&pd_disp>, <&pd_pci>;
+			power-domain-names =3D "pcie", "pcie_phy";
 			status =3D "disabled";
 		};
 	};
 };
--=20
2.17.1
