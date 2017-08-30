From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH v2 3/3] PM: i2c-designware-platdrv: System sleep handling rework
Date: Wed, 30 Aug 2017 02:07:20 +0200
Message-ID: <3521168.PErTxbFMEc@aspire.rjw.lan>
References: <1551534.5XKjjnxbAy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1551534.5XKjjnxbAy@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the power management part of the i2c-designware-platdrv driver
so that it need not be runtime resumed by the generic ACPI PM domain
and the ACPI LPSS driver during system suspend.

First, add a "suspended" and "suspend_skipped" flags to struct
dw_i2c_dev and make dw_i2c_plat_suspend() and dw_i2c_plat_resume()
use them to avoid suspending or resuming the device twice in a row
and to avoid resuming a previously runtime-suspended device during
system resume.

Second, point the driver's ->late_suspend and ->early_resume
callbacks, rather than its ->suspend and ->resume callbacks,
to dw_i2c_plat_suspend() and dw_i2c_plat_resume(), respectively,
so that they are not executed in parallel with each other, for
example if runtime resume of the device takes place during system
suspend.

Next, make the driver set the SAFE_SUSPEND driver flag (introduced
earlier) to inform the upper code layers that from the driver's
perspective it is fine to leave the device in runtime suspend over
system suspend and resume.

Finally, drop the driver's ->prepare and ->complete PM callbacks
that aren't necessary any more, because the driver is now able to
cope with devices left in runtime suspend over system suspend and
resume and need not indicate to the PM core that its suspend
and resume callbacks may be skipped (and need not clean up if the
core actually does that).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.h    |    2 +
 drivers/i2c/busses/i2c-designware-platdrv.c |   36 +++++++++++++---------------
 2 files changed, 19 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -358,6 +358,7 @@ static int dw_i2c_plat_probe(struct plat
 	if (dev->pm_disabled) {
 		pm_runtime_forbid(&pdev->dev);
 	} else {
+		pdev->dev.power.driver_flags = DPM_FLAG_SAFE_SUSPEND;
 		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_set_active(&pdev->dev);
@@ -413,31 +414,23 @@ static const struct of_device_id dw_i2c_
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_i2c_plat_prepare(struct device *dev)
-{
-	return pm_runtime_suspended(dev);
-}
-
-static void dw_i2c_plat_complete(struct device *dev)
-{
-	if (dev->power.direct_complete)
-		pm_request_resume(dev);
-}
-#else
-#define dw_i2c_plat_prepare	NULL
-#define dw_i2c_plat_complete	NULL
-#endif
-
 #ifdef CONFIG_PM
 static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (i_dev->suspended) {
+		i_dev->suspend_skipped = true;
+		return 0;
+	}
+
 	i_dev->disable(i_dev);
 	i2c_dw_plat_prepare_clk(i_dev, false);
 
+	i_dev->suspended = true;
+	i_dev->suspend_skipped = false;
+
 	return 0;
 }
 
@@ -446,6 +439,13 @@ static int dw_i2c_plat_resume(struct dev
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	if (!i_dev->suspended || i_dev->suspend_skipped) {
+		i_dev->suspend_skipped = false;
+		return 0;
+	}
+
+	i_dev->suspended = false;
+
 	i2c_dw_plat_prepare_clk(i_dev, true);
 	i_dev->init(i_dev);
 
@@ -453,9 +453,7 @@ static int dw_i2c_plat_resume(struct dev
 }
 
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
-	.prepare = dw_i2c_plat_prepare,
-	.complete = dw_i2c_plat_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
 };
 
Index: linux-pm/drivers/i2c/busses/i2c-designware-core.h
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-core.h
+++ linux-pm/drivers/i2c/busses/i2c-designware-core.h
@@ -280,6 +280,8 @@ struct dw_i2c_dev {
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_disabled;
+	bool			suspended;
+	bool			suspend_skipped;
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);


