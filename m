From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 3/3] ARM: dts: imx: add cooling-cells for cpufreq cooling device
Date: Mon, 14 May 2018 16:09:19 +0800
Message-ID: <1526285359-17978-3-git-send-email-Anson.Huang@nxp.com>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add #cooling-cells for i.MX6/7 SoCs for cpufreq
cooling device usage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 1 +
 arch/arm/boot/dts/imx6q.dtsi  | 1 +
 arch/arm/boot/dts/imx6sl.dtsi | 1 +
 arch/arm/boot/dts/imx6sx.dtsi | 1 +
 arch/arm/boot/dts/imx6ul.dtsi | 1 +
 arch/arm/boot/dts/imx7d.dtsi  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 558bce8..b830dfd 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -39,6 +39,7 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6QDL_CLK_ARM>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
 				 <&clks IMX6QDL_CLK_STEP>,
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ae7b3f1..ac9f5cb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -44,6 +44,7 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6QDL_CLK_ARM>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
 				 <&clks IMX6QDL_CLK_STEP>,
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ab6a7e2..d35d4e9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -65,6 +65,7 @@
 				396000          1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>,
 					<&clks IMX6SL_CLK_STEP>, <&clks IMX6SL_CLK_PLL1_SW>,
 					<&clks IMX6SL_CLK_PLL1_SYS>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205..966e39a 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -83,6 +83,7 @@
 				198000	    1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			clocks = <&clks IMX6SX_CLK_ARM>,
 				 <&clks IMX6SX_CLK_PLL2_PFD2>,
 				 <&clks IMX6SX_CLK_STEP>,
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1241972..14b6ac7 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -66,6 +66,7 @@
 			device_type = "cpu";
 			reg = <0>;
 			clock-latency = <61036>; /* two CLK32 periods */
+			#cooling-cells = <2>;
 			operating-points = <
 				/* kHz	uV */
 				696000	1275000
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 200714e..49913717 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -53,6 +53,7 @@
 				792000	975000
 			>;
 			clock-frequency = <996000000>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
-- 
2.7.4
