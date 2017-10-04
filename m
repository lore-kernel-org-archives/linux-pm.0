From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 14/14] pinctrl: sh-pfc: Save/restore registers for PSCI system suspend
Date: Wed,  4 Oct 2017 11:07:13 +0200
Message-ID: <1507108033-8606-15-git-send-email-geert+renesas@glider.be>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:47600 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdJDJHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 05:07:21 -0400
In-Reply-To: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
pinctrl register state is lost.  Note that as the boot loader skips most
initialization after system resume, pinctrl register state differs from
the state encountered during normal system boot, too.

To fix this, save all GPIO and peripheral function select, module
select, drive strength control, bias, and other I/O control registers
during system suspend, and restore them during system resume.

Note that to avoid overhead on platforms not needing it, the
suspend/resume code has a build time dependency on sleep and PSCI
support, and a runtime dependency on PSCI.

Inspired by a patch in the BSP by Hien Dang.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c   | 97 +++++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/sh_pfc.h |  1 +
 2 files changed, 98 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 97be79b5be4dfb25..9139898fdfb6e6c9 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -24,6 +24,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
+#include <linux/psci.h>
 #include <linux/slab.h>
 
 #include "core.h"
@@ -570,6 +571,97 @@ static const struct of_device_id sh_pfc_of_table[] = {
 };
 #endif
 
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
+static void sh_pfc_nop_reg(struct sh_pfc *pfc, u32 reg, unsigned int idx)
+{
+}
+
+static void sh_pfc_save_reg(struct sh_pfc *pfc, u32 reg, unsigned int idx)
+{
+	pfc->saved_regs[idx] = sh_pfc_read_reg(pfc, reg);
+}
+
+static void sh_pfc_restore_reg(struct sh_pfc *pfc, u32 reg, unsigned int idx)
+{
+	sh_pfc_write_reg(pfc, reg, pfc->saved_regs[idx]);
+}
+
+static unsigned int sh_pfc_walk_regs(struct sh_pfc *pfc,
+	void (*do_reg)(struct sh_pfc *pfc, u32 reg, unsigned int idx))
+{
+	unsigned int i, n = 0;
+
+	if (pfc->info->cfg_regs)
+		for (i = 0; pfc->info->cfg_regs[i].reg; i++)
+			do_reg(pfc, pfc->info->cfg_regs[i].reg, n++);
+
+	if (pfc->info->drive_regs)
+		for (i = 0; pfc->info->drive_regs[i].reg; i++)
+			do_reg(pfc, pfc->info->drive_regs[i].reg, n++);
+
+	if (pfc->info->bias_regs)
+		for (i = 0; pfc->info->bias_regs[i].puen; i++) {
+			do_reg(pfc, pfc->info->bias_regs[i].puen, n++);
+			if (pfc->info->bias_regs[i].pud)
+				do_reg(pfc, pfc->info->bias_regs[i].pud, n++);
+		}
+
+	if (pfc->info->ioctrl_regs)
+		for (i = 0; pfc->info->ioctrl_regs[i].reg; i++)
+			do_reg(pfc, pfc->info->ioctrl_regs[i].reg, n++);
+
+	return n;
+}
+
+static int sh_pfc_suspend_init(struct sh_pfc *pfc)
+{
+	unsigned int n;
+
+	/* This is the best we can do to check for the presence of PSCI */
+	if (!psci_ops.cpu_suspend)
+		return 0;
+
+	n = sh_pfc_walk_regs(pfc, sh_pfc_nop_reg);
+	if (!n)
+		return 0;
+
+	pfc->saved_regs = devm_kmalloc_array(pfc->dev, n,
+					     sizeof(*pfc->saved_regs),
+					     GFP_KERNEL);
+	if (!pfc->saved_regs)
+		return -ENOMEM;
+
+	dev_dbg(pfc->dev, "Allocated space to save %u regs\n", n);
+	return 0;
+}
+
+static int sh_pfc_suspend_noirq(struct device *dev)
+{
+	struct sh_pfc *pfc = dev_get_drvdata(dev);
+
+	if (pfc->saved_regs)
+		sh_pfc_walk_regs(pfc, sh_pfc_save_reg);
+	return 0;
+}
+
+static int sh_pfc_resume_noirq(struct device *dev)
+{
+	struct sh_pfc *pfc = dev_get_drvdata(dev);
+
+	if (pfc->saved_regs)
+		sh_pfc_walk_regs(pfc, sh_pfc_restore_reg);
+	return 0;
+}
+
+static const struct dev_pm_ops sh_pfc_pm  = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sh_pfc_suspend_noirq, sh_pfc_resume_noirq)
+};
+#define DEV_PM_OPS	&sh_pfc_pm
+#else
+static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
+
 static int sh_pfc_probe(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
@@ -608,6 +700,10 @@ static int sh_pfc_probe(struct platform_device *pdev)
 		info = pfc->info;
 	}
 
+	ret = sh_pfc_suspend_init(pfc);
+	if (ret)
+		return ret;
+
 	/* Enable dummy states for those platforms without pinctrl support */
 	if (!of_have_populated_dt())
 		pinctrl_provide_dummies();
@@ -691,6 +787,7 @@ static struct platform_driver sh_pfc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.of_match_table = of_match_ptr(sh_pfc_of_table),
+		.pm     = DEV_PM_OPS,
 	},
 };
 
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index b9bb56c91b6fdaf3..213108a058feefb0 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -222,6 +222,7 @@ struct sh_pfc {
 	unsigned int nr_gpio_pins;
 
 	struct sh_pfc_chip *gpio;
+	u32 *saved_regs;
 };
 
 struct sh_pfc_soc_operations {
-- 
2.7.4
