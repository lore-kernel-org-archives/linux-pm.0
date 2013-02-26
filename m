From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 3/8] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets to System Reset Controller (SRC)
Date: Tue, 26 Feb 2013 12:39:29 +0100
Message-ID: <1361878774-6382-4-git-send-email-p.zabel@pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54341 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273Ab3BZLkD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 06:40:03 -0500
In-Reply-To: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

The SRC has auto-deasserting reset bits that control reset lines to
the GPU, VPU, IPU, and OpenVG IP modules. This patch adds a reset
controller that can be controlled by those devices using the
reset controller API.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
Changes since v3:
 - Renamed imx_src_reset to imx_src_reset_module
 - Set rcdev.nr_resets
---
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 +++++++++++++++
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/src.c                            |   65 ++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
new file mode 100644
index 0000000..1330177
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.txt
@@ -0,0 +1,49 @@
+Freescale i.MX System Reset Controller
+======================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be "fsl,<chip>-src"
+- reg: should be register base and length as documented in the
+  datasheet
+- interrupts: Should contain SRC interrupt and CPU WDOG interrupt,
+  in this order.
+- #reset-cells: 1, see below
+
+example:
+
+src: src@020d8000 {
+        compatible = "fsl,imx6q-src";
+        reg = <0x020d8000 0x4000>;
+        interrupts = <0 91 0x04 0 96 0x04>;
+        #reset-cells = <1>;
+};
+
+Specifying reset lines connected to IP modules
+==============================================
+
+The system reset controller can be used to reset the GPU, VPU,
+IPU, and OpenVG IP modules on i.MX5 and i.MX6 ICs. Those device
+nodes should specify the reset line on the SRC in their resets
+property, containing a phandle to the SRC device node and a
+RESET_INDEX specifying which module to reset, as described in
+reset.txt
+
+example:
+
+        ipu1: ipu@02400000 {
+                resets = <&src 2>;
+        };
+        ipu2: ipu@02800000 {
+                resets = <&src 4>;
+        };
+
+The following RESET_INDEX values are valid for i.MX5:
+GPU_RESET     0
+VPU_RESET     1
+IPU1_RESET    2
+OPEN_VG_RESET 3
+The following additional RESET_INDEX value is valid for i.MX6:
+IPU2_RESET    4
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4c9c6f9..5052e31 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -73,6 +73,7 @@ config HAVE_IMX_MMDC
 
 config HAVE_IMX_SRC
 	def_bool y if SMP
+	select ARCH_HAS_RESET_CONTROLLER
 
 config IMX_HAVE_IOMUX_V1
 	bool
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index e15f155..b50eee0 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -14,16 +14,72 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/reset-controller.h>
 #include <linux/smp.h>
 #include <asm/smp_plat.h>
 
 #define SRC_SCR				0x000
 #define SRC_GPR1			0x020
 #define BP_SRC_SCR_WARM_RESET_ENABLE	0
+#define BP_SRC_SCR_SW_GPU_RST		1
+#define BP_SRC_SCR_SW_VPU_RST		2
+#define BP_SRC_SCR_SW_IPU1_RST		3
+#define BP_SRC_SCR_SW_OPEN_VG_RST	4
+#define BP_SRC_SCR_SW_IPU2_RST		12
 #define BP_SRC_SCR_CORE1_RST		14
 #define BP_SRC_SCR_CORE1_ENABLE		22
 
 static void __iomem *src_base;
+static DEFINE_SPINLOCK(scr_lock);
+
+static const int sw_reset_bits[5] = {
+	BP_SRC_SCR_SW_GPU_RST,
+	BP_SRC_SCR_SW_VPU_RST,
+	BP_SRC_SCR_SW_IPU1_RST,
+	BP_SRC_SCR_SW_OPEN_VG_RST,
+	BP_SRC_SCR_SW_IPU2_RST
+};
+
+static int imx_src_reset_module(struct reset_controller_dev *rcdev,
+		unsigned long sw_reset_idx)
+{
+	unsigned long timeout;
+	unsigned long flags;
+	int bit;
+	u32 val;
+
+	if (!src_base)
+		return -ENODEV;
+
+	if (sw_reset_idx >= ARRAY_SIZE(sw_reset_bits))
+		return -EINVAL;
+
+	bit = 1 << sw_reset_bits[sw_reset_idx];
+
+	spin_lock_irqsave(&scr_lock, flags);
+	val = readl_relaxed(src_base + SRC_SCR);
+	val |= bit;
+	writel_relaxed(val, src_base + SRC_SCR);
+	spin_unlock_irqrestore(&scr_lock, flags);
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (readl(src_base + SRC_SCR) & bit) {
+		if (time_after(jiffies, timeout))
+			return -ETIME;
+		cpu_relax();
+	}
+
+	return 0;
+}
+
+static struct reset_control_ops imx_src_ops = {
+	.reset = imx_src_reset_module,
+};
+
+static struct reset_controller_dev imx_reset_controller = {
+	.ops = &imx_src_ops,
+	.nr_resets = ARRAY_SIZE(sw_reset_bits),
+};
 
 void imx_enable_cpu(int cpu, bool enable)
 {
@@ -31,9 +87,11 @@ void imx_enable_cpu(int cpu, bool enable)
 
 	cpu = cpu_logical_map(cpu);
 	mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
+	spin_lock(&scr_lock);
 	val = readl_relaxed(src_base + SRC_SCR);
 	val = enable ? val | mask : val & ~mask;
 	writel_relaxed(val, src_base + SRC_SCR);
+	spin_unlock(&scr_lock);
 }
 
 void imx_set_cpu_jump(int cpu, void *jump_addr)
@@ -48,9 +106,11 @@ void imx_src_prepare_restart(void)
 	u32 val;
 
 	/* clear enable bits of secondary cores */
+	spin_lock(&scr_lock);
 	val = readl_relaxed(src_base + SRC_SCR);
 	val &= ~(0x7 << BP_SRC_SCR_CORE1_ENABLE);
 	writel_relaxed(val, src_base + SRC_SCR);
+	spin_unlock(&scr_lock);
 
 	/* clear persistent entry register of primary core */
 	writel_relaxed(0, src_base + SRC_GPR1);
@@ -65,11 +125,16 @@ void __init imx_src_init(void)
 	src_base = of_iomap(np, 0);
 	WARN_ON(!src_base);
 
+	imx_reset_controller.of_node = np;
+	reset_controller_register(&imx_reset_controller);
+
 	/*
 	 * force warm reset sources to generate cold reset
 	 * for a more reliable restart
 	 */
+	spin_lock(&scr_lock);
 	val = readl_relaxed(src_base + SRC_SCR);
 	val &= ~(1 << BP_SRC_SCR_WARM_RESET_ENABLE);
 	writel_relaxed(val, src_base + SRC_SCR);
+	spin_unlock(&scr_lock);
 }
-- 
1.7.10.4

