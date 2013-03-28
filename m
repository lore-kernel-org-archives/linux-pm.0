From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 06/12] clk: ux500: Add PRCC power management
Date: Thu, 28 Mar 2013 17:11:32 +0100
Message-ID: <1364487098-10319-7-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hongbo.zhang@linaro.org, ulf.hansson@linaro.org, khilman@linaro.org, linus.walleij@stericsson.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com
List-Id: linux-pm@vger.kernel.org

When reaching a sleep state where the APE power domain
is being turned off the context of the PRCC block needs
to saved. When the power domain is turned on again the
context is restored in order for the PRCC clocks to
function correctly.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/clk/ux500/clk-prcc.c  | 71 ++++++++++++++++++++++++++++++++++++-
 drivers/clk/ux500/clk.h       |  5 +++
 drivers/clk/ux500/u8500_clk.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index 7eee7f7..01739f7 100644
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
 
@@ -13,10 +14,13 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/types.h>
+#include <linux/platform_device.h>
 #include <mach/hardware.h>
 
 #include "clk.h"
 
+#define UX500_NR_PRCC_BANKS 5
+
 #define PRCC_PCKEN			0x000
 #define PRCC_PCKDIS			0x004
 #define PRCC_KCKEN			0x008
@@ -33,6 +37,12 @@ struct clk_prcc {
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
@@ -162,3 +172,62 @@ struct clk *clk_reg_prcc_kclk(const char *name,
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
+int __init clk_prcc_init(struct platform_device *pdev)
+{
+	int i;
+	struct resource *res;
+	int ret = 0;
+
+	for (i = 0; i < UX500_NR_PRCC_BANKS; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res) {
+			ret = -EINVAL;
+			goto err_iounmap;
+		}
+
+		context_prcc[i].base = ioremap(res->start, resource_size(res));
+		if (!context_prcc[i].base) {
+			ret = -ENOMEM;
+			goto err_iounmap;
+		}
+	}
+
+	return ret;
+
+ err_iounmap:
+	for (i = 0; i < UX500_NR_PRCC_BANKS; i++) {
+		if (context_prcc[i].base)
+			iounmap(context_prcc[i].base);
+	}
+	return ret;
+}
diff --git a/drivers/clk/ux500/clk.h b/drivers/clk/ux500/clk.h
index c3e4491..3394fb8 100644
--- a/drivers/clk/ux500/clk.h
+++ b/drivers/clk/ux500/clk.h
@@ -11,6 +11,7 @@
 #define __UX500_CLK_H
 
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 
 struct clk *clk_reg_prcc_pclk(const char *name,
 			      const char *parent_name,
@@ -57,4 +58,8 @@ struct clk *clk_reg_prcmu_opp_volt_scalable(const char *name,
 					    unsigned long rate,
 					    unsigned long flags);
 
+void clk_prcc_save_context(void);
+void clk_prcc_restore_context(void);
+int __init clk_prcc_init(struct platform_device *pdev);
+
 #endif /* __UX500_CLK_H */
diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 6b889a0..63ed580 100644
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
+	ret = clk_prcc_init(pdev);
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
