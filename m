From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 6/8] ARM i.MX5: Add System Reset Controller (SRC) support for i.MX51 and i.MX53
Date: Mon, 25 Mar 2013 18:06:27 +0100
Message-ID: <1364231189-12497-7-git-send-email-p.zabel@pengutronix.de>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35140 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333Ab3CYRHV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 13:07:21 -0400
In-Reply-To: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

The SRC in i.MX51 and i.MX53 is similar to the one in i.MX6q minus
the IPU2 reset line and multi core CPU reset/enable bits.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/mach-imx/Kconfig      | 2 ++
 arch/arm/mach-imx/mm-imx5.c    | 2 ++
 arch/arm/mach-imx/src.c        | 4 +++-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 3e21e92..fb71499 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -513,7 +513,7 @@
 			};
 
 			src: src@020d8000 {
-				compatible = "fsl,imx6q-src";
+				compatible = "fsl,imx6q-src", "fsl,imx51-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 0x04 0 96 0x04>;
 				#reset-cells = <1>;
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5052e31..857c1fb 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -166,6 +166,7 @@ config	SOC_IMX51
 	bool
 	select ARCH_MX5
 	select ARCH_MX51
+	select HAVE_IMX_SRC
 	select PINCTRL
 	select PINCTRL_IMX51
 	select SOC_IMX5
@@ -793,6 +794,7 @@ config	SOC_IMX53
 	select ARCH_MX5
 	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
+	select HAVE_IMX_SRC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select PINCTRL
 	select PINCTRL_IMX53
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index cf34994..b7c4e70 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -84,6 +84,7 @@ void __init imx51_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
+	imx_src_init();
 }
 
 void __init imx53_init_early(void)
@@ -91,6 +92,7 @@ void __init imx53_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX53);
 	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG1_BASE_ADDR));
+	imx_src_init();
 }
 
 void __init mx51_init_irq(void)
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index b50eee0..bc4d2c7 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -121,7 +121,9 @@ void __init imx_src_init(void)
 	struct device_node *np;
 	u32 val;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx51-src");
+	if (!np)
+		return;
 	src_base = of_iomap(np, 0);
 	WARN_ON(!src_base);
 
-- 
1.8.2.rc2

