From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 4/4] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Thu, 6 Jul 2017 16:20:44 +0300
Message-ID: <168ad5725d842b32133b413f5424694f096bfa4b.1499347157.git.leonard.crestez@nxp.com>
References: <cover.1499347157.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499347157.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This works identically to imx6sx-tempmon on both imx6ul and imx6ull.
It just needs to be defined in dts.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 6da2b77..60084eb 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -598,6 +598,15 @@
 				fsl,anatop = <&anatop>;
 			};
 
+			tempmon: tempmon {
+				compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,tempmon = <&anatop>;
+				nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+				nvmem-cell-names = "calib", "temp_grade";
+				clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+			};
+
 			snvs: snvs@020cc000 {
 				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
 				reg = <0x020cc000 0x4000>;
@@ -860,9 +869,17 @@
 			};
 
 			ocotp: ocotp-ctrl@021bc000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx6ul-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6UL_CLK_OCOTP>;
+				tempmon_calib: calib {
+					reg = <56 4>;
+				};
+				tempmon_temp_grade: temp_grade {
+					reg = <32 4>;
+				};
 			};
 
 			lcdif: lcdif@021c8000 {
-- 
2.7.4
