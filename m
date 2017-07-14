From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 5/5] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Fri, 14 Jul 2017 17:11:10 +0300
Message-ID: <09d1ea14043f3c4fedc3ecdf24c206e177fb976b.1500041281.git.leonard.crestez@nxp.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1500041281.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This works identically to imx6sx-tempmon on both imx6ul and imx6ull.
It just needs to be defined in dts.

Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
---
 arch/arm/boot/dts/imx6ul.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 6da2b77..9f8e4c0 100644
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
@@ -860,9 +869,19 @@
 			};
 
 			ocotp: ocotp-ctrl@021bc000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx6ul-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6UL_CLK_OCOTP>;
+
+				tempmon_calib: calib@38 {
+					reg = <0x38 4>;
+				};
+
+				tempmon_temp_grade: temp-grade@20 {
+					reg = <0x20 4>;
+				};
 			};
 
 			lcdif: lcdif@021c8000 {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
