From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH v3 3/3] PM / i2c: designware: Clean up system sleep handling
Date: Wed, 06 Sep 2017 01:48:50 +0200
Message-ID: <2320454.WkIRgD8XIu@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3958866.l2qnKDbinI@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46670 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754559AbdIFABz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Sep 2017 20:01:55 -0400
In-Reply-To: <3958866.l2qnKDbinI@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit a23318feeff6 (i2c: designware: Fix system suspend)
the i2c-designware-platdrv driver always resumes the device in its
system sleep ->suspend callback which isn't particularly nice,
even though it is technically correct.

A better approach would be to make the driver track the PM state of
the device so that it doesn't need to resume it in ->suspend, so
implement it.

First, drop dw_i2c_plat_suspend() added by commit a23318feeff6 and
rename dw_i2c_plat_runtime_suspend() back to dw_i2c_plat_suspend().

Second, point the driver's ->late_suspend and ->early_resume
callbacks, rather than its ->suspend and ->resume callbacks,
to dw_i2c_plat_suspend() and dw_i2c_plat_resume(), respectively,
so that they are not executed in parallel with each other, for
example if runtime resume of the device takes place during system
suspend.

Finally, add "suspended" and "skip_resume" flags to struct dw_i2c_dev
and make dw_i2c_plat_suspend() and dw_i2c_plat_resume() use them to
avoid suspending or resuming the device twice in a row and to avoid
resuming a previously runtime-suspended device during system resume.

Overrides: a23318feeff6 (i2c: designware: Fix system suspend)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
  Add the "suspended" flag, which is needed, because
  dw_i2c_plat_suspend() doesn't update the runtime PM status of
  the device, so dw_i2c_plat_resume() can't rely on this check
  during system resume.

v2 -> v3:
  Keep the ->prepare and ->complete system sleep callbacks as
  direct_complete is still useful for helping to avoid resuming
  the parent of this device in the intel-lpss case.

---
 drivers/i2c/busses/i2c-designware-core.h    |    2 +
 drivers/i2c/busses/i2c-designware-platdrv.c |   33 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/i2c/busses/i2c-designware-core.h
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-core.h
+++ linux-pm/drivers/i2c/busses/i2c-designware-core.h
@@ -280,6 +280,8 @@ struct dw_i2c_dev {
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_disabled;
+	bool			suspended;
+	bool			skip_resume;
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -451,14 +451,21 @@ static void dw_i2c_plat_complete(struct
 #endif
 
 #ifdef CONFIG_PM
-static int dw_i2c_plat_runtime_suspend(struct device *dev)
+static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (i_dev->suspended) {
+		i_dev->skip_resume = true;
+		return 0;
+	}
+
 	i_dev->disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
 
+	i_dev->suspended = true;
+
 	return 0;
 }
 
@@ -467,27 +474,27 @@ static int dw_i2c_plat_resume(struct dev
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (!i_dev->suspended)
+		return 0;
+
+	if (i_dev->skip_resume) {
+		i_dev->skip_resume = false;
+		return 0;
+	}
+
 	i2c_dw_plat_prepare_clk(i_dev, true);
 	i_dev->init(i_dev);
 
-	return 0;
-}
+	i_dev->suspended = false;
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_i2c_plat_suspend(struct device *dev)
-{
-	pm_runtime_resume(dev);
-	return dw_i2c_plat_runtime_suspend(dev);
+	return 0;
 }
-#endif
 
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	.prepare = dw_i2c_plat_prepare,
 	.complete = dw_i2c_plat_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
-	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
-			   dw_i2c_plat_resume,
-			   NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
 };
 
 #define DW_I2C_DEV_PMOPS (&dw_i2c_dev_pm_ops)
