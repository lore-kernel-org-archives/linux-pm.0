From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [RFC PATCH 6/8] clk: ux500: Add PRCC power management
Date: Fri, 22 Mar 2013 17:20:10 +0100
Message-ID: <1363969212-14864-7-git-send-email-rickard.andersson@stericsson.com>
References: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:53014 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933828Ab3CVQUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 12:20:30 -0400
In-Reply-To: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org
Cc: daniel.lezcano@linaro.org, hongbo.zhang@linaro.org, khilman@linaro.org, ulf.hansson@linaro.org, linus.walleij@stericsson.com, rickard.andersson@stericsson.com

When reaching a sleep state where the APE power domain
is being turned off the context of the PRCC block needs
to saved. When the power domain is turned on again the
context is restored in order for the PRCC clocks to
function correctly.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/clk/ux500/clk-prcc.c  | 59 ++++++++++++++++++++++++++++++-
 drivers/clk/ux500/clk.h       |  4 +++
 drivers/clk/ux500/u8500_clk.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index 7eee7f7..116da35 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2012 ST-Ericsson SA
  * Author: Ulf Hansson <ulf.hansson@linaro.org>
- *
+ *	   Rickard Andersson <rickard.andersson@stericsson.com>
+ *	   Jonas Aaberg <jonas.aberg@stericsson.com>
  * License terms: GNU General Public License (GPL) version 2
  */
 
@@ -17,6 +18,8 @@
 
 #include "clk.h"
 
+#define UX500_NR_PRCC_BANKS 5
+
 #define PRCC_PCKEN			0x000
 #define PRCC_PCKDIS			0x004
 #define PRCC_KCKEN			0x008
@@ -33,6 +36,12 @@ struct clk_prcc {
 	int is_enabled;
 };
 
+static struct {
+	void __iomem *base;
+	u32 bus_clk;
+	u32 kern_clk;
+} context_prcc[UX500_NR_PRCC_BANKS];
+
 /* PRCC clock operations. */
 
 static int clk_prcc_pclk_enable(struct clk_hw *hw)
@@ -162,3 +171,51 @@ struct clk *clk_reg_prcc_kclk(const char *name,
 	return clk_reg_prcc(name, parent_name, phy_base, cg_sel, flags,
 			&clk_prcc_kclk_ops);
 }
+
+void clk_prcc_save_context(void)
+{
+	int i;
+
+	for (i = 0; i < UX500_NR_PRCC_BANKS; i++) {
+		context_prcc[i].bus_clk =
+			readl(context_prcc[i].base + PRCC_PCKSR);
+		context_prcc[i].kern_clk =
+			readl(context_prcc[i].base + PRCC_KCKSR);
+	}
+}
+
+void clk_prcc_restore_context(void)
+{
+	int i;
+
+	for (i = 0; i < UX500_NR_PRCC_BANKS; i++) {
+		writel(~context_prcc[i].bus_clk,
+		       context_prcc[i].base + PRCC_PCKDIS);
+		writel(~context_prcc[i].kern_clk,
+		       context_prcc[i].base + PRCC_KCKDIS);
+
+		writel(context_prcc[i].bus_clk,
+		       context_prcc[i].base + PRCC_PCKEN);
+		writel(context_prcc[i].kern_clk,
+		       context_prcc[i].base + PRCC_KCKEN);
+	}
+}
+
+int __init clk_prcc_init(void)
+{
+	/* PERIPH4 is always on, so no need saving prcc */
+	context_prcc[0].base = ioremap(U8500_CLKRST1_BASE, SZ_4K);
+	context_prcc[1].base = ioremap(U8500_CLKRST2_BASE, SZ_4K);
+	context_prcc[2].base = ioremap(U8500_CLKRST3_BASE, SZ_4K);
+	context_prcc[3].base = ioremap(U8500_CLKRST5_BASE, SZ_4K);
+	context_prcc[4].base = ioremap(U8500_CLKRST6_BASE, SZ_4K);
+
+	if (!context_prcc[0].base
+	    || !context_prcc[1].base
+	    || !context_prcc[2].base
+	    || !context_prcc[3].base
+	    || !context_prcc[4].base)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/drivers/clk/ux500/clk.h b/drivers/clk/ux500/clk.h
index c3e4491..7936b67 100644
--- a/drivers/clk/ux500/clk.h
+++ b/drivers/clk/ux500/clk.h
@@ -57,4 +57,8 @@ struct clk *clk_reg_prcmu_opp_volt_scalable(const char *name,
 					    unsigned long rate,
 					    unsigned long flags);
 
+void clk_prcc_save_context(void);
+void clk_prcc_restore_context(void);
+int __init clk_prcc_init(void);
+
 #endif /* __UX500_CLK_H */
diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 6b889a0..0c4319d 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -12,9 +12,19 @@
 #include <linux/clk-provider.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/platform_data/clk-ux500.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <mach/db8500-regs.h>
 #include "clk.h"
 
+/*
+ * Number of PRCC parent clocks that needs to be
+ * enabled when saving/restoring PRCC context.
+ */
+#define NR_PRCC_PARENT_CLOCKS 5
+
+struct clk *prcc_context_parent[NR_PRCC_PARENT_CLOCKS];
+
 void u8500_clk_init(void)
 {
 	struct prcmu_fw_version *fw_version;
@@ -522,3 +532,75 @@ void u8500_clk_init(void)
 			U8500_CLKRST6_BASE, BIT(0), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "rng");
 }
+
+static void prcc_parents_enable(bool enable)
+{
+	int i;
+
+	for (i = 0; i < NR_PRCC_PARENT_CLOCKS; i++) {
+		if (enable)
+			clk_enable(prcc_context_parent[i]);
+		else
+			clk_disable(prcc_context_parent[i]);
+	}
+}
+
+static int prcc_context_call(struct notifier_block *this,
+				 unsigned long event, void *data)
+{
+	bool power_on = (bool)event;
+
+	prcc_parents_enable(true);
+
+	if (power_on)
+		clk_prcc_restore_context();
+	else
+		clk_prcc_save_context();
+
+	prcc_parents_enable(false);
+
+	return 0;
+}
+
+static struct notifier_block prcc_context_notifier = {
+	.notifier_call = prcc_context_call,
+};
+
+static struct platform_driver u8500_clk_plat_driver = {
+	.driver = {
+		.name = "u8500-clk",
+	},
+};
+
+static int __init u8500_clk_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+
+	ret = clk_prcc_init();
+	if (ret)
+		return ret;
+
+	for (i = 0; i < NR_PRCC_PARENT_CLOCKS; i++) {
+		const int clusters[] = {1, 2, 3, 5, 6};
+		char clkname[10];
+
+		snprintf(clkname, sizeof(clkname), "PERIPH%d", clusters[i]);
+
+		prcc_context_parent[i] = clk_get_sys(clkname, NULL);
+		BUG_ON(IS_ERR(prcc_context_parent[i]));
+		clk_prepare(prcc_context_parent[i]);
+	}
+
+	ret = pm_genpd_register_on_off_notifier(&pdev->dev,
+						&prcc_context_notifier);
+	return ret;
+}
+
+static int __init u8500_clk_arch_init(void)
+{
+	return platform_driver_probe(&u8500_clk_plat_driver,
+				     u8500_clk_probe);
+}
+
+arch_initcall(u8500_clk_arch_init);
-- 
1.8.2

