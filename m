From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 8/8] i2c: designware: Deploy the runtime PM centric path for system sleep
Date: Tue, 29 Aug 2017 16:56:50 +0200
Message-ID: <1504018610-10822-9-git-send-email-ulf.hansson@linaro.org>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently the device is runtime resumed in the i2c-dw-plat driver's
->suspend() callback, which is needed to manage system sleep properly.

The particular reason for the runtime resume is because the PM core may
unset the direct_complete flag for a parent device, in case its child
device are being system suspended before. This leads to that the
i2c-dw-plat driver's ->suspend() callback can be invoked when the device is
runtime suspended.

Runtime resuming the device in this scenario may be unnecessary, in case
when the device is already in its proper lower power state for system
sleep. This behaviour increases the time it takes to put the device into
low power state, but means also a waste of power.

Let's fix the behaviour by deploying the runtime PM centric path for system
sleep, via assigning the pm_runtime_force_suspend|resume() helpers as the
system sleep callbacks for the i2c-dw-plat driver. We must also inform the
PM core and the ACPI PM domain that we are now using the runtime PM centric
path, therefore we call dev_pm_use_rpm_sleep() during ->probe().

While deploying the runtime PM centric path, the ->prepare() callback
becomes redundant, so let's drop it.

Along with these improvements, of course we also get the other regular
benefits one get when deploying the runtime PM centric path.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Use dev_pm_use_rpm_sleep() instead of the earlier
	acpi_disable_direct_complete() from v2.
	- Updated changelog.

---
 drivers/i2c/busses/i2c-designware-platdrv.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 38121c9..20db3c2 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -371,6 +371,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_probe;
 
+	dev_pm_use_rpm_sleep(&pdev->dev);
 	return ret;
 
 exit_probe:
@@ -412,15 +413,6 @@ static const struct of_device_id dw_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_i2c_plat_prepare(struct device *dev)
-{
-	return pm_runtime_suspended(dev);
-}
-#else
-#define dw_i2c_plat_prepare	NULL
-#endif
-
 #ifdef CONFIG_PM
 static int dw_i2c_plat_runtime_suspend(struct device *dev)
 {
@@ -433,7 +425,7 @@ static int dw_i2c_plat_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int dw_i2c_plat_resume(struct device *dev)
+static int dw_i2c_plat_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
@@ -444,19 +436,11 @@ static int dw_i2c_plat_resume(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_i2c_plat_suspend(struct device *dev)
-{
-	pm_runtime_resume(dev);
-	return dw_i2c_plat_runtime_suspend(dev);
-}
-#endif
-
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
-	.prepare = dw_i2c_plat_prepare,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
-			   dw_i2c_plat_resume,
+			   dw_i2c_plat_runtime_resume,
 			   NULL)
 };
 
-- 
2.7.4
