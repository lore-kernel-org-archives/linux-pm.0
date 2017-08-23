From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 9/9] i2c: designware: Deploy the runtime PM centric approach for system sleep
Date: Wed, 23 Aug 2017 16:42:09 +0200
Message-ID: <1503499329-28834-10-git-send-email-ulf.hansson@linaro.org>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
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
system sleep callbacks for the i2c-dw-plat driver.

To deploy this, we must also make sure that the direct_complete path isn't
used for the device. Therefore we drop the ->prepare() callback from the
i2c-dw-plat driver and we inform the ACPI PM domain to not try out the
direct_complete path for the device, as that is the default behaviour for
the ACPI PM domain.

Along with the runtime PM centric path, we also get some additional
improvements of the behaviour during system sleep. More precisely:

*)
In case the device is/gets runtime resumed before the device_suspend()
phase is entered, the PM core doesn't run the direct_complete path for the
device during system sleep. During system resume, this lead to that the
device will always be brought back to full power when the i2c-dw-plat
driver's ->resume() callback is invoked. This may not be necessary, thus
increasing the resume time for the device and wasting power.

In the runtime PM centric path, the pm_runtime_force_resume() helper takes
better care, as it resumes the device only in case it's really needed.
Normally this means it can be postponed to be dealt with via regular calls
to runtime PM (pm_runtime_get*()) instead. In other words, the device
remains in its low power state until someone request a new i2c transfer,
whenever that may be.

**)
In case the device is runtime suspended when the ->prepare() callback is
invoked, the direct_complete path is tried by the PM core. If it succeeds,
this leads to disabling runtime PM for the device in the device_suspend()
phase. That is a problem in cases when others may need the device to be
operational, as to be able send i2c transfers during the entire
device_suspend() phase.

By using the runtime PM centric path, we postpones runtime PM to be
disabled for the device by the PM core to the regular device_suspend_late()
phase.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased.
	- Clarify changelog.

---
 drivers/i2c/busses/i2c-designware-platdrv.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index fc6b99f..e0cbf5e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -372,6 +372,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_probe;
 
+	acpi_dev_disable_direct_complete(&pdev->dev);
 	return ret;
 
 exit_probe:
@@ -387,6 +388,7 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
+	acpi_dev_enable_direct_complete(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
 	i2c_del_adapter(&dev->adapter);
@@ -413,15 +415,6 @@ static const struct of_device_id dw_i2c_of_match[] = {
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
@@ -434,7 +427,7 @@ static int dw_i2c_plat_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int dw_i2c_plat_resume(struct device *dev)
+static int dw_i2c_plat_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
@@ -445,19 +438,11 @@ static int dw_i2c_plat_resume(struct device *dev)
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
