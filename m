From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 13/13] pinctrl: samsung: Replace syscore ops with standard
 platform device pm_ops
Date: Thu, 19 Jan 2017 14:48:53 +0100
Message-ID: <1484833733-16082-14-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134910eucas1p1984006fbecb55a48c47ea72e9766cd12@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:60332 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdASNtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 08:49:50 -0500
In-reply-to: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Once the dependency on PMU driver (for pad retention control) has been
removed, there is no reason to use syscore_ops based suspend/resume.
This patch replaces it with standard platform device pm_ops based solution.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 72 ++++++-------------------------
 1 file changed, 14 insertions(+), 58 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 021abd7221f8..d79eadad6c5f 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -29,7 +29,6 @@
 #include <linux/irqdomain.h>
 #include <linux/of_device.h>
 #include <linux/spinlock.h>
-#include <linux/syscore_ops.h>
 
 #include "../core.h"
 #include "pinctrl-samsung.h"
@@ -49,9 +48,6 @@
 	{ "samsung,pin-val", PINCFG_TYPE_DAT },
 };
 
-/* Global list of devices (struct samsung_pinctrl_drv_data) */
-static LIST_HEAD(drvdata_list);
-
 static unsigned int pin_base;
 
 static int samsung_get_group_count(struct pinctrl_dev *pctldev)
@@ -1084,22 +1080,18 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, drvdata);
 
-	/* Add to the global list */
-	list_add_tail(&drvdata->node, &drvdata_list);
-
 	return 0;
 }
 
 #ifdef CONFIG_PM
-
 /**
- * samsung_pinctrl_suspend_dev - save pinctrl state for suspend for a device
+ * samsung_pinctrl_suspend - save pinctrl state for suspend
  *
  * Save data for all banks handled by this device.
  */
-static void samsung_pinctrl_suspend_dev(
-	struct samsung_pinctrl_drv_data *drvdata)
+static int samsung_pinctrl_suspend(struct device *dev)
 {
+	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
@@ -1135,18 +1127,21 @@ static void samsung_pinctrl_suspend_dev(
 		drvdata->suspend(drvdata);
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
 		drvdata->retention_ctrl->enable(drvdata);
+
+	return 0;
 }
 
 /**
- * samsung_pinctrl_resume_dev - restore pinctrl state from suspend for a device
+ * samsung_pinctrl_resume - restore pinctrl state from suspend
  *
  * Restore one of the banks that was saved during suspend.
  *
  * We don't bother doing anything complicated to avoid glitching lines since
  * we're called before pad retention is turned off.
  */
-static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
+static int samsung_pinctrl_resume(struct device *dev)
 {
+	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
 	int i;
 
 	if (drvdata->resume)
@@ -1185,48 +1180,11 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->disable)
 		drvdata->retention_ctrl->disable(drvdata);
-}
-
-/**
- * samsung_pinctrl_suspend - save pinctrl state for suspend
- *
- * Save data for all banks across all devices.
- */
-static int samsung_pinctrl_suspend(void)
-{
-	struct samsung_pinctrl_drv_data *drvdata;
-
-	list_for_each_entry(drvdata, &drvdata_list, node) {
-		samsung_pinctrl_suspend_dev(drvdata);
-	}
 
 	return 0;
 }
-
-/**
- * samsung_pinctrl_resume - restore pinctrl state for suspend
- *
- * Restore data for all banks across all devices.
- */
-static void samsung_pinctrl_resume(void)
-{
-	struct samsung_pinctrl_drv_data *drvdata;
-
-	list_for_each_entry_reverse(drvdata, &drvdata_list, node) {
-		samsung_pinctrl_resume_dev(drvdata);
-	}
-}
-
-#else
-#define samsung_pinctrl_suspend		NULL
-#define samsung_pinctrl_resume		NULL
 #endif
 
-static struct syscore_ops samsung_pinctrl_syscore_ops = {
-	.suspend	= samsung_pinctrl_suspend,
-	.resume		= samsung_pinctrl_resume,
-};
-
 static const struct of_device_id samsung_pinctrl_dt_match[] = {
 #ifdef CONFIG_PINCTRL_EXYNOS
 	{ .compatible = "samsung,exynos3250-pinctrl",
@@ -1268,25 +1226,23 @@ static void samsung_pinctrl_resume(void)
 };
 MODULE_DEVICE_TABLE(of, samsung_pinctrl_dt_match);
 
+static const struct dev_pm_ops samsung_pinctrl_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(samsung_pinctrl_suspend,
+				     samsung_pinctrl_resume)
+};
+
 static struct platform_driver samsung_pinctrl_driver = {
 	.probe		= samsung_pinctrl_probe,
 	.driver = {
 		.name	= "samsung-pinctrl",
 		.of_match_table = samsung_pinctrl_dt_match,
 		.suppress_bind_attrs = true,
+		.pm = &samsung_pinctrl_pm_ops,
 	},
 };
 
 static int __init samsung_pinctrl_drv_register(void)
 {
-	/*
-	 * Register syscore ops for save/restore of registers across suspend.
-	 * It's important to ensure that this driver is running at an earlier
-	 * initcall level than any arch-specific init calls that install syscore
-	 * ops that turn off pad retention (like exynos_pm_resume).
-	 */
-	register_syscore_ops(&samsung_pinctrl_syscore_ops);
-
 	return platform_driver_register(&samsung_pinctrl_driver);
 }
 postcore_initcall(samsung_pinctrl_drv_register);
-- 
1.9.1

