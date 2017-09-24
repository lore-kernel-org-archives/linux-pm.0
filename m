From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 3/3] PM: i2c-designware-platdrv: Suspend/resume at the late/early stages
Date: Mon, 25 Sep 2017 01:30:51 +0200
Message-ID: <7572899.CfQ69SdO4W@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3958866.l2qnKDbinI@aspire.rjw.lan> <65494652.vEfz4tCBDb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <65494652.vEfz4tCBDb@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As reported by Rajat Jain, there are problems when ACPI operation
region handlers or similar, called at the ->resume_early() time, for
I2C client devices try to access an I2C controller that has already
been suspended at that point.  To avoid that, move the suspend/resume
of i2c-designware-platdrv to the late/early stages, respectively.

While at it, avoid resuming the device from runtime suspend in the
driver's ->suspend callback which isn't particularly nice.  [A better
approach would be to make the driver track the PM state of the device
so that it doesn't need to resume it in ->suspend, so implement it.]

First, drop dw_i2c_plat_suspend() added by commit a23318feeff6 (i2c:
designware: Fix system suspend) and rename dw_i2c_plat_runtime_suspend()
back to dw_i2c_plat_suspend().

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

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Johannes Stezenbach <js@sig21.net>
Tested-by: Rajat Jain <rajatja@google.com>
---

v3 ->v4: Modify changelog to mention the problem addressed by this
  patch, rebase on top of 4.14-rc1 and add Tested-by tags.

v2 -> v3:
  Do not drop ->prepare and ->complete system sleep callbacks as
  direct_complete is still useful for helping to avoid resuming
  the parent of this device in the intel-lpss case.

-> v2:
  Add the "suspended" flag, which is needed, because
  dw_i2c_plat_suspend() doesn't update the runtime PM status of
  the device, so dw_i2c_plat_resume() can't rely on this check
  during system resume.

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
@@ -451,13 +451,20 @@ static void dw_i2c_plat_complete(struct
 #endif
 
 #ifdef CONFIG_PM
-static int dw_i2c_plat_runtime_suspend(struct device *dev)
+static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
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
 
@@ -465,27 +472,27 @@ static int dw_i2c_plat_resume(struct dev
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
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


