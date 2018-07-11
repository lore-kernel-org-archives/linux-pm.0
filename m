From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
Date: Wed, 11 Jul 2018 15:11:17 +0300
Message-ID: <849ea1c3434c87316f15953089633854e01938d6.1531310547.git.leonard.crestez@nxp.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1531310547.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

With old bindings imx_gpc_onecell_data always sets num_domains to 2 so
the DISPMIX domain can't actually be referenced. The pd is still defined
and pm core shuts it down as "unused" so display can't work.

Fix this by converting to new gpc bindings by adding pgc nodes and
referencing the newly-defined &pu_disp domain from &lcdif.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 102c575a6025..49a56b4fd393 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -698,14 +698,40 @@
 				reg = <0x020dc000 0x4000>;
 				interrupt-controller;
 				#interrupt-cells = <3>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
-				pu-supply = <&reg_pu>;
-				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
-					 <&clks IMX6SL_CLK_GPU2D_PODF>;
-				#power-domain-cells = <1>;
+				clocks = <&clks IMX6SL_CLK_IPG>;
+				clock-names = "ipg";
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@0 {
+						reg = <0>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_pu: power-domain@1 {
+						reg = <1>;
+						#power-domain-cells = <0>;
+						power-supply = <&reg_pu>;
+						clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
+						         <&clks IMX6SL_CLK_GPU2D_PODF>;
+					};
+
+					pd_disp: power-domain@2 {
+						reg = <2>;
+						#power-domain-cells = <0>;
+						clocks = <&clks IMX6SL_CLK_LCDIF_AXI>,
+							 <&clks IMX6SL_CLK_LCDIF_PIX>,
+							 <&clks IMX6SL_CLK_EPDC_AXI>,
+							 <&clks IMX6SL_CLK_EPDC_PIX>,
+							 <&clks IMX6SL_CLK_PXP_AXI>;
+					};
+				};
 			};
 
 			gpr: iomuxc-gpr@20e0000 {
 				compatible = "fsl,imx6sl-iomuxc-gpr",
 					     "fsl,imx6q-iomuxc-gpr", "syscon";
@@ -756,10 +782,11 @@
 				clocks = <&clks IMX6SL_CLK_LCDIF_PIX>,
 					 <&clks IMX6SL_CLK_LCDIF_AXI>,
 					 <&clks IMX6SL_CLK_DUMMY>;
 				clock-names = "pix", "axi", "disp_axi";
 				status = "disabled";
+				power-domains = <&pd_disp>;
 			};
 
 			dcp: dcp@20fc000 {
 				compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";
 				reg = <0x020fc000 0x4000>;
-- 
2.17.1
