From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 2/2] ARM: imx: enable imx6q-cpufreq support
Date: Mon, 14 Jan 2013 23:02:13 +0800
Message-ID: <1358175733-13475-3-git-send-email-shawn.guo@linaro.org>
References: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:21819
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756465Ab3ANPCG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jan 2013 10:02:06 -0500
In-Reply-To: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>

Update operating-points per hardware document and add support for
1 GHz and 1.2 GHz frequencies.

400 MHz, 800 MHz and 1 GHz should be supported by all i.MX6Q chips,
while 1.2 GHz support needs to know from OTP fuse bit.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi   |   20 +++++++++----
 arch/arm/mach-imx/mach-imx6q.c |   65 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d6265ca..231a32c 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -38,12 +38,19 @@
 			next-level-cache = <&L2>;
 			operating-points = <
 				/* kHz    uV */
-				792000  1100000
+				1200000 1275000
+				996000  1250000
+				792000  1150000
 				396000  950000
-				198000  850000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
-			cpu0-supply = <&reg_cpu>;
+			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
+				 <&clks 17>, <&clks 170>;
+			clock-names = "arm", "pll2_pfd2_396m", "step",
+				      "pll1_sw", "pll1_sys";
+			arm-supply = <&reg_arm>;
+			pu-supply = <&reg_pu>;
+			soc-supply = <&reg_soc>;
 		};
 
 		cpu@1 {
@@ -471,7 +478,7 @@
 					anatop-max-voltage = <2750000>;
 				};
 
-				reg_cpu: regulator-vddcore@140 {
+				reg_arm: regulator-vddcore@140 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "cpu";
 					regulator-min-microvolt = <725000>;
@@ -485,7 +492,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				regulator-vddpu@140 {
+				reg_pu: regulator-vddpu@140 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
@@ -499,7 +506,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				regulator-vddsoc@140 {
+				reg_soc: regulator-vddsoc@140 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
@@ -965,6 +972,7 @@
 			};
 
 			ocotp@021bc000 {
+				compatible = "fsl,imx6q-ocotp";
 				reg = <0x021bc000 0x4000>;
 			};
 
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4eb1b3a..2f974f5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/delay.h>
 #include <linux/export.h>
@@ -22,6 +23,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/opp.h>
 #include <linux/phy.h>
 #include <linux/regmap.h>
 #include <linux/micrel_phy.h>
@@ -209,9 +211,72 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
 	.state_count		= 1,
 };
 
+#define OCOTP_CFG3			0x440
+#define OCOTP_CFG3_SPEED_SHIFT		16
+#define OCOTP_CFG3_SPEED_1P2GHZ		0x3
+
+static void __init imx6q_opp_check_1p2ghz(struct device *cpu_dev)
+{
+	struct device_node *np;
+	void __iomem *base;
+	u32 val;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
+	if (!np) {
+		pr_warn("failed to find ocotp node\n");
+		return;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_warn("failed to map ocotp\n");
+		goto put_node;
+	}
+
+	val = readl_relaxed(base + OCOTP_CFG3);
+	val >>= OCOTP_CFG3_SPEED_SHIFT;
+	if ((val & 0x3) != OCOTP_CFG3_SPEED_1P2GHZ)
+		if (opp_disable(cpu_dev, 1200000000))
+			pr_warn("failed to disable 1.2 GHz OPP\n");
+
+put_node:
+	of_node_put(np);
+}
+
+static void __init imx6q_opp_init(struct device *cpu_dev)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_path("/cpus/cpu@0");
+	if (!np) {
+		pr_warn("failed to find cpu0 node\n");
+		return;
+	}
+
+	cpu_dev->of_node = np;
+	if (of_init_opp_table(cpu_dev)) {
+		pr_warn("failed to init OPP table\n");
+		goto put_node;
+	}
+
+	imx6q_opp_check_1p2ghz(cpu_dev);
+
+put_node:
+	of_node_put(np);
+}
+
+struct platform_device imx6q_cpufreq_pdev = {
+	.name = "imx6q-cpufreq",
+};
+
 static void __init imx6q_init_late(void)
 {
 	imx_cpuidle_init(&imx6q_cpuidle_driver);
+
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
+		imx6q_opp_init(&imx6q_cpufreq_pdev.dev);
+		platform_device_register(&imx6q_cpufreq_pdev);
+	}
 }
 
 static void __init imx6q_map_io(void)
-- 
1.7.9.5


