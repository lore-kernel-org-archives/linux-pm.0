From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/8] spi: pl022: Don't ignore power domain and amba bus at system suspend
Date: Sat,  1 Mar 2014 11:56:07 +0100
Message-ID: <1393671371-2398-5-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48535 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbaCAK41 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Mar 2014 05:56:27 -0500
Received: by mail-lb0-f181.google.com with SMTP id c11so3360303lbj.26
        for <linux-pm@vger.kernel.org>; Sat, 01 Mar 2014 02:56:26 -0800 (PST)
In-Reply-To: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>

Previously only the resources controlled by the driver were put into
low power state at system suspend. Both the amba bus and a potential
power domain were ignored.

Moreover, while putting the device into low power state we first
brought it back to full power, but for no particular reason.

To handle both issues above, use pm_runtime_force_suspend|resume() from
the system suspend|resume callbacks.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi-pl022.c |   54 ++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 6dfcabf..d37e840 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2277,35 +2277,7 @@ pl022_remove(struct amba_device *adev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-/*
- * These two functions are used from both suspend/resume and
- * the runtime counterparts to handle external resources like
- * clocks, pins and regulators when going to sleep.
- */
-static void pl022_suspend_resources(struct pl022 *pl022, bool runtime)
-{
-	clk_disable_unprepare(pl022->clk);
-
-	if (runtime)
-		pinctrl_pm_select_idle_state(&pl022->adev->dev);
-	else
-		pinctrl_pm_select_sleep_state(&pl022->adev->dev);
-}
-
-static void pl022_resume_resources(struct pl022 *pl022, bool runtime)
-{
-	/* First go to the default state */
-	pinctrl_pm_select_default_state(&pl022->adev->dev);
-	if (!runtime)
-		/* Then let's idle the pins until the next transfer happens */
-		pinctrl_pm_select_idle_state(&pl022->adev->dev);
-
-	clk_prepare_enable(pl022->clk);
-}
-#endif
-
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int pl022_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
@@ -2317,8 +2289,13 @@ static int pl022_suspend(struct device *dev)
 		return ret;
 	}
 
-	pm_runtime_get_sync(dev);
-	pl022_suspend_resources(pl022, false);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		spi_master_resume(pl022->master);
+		return ret;
+	}
+
+	pinctrl_pm_select_sleep_state(dev);
 
 	dev_dbg(dev, "suspended\n");
 	return 0;
@@ -2329,8 +2306,9 @@ static int pl022_resume(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int ret;
 
-	pl022_resume_resources(pl022, false);
-	pm_runtime_put(dev);
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		dev_err(dev, "problem resuming\n");
 
 	/* Start the queue running */
 	ret = spi_master_resume(pl022->master);
@@ -2341,14 +2319,16 @@ static int pl022_resume(struct device *dev)
 
 	return ret;
 }
-#endif	/* CONFIG_PM */
+#endif
 
 #ifdef CONFIG_PM
 static int pl022_runtime_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
-	pl022_suspend_resources(pl022, true);
+	clk_disable_unprepare(pl022->clk);
+	pinctrl_pm_select_idle_state(dev);
+
 	return 0;
 }
 
@@ -2356,7 +2336,9 @@ static int pl022_runtime_resume(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 
-	pl022_resume_resources(pl022, true);
+	pinctrl_pm_select_default_state(dev);
+	clk_prepare_enable(pl022->clk);
+
 	return 0;
 }
 #endif
-- 
1.7.9.5

