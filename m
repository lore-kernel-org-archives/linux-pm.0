From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH v5 1/3] PM: i2c-designware-platdrv: Clean up PM handling in probe
Date: Mon, 25 Sep 2017 23:10:06 +0200
Message-ID: <188302021.o3ml4PkeyZ@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <65494652.vEfz4tCBDb@aspire.rjw.lan> <2813826.3DA0fVXnVa@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42978 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932182AbdIYVTS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 17:19:18 -0400
In-Reply-To: <2813826.3DA0fVXnVa@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rajat Jain <rajatja@google.com>

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
runtime PM for it unconditionally and prevent it from being
runtime-suspended by using pm_runtime_get_noresume().

Make the driver do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5: Address the Ulf's comment that pm_runtime_forbid() was not
  suitable for preventing runtime suspends of the device from occurring
  (as it could be overridden by user space) and update the changelog.

  Also drop the tags as the patch changed (although that change shouldn't
  matter on systems where pm_disabled is not set).

v3 -> v4: Added Tested-by tags.

-> v3: Small update of the changelog.

---
 drivers/i2c/busses/i2c-designware-platdrv.c |   34 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -249,6 +249,14 @@ static void dw_i2c_set_fifo_size(struct
 	}
 }
 
+static void dw_i2c_plat_pm_cleanup(struct dw_i2c_dev *dev)
+{
+	pm_runtime_disable(dev->dev);
+
+	if (dev->pm_disabled)
+		pm_runtime_put_noidle(dev->dev);
+}
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -362,14 +370,17 @@ static int dw_i2c_plat_probe(struct plat
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->dev.of_node = pdev->dev.of_node;
 
-	if (dev->pm_disabled) {
-		pm_runtime_forbid(&pdev->dev);
-	} else {
-		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
-		pm_runtime_use_autosuspend(&pdev->dev);
-		pm_runtime_set_active(&pdev->dev);
-		pm_runtime_enable(&pdev->dev);
-	}
+	/* The code below assumes runtime PM to be disabled. */
+	WARN_ON(pm_runtime_enabled(&pdev->dev));
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+
+	if (dev->pm_disabled)
+		pm_runtime_get_noresume(&pdev->dev);
+
+	pm_runtime_enable(&pdev->dev);
 
 	if (dev->mode == DW_IC_SLAVE)
 		ret = i2c_dw_probe_slave(dev);
@@ -382,8 +393,7 @@ static int dw_i2c_plat_probe(struct plat
 	return ret;
 
 exit_probe:
-	if (!dev->pm_disabled)
-		pm_runtime_disable(&pdev->dev);
+	dw_i2c_plat_pm_cleanup(dev);
 exit_reset:
 	if (!IS_ERR_OR_NULL(dev->rst))
 		reset_control_assert(dev->rst);
@@ -402,8 +412,8 @@ static int dw_i2c_plat_remove(struct pla
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
-	if (!dev->pm_disabled)
-		pm_runtime_disable(&pdev->dev);
+	dw_i2c_plat_pm_cleanup(dev);
+
 	if (!IS_ERR_OR_NULL(dev->rst))
 		reset_control_assert(dev->rst);
 
