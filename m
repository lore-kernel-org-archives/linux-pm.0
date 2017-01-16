From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 12/12] pinctrl: samsung: Replace syscore ops with standard
 platform device pm_ops
Date: Mon, 16 Jan 2017 07:45:07 +0100
Message-ID: <1484549107-5957-13-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064529eucas1p15b04f901b17dfa2b02fd04745cbe3f17@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Once the dependency on PMU driver (for pad retention control) has been
removed, there is no reason to use syscore_ops based suspend/resume.
This patch replaces it with standard platform device pm_ops based solution.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 72 ++++++-------------------------
 1 file changed, 13 insertions(+), 59 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 95a84086a2e9..48acf5908b84 100644
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
@@ -1081,22 +1077,18 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 
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
@@ -1133,15 +1125,17 @@ static void samsung_pinctrl_suspend_dev(
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->on)
 		drvdata->retention_ctrl->on(drvdata);
 
+	return 0;
 }
 
 /**
- * samsung_pinctrl_resume_dev - restore pinctrl state from suspend for a device
+ * samsung_pinctrl_resume - restore pinctrl state from suspend
  *
  * Restore one of the banks that was saved during suspend.
  */
-static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
+static int samsung_pinctrl_resume(struct device *dev)
 {
+	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
 	int i;
 
 	if (drvdata->resume)
@@ -1180,48 +1174,10 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
 
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->off)
 		drvdata->retention_ctrl->off(drvdata);
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
-
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
@@ -1263,25 +1219,23 @@ static void samsung_pinctrl_resume(void)
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
