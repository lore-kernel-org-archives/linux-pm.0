From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/1] ARM: imx7ulp: add cpuidle support
Date: Sun, 27 Aug 2017 21:43:41 +0800
Message-ID: <1503841421-17677-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-dm3nam03on0072.outbound.protection.outlook.com ([104.47.41.72]:41121
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751338AbdH0NoS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Aug 2017 09:44:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>

i.MX7ULP support 3 levels idle as below:
1. patial stop mode 3;
2. patial stop mode 2;
3. patial stop mode 1.

PSTOP1 - Partial Stop with system and bus clock disabled
PSTOP2 - Partial Stop with system clock disabled and bus clock enabled
PSTOP3 - Partial Stop with system clock enabled and bus clock enabled

For PSTOP 1/2 mode, as the system and bus clock will be disabled, the
devices working inprogress may not be able to work anymore, driver needs
to use pm_qos API to prevent system enter those modes.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm/mach-imx/Makefile          |  1 +
 arch/arm/mach-imx/common.h          | 12 +++++++
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 69 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h         |  5 +++
 arch/arm/mach-imx/mach-imx7ulp.c    |  7 ++++
 arch/arm/mach-imx/pm-imx7ulp.c      | 65 +++++++++++++++++++++++++++++++---
 6 files changed, 155 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx7ulp.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index c5948b7..a3f55a9 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX7ULP) += cpuidle-imx7ulp.o
 endif
 
 ifdef CONFIG_SND_IMX_SOC
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index b0e85df..9b78902 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -78,6 +78,17 @@ enum mx3_cpu_pwr_mode {
 	MX3_SLEEP,
 };
 
+enum imx7ulp_cpu_pwr_mode {
+	HSRUN,
+	RUN,
+	VLPR,
+	WAIT,
+	VLPW,
+	STOP,
+	VLPS,
+	VLLS,
+};
+
 void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
 
 void imx_enable_cpu(int cpu, bool enable);
@@ -106,6 +117,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
+int imx7ulp_set_lpm(enum imx7ulp_cpu_pwr_mode mode);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-imx/cpuidle-imx7ulp.c b/arch/arm/mach-imx/cpuidle-imx7ulp.c
new file mode 100644
index 0000000..f165d85
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx7ulp.c
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright (C) 2017 NXP.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <asm/cpuidle.h>
+
+#include "common.h"
+#include "cpuidle.h"
+#include "hardware.h"
+
+static int imx7ulp_enter_idle(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv, int index)
+{
+	switch (index) {
+	case 1:
+		imx7ulp_set_lpm(WAIT);
+		break;
+	case 2:
+		imx7ulp_set_lpm(STOP);
+		break;
+	default:
+		break;
+	}
+
+	cpu_do_idle();
+
+	imx7ulp_set_lpm(RUN);
+
+	return index;
+}
+
+static struct cpuidle_driver imx7ulp_cpuidle_driver = {
+	.name = "imx7ulp_cpuidle",
+	.owner = THIS_MODULE,
+	.states = {
+		/* WFI */
+		ARM_CPUIDLE_WFI_STATE,
+		/* WAIT */
+		{
+			.exit_latency = 50,
+			.target_residency = 75,
+			.enter = imx7ulp_enter_idle,
+			.name = "WAIT",
+			.desc = "PSTOP2",
+		},
+		/* STOP */
+		{
+			.exit_latency = 100,
+			.target_residency = 150,
+			.enter = imx7ulp_enter_idle,
+			.name = "STOP",
+			.desc = "PSTOP1",
+		},
+	},
+	.state_count = 3,
+	.safe_state_index = 0,
+};
+
+int __init imx7ulp_cpuidle_init(void)
+{
+	return cpuidle_register(&imx7ulp_cpuidle_driver, NULL);
+}
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index f914012..7694c8f 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -15,6 +15,7 @@ extern int imx5_cpuidle_init(void);
 extern int imx6q_cpuidle_init(void);
 extern int imx6sl_cpuidle_init(void);
 extern int imx6sx_cpuidle_init(void);
