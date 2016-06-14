From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/10] i2c: designware-platdrv: Rework system PM support
Date: Tue, 14 Jun 2016 17:07:28 +0200
Message-ID: <1465916848-8207-11-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34968 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcFNPIG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 11:08:06 -0400
Received: by mail-lf0-f50.google.com with SMTP id u74so106498275lff.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2016 08:08:05 -0700 (PDT)
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org

The current code that deploys the system PM support relies on the
"direct_complete" feature supported by the PM core. The goal is to avoid
performing unnecessary operations during the system PM sequence.

Unfortunate in this case there are some drawbacks with this solution as
explained below.

1)
In case of the ->prepare() callback find the device runtime resumed it
returns 0. The PM core will then run the regular set of the system PM
callbacks for the device, to allow it to be suspended.

Under these circumstances the device also becomes unconditionally resumed
during the system PM resume sequence. It would be better to postpone the
resume operations to be managed by runtime PM and thus only when actually
needed.

2)
It's good practice to keep the device's runtime PM status in sync with the
the current state of the HW. In the same scenario as described in 1), the
runtime PM status are RPM_ACTIVE the period in-between when the
->suspend() and ->resume() callbacks are invoked. This is wrong because
the device has actually been put into a low power state.

To address the limitation in 2) and to simplify the system PM code, let's
convert to deploy the so called runtime PM centric approach.

This is done by assigning the system PM ->suspend|resume() callbacks to
the pm_runtime_force_suspend|resume() helper functions. In this way, the
->prepare() and ->complete() callbacks can also be removed.

Currently pm_runtime_force_resume() is also unconditionally resuming the
device, which is due to legacy reasons when CONFIG_PM_RUNTIME and
CONFIG_PM_SLEEP co-existed. Changing that behaviour is a reasonable
improvement to make and it would also resolve the limitation in 1).

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index b2c6037..4c31ff3 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -291,24 +291,8 @@ static const struct of_device_id dw_i2c_of_match[] = {
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
-static int dw_i2c_plat_suspend(struct device *dev)
+static int dw_i2c_plat_runtime_suspend(struct device *dev)
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
@@ -320,7 +304,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	return 0;
 }
 
-static int dw_i2c_plat_resume(struct device *dev)
+static int dw_i2c_plat_runtime_resume(struct device *dev)
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 	int ret;
@@ -336,10 +320,11 @@ static int dw_i2c_plat_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
-	.prepare = dw_i2c_plat_prepare,
-	.complete = dw_i2c_plat_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
-	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
+			dw_i2c_plat_runtime_resume,
+			NULL)
 };
 
 #define DW_I2C_DEV_PMOPS (&dw_i2c_dev_pm_ops)
-- 
1.9.1

