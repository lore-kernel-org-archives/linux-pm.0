From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/8] i2c: nomadik: Fixup system suspend
Date: Thu, 20 Feb 2014 16:31:17 +0100
Message-ID: <1392910280-12891-6-git-send-email-ulf.hansson@linaro.org>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:37139 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbaBTPbj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 10:31:39 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so1559013wgh.31
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 07:31:38 -0800 (PST)
In-Reply-To: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Ulf Hansson <ulf.hansson@linaro.org>

For !CONFIG_PM_RUNTIME, the device were never put back into active
state while resuming.

For CONFIG_PM_RUNTIME, we blindly trusted the device to be inactive
while we were about to handle it at suspend late, which is just too
optimistic.

Even if the driver uses pm_runtime_put_sync() after each tranfer to
return it's runtime PM resources, there are no guarantees this will
actually mean the device will inactivated. The reason is that the PM
core will prevent runtime suspend during system suspend, and thus when
a transfer occurs during the early phases of system suspend the device
will be kept active after the transfer.

To handle both issues above, use pm_runtime_force_suspend|resume() from
the system suspend|resume callbacks.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 8082f5c..519f5b8 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -879,19 +879,19 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 #ifdef CONFIG_PM_SLEEP
 static int nmk_i2c_suspend_late(struct device *dev)
 {
-	pinctrl_pm_select_sleep_state(dev);
+	int ret;
 
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	pinctrl_pm_select_sleep_state(dev);
 	return 0;
 }
 
 static int nmk_i2c_resume_early(struct device *dev)
 {
-	/* First go to the default state */
-	pinctrl_pm_select_default_state(dev);
-	/* Then let's idle the pins until the next transfer happens */
-	pinctrl_pm_select_idle_state(dev);
-
-	return 0;
+	return pm_runtime_force_resume(dev);
 }
 #endif
 
-- 
1.7.9.5

