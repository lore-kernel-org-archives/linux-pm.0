From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH v3 1/3] i2c: designware: Clean up PM handling in dw_i2c_plat_probe()
Date: Wed, 06 Sep 2017 01:43:48 +0200
Message-ID: <6171713.W6ZzihW19R@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3958866.l2qnKDbinI@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3958866.l2qnKDbinI@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The power management handling in dw_i2c_plat_probe() is somewhat
messy and it is rather hard to figure out the code intention for
the case when pm_disabled is set.  In that case, the driver doesn't
enable runtime PM at all, but in addition to that it calls
pm_runtime_forbid() as though it wasn't sure if runtime PM might
be enabled for the device later by someone else.

Although that concern doesn't seem to be actually valid, the
device is clearly still expected to be PM-capable even in the
pm_disabled set case, so a better approach would be to enable
runtime PM for it unconditionally and then prevent it from
being runtime-suspended by using pm_runtime_forbid().

Make the driver do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v3: Small update of the changelog.

---
 drivers/i2c/busses/i2c-designware-platdrv.c |   36 +++++++++++++++++++---------
 1 file changed, 25 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -249,6 +249,16 @@ static void dw_i2c_set_fifo_size(struct
 	}
 }
 
+static void dw_i2c_plat_pm_cleanup(struct dw_i2c_dev *dev)
+{
+	pm_runtime_get_noresume(dev->dev);
+	if (dev->pm_disabled)
+		pm_runtime_allow(dev->dev);
+
+	pm_runtime_disable(dev->dev);
+	pm_runtime_put_noidle(dev->dev);
+}
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -362,14 +372,19 @@ static int dw_i2c_plat_probe(struct plat
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->dev.of_node = pdev->dev.of_node;
 
-	if (dev->pm_disabled) {
+	/* The code below assumes runtime PM to be disabled. */
+	WARN_ON(pm_runtime_enabled(&pdev->dev));
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	if (dev->pm_disabled)
 		pm_runtime_forbid(&pdev->dev);
-	} else {
-		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
-		pm_runtime_use_autosuspend(&pdev->dev);
-		pm_runtime_set_active(&pdev->dev);
-		pm_runtime_enable(&pdev->dev);
-	}
+
+	pm_runtime_put_noidle(&pdev->dev);
 
 	if (dev->mode == DW_IC_SLAVE)
 		ret = i2c_dw_probe_slave(dev);
@@ -382,8 +397,7 @@ static int dw_i2c_plat_probe(struct plat
 	return ret;
 
 exit_probe:
-	if (!dev->pm_disabled)
-		pm_runtime_disable(&pdev->dev);
+	dw_i2c_plat_pm_cleanup(dev);
 exit_reset:
 	if (!IS_ERR_OR_NULL(dev->rst))
 		reset_control_assert(dev->rst);
@@ -402,8 +416,8 @@ static int dw_i2c_plat_remove(struct pla
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
-	if (!dev->pm_disabled)
-		pm_runtime_disable(&pdev->dev);
+	dw_i2c_plat_pm_cleanup(dev);
+
 	if (!IS_ERR_OR_NULL(dev->rst))
 		reset_control_assert(dev->rst);
 