+extern int imx7ulp_cpuidle_init(void);
 #else
 static inline int imx5_cpuidle_init(void)
 {
@@ -32,4 +33,8 @@ static inline int imx6sx_cpuidle_init(void)
 {
 	return 0;
 }
+static inline int imx7ulp_cpuidle_init(void)
+{
+	return 0;
+}
 #endif
diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
index 9f7a25c..1d8fe71 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -15,8 +15,14 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
+#include "cpuidle.h"
 #include "hardware.h"
 
+static void __init imx7ulp_init_late(void)
+{
+	imx7ulp_cpuidle_init();
+}
+
 static void __init imx7ulp_init_machine(void)
 {
 	imx7ulp_pm_init();
@@ -33,5 +39,6 @@ static const char *const imx7ulp_dt_compat[] __initconst = {
 
 DT_MACHINE_START(IMX7ulp, "Freescale i.MX7ULP (Device Tree)")
 	.init_machine	= imx7ulp_init_machine,
+	.init_late	= imx7ulp_init_late,
 	.dt_compat	= imx7ulp_dt_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index df5d6b6..5f85040 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -14,20 +14,77 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include "common.h"
+
+/* SMC registers */
+#define SMC_PMPROT		0x8
 #define SMC_PMCTRL		0x10
+#define SMC_PMSTAT		0x18
+#define SMC_SRS			0x20
+#define SMC_RPC			0x24
+#define SMC_SSRS		0x28
+#define SMC_SRIE		0x2c
+#define SMC_SRIF		0x30
+#define SMC_CSRE		0x34
+#define SMC_MR			0x40
+#define SMC_FM			0x40
+
+/* PMPROT */
+#define BM_PMPROT_AHSRUN        BIT(7)
+#define BM_PMPROT_AVLP          BIT(5)
+#define BM_PMPROT_ALLS          BIT(3)
+#define BM_PMPROT_AVLLS         BIT(1)
+
+/* PMCTRL */
+#define BM_PMCTRL_STOPA         (0x1 << 24)
 #define BP_PMCTRL_PSTOPO        16
+#define BM_PMCTRL_PSTOPO        (0x3 << BP_PMCTRL_PSTOPO)
+#define BP_PMCTRL_RUNM		8
+#define BM_PMCTRL_RUNM          (0x3 << BP_PMCTRL_RUNM)
+#define BP_PMCTRL_STOPM		0
+#define BM_PMCTRL_STOPM         (0x7 << BP_PMCTRL_STOPM)
+
 #define PSTOPO_PSTOP3		0x3
+#define PSTOPO_PSTOP2		0x2
+#define PSTOPO_PSTOP1		0x1
+
+static void __iomem *smc1_base;
+
+int imx7ulp_set_lpm(enum imx7ulp_cpu_pwr_mode mode)
+{
+	u32 smc_ctrl = readl_relaxed(smc1_base + SMC_PMCTRL);
+
+	smc_ctrl &= ~(BM_PMCTRL_RUNM | BM_PMCTRL_STOPM | BM_PMCTRL_PSTOPO);
+
+	switch (mode) {
+	case RUN:
+		/* system/bus clock enabled */
+		smc_ctrl |= PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO;
+		break;
+	case WAIT:
+		/* system clock disabled, bus clock enabled */
+		smc_ctrl |= PSTOPO_PSTOP2 << BP_PMCTRL_PSTOPO;
+		break;
+	case STOP:
+		/* system/bus clock disabled */
+		smc_ctrl |= PSTOPO_PSTOP1 << BP_PMCTRL_PSTOPO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(smc_ctrl, smc1_base + SMC_PMCTRL);
+
+	return 0;
+}
 
 void __init imx7ulp_pm_init(void)
 {
 	struct device_node *np;
-	void __iomem *smc1_base;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
 	smc1_base = of_iomap(np, 0);
 	WARN_ON(!smc1_base);
 
-	/* Partial Stop mode 3 with system/bus clock enabled */
-	writel_relaxed(PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO,
-		       smc1_base + SMC_PMCTRL);
+	imx7ulp_set_lpm(RUN);
 }
-- 
2.7.4
