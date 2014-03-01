From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 8/8] mmc: mmci: Put the device into low power state at system suspend
Date: Sat,  1 Mar 2014 11:56:11 +0100
Message-ID: <1393671371-2398-9-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:38743 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaCAK4h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Mar 2014 05:56:37 -0500
Received: by mail-lb0-f175.google.com with SMTP id w7so3382608lbi.20
        for <linux-pm@vger.kernel.org>; Sat, 01 Mar 2014 02:56:36 -0800 (PST)
In-Reply-To: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>

For CONFIG_PM_SLEEP, the device were always left in full power state
after system suspend.

We solely relied on a power domain to put it into low power state,
which is an unreasonable requirement to put on SOCs to implement.
Especially for those SOCs not supporting power domains at all.

Use pm_runtime_force_suspend|resume() as the system suspend callbacks,
to resolve the issue.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c88da1c..1432ae2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1723,36 +1723,6 @@ static int mmci_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
-static int mmci_suspend(struct device *dev)
-{
-	struct amba_device *adev = to_amba_device(dev);
-	struct mmc_host *mmc = amba_get_drvdata(adev);
-
-	if (mmc) {
-		struct mmci_host *host = mmc_priv(mmc);
-		pm_runtime_get_sync(dev);
-		writel(0, host->base + MMCIMASK0);
-	}
-
-	return 0;
-}
-
-static int mmci_resume(struct device *dev)
-{
-	struct amba_device *adev = to_amba_device(dev);
-	struct mmc_host *mmc = amba_get_drvdata(adev);
-
-	if (mmc) {
-		struct mmci_host *host = mmc_priv(mmc);
-		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
-		pm_runtime_put(dev);
-	}
-
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_PM
 static void mmci_save(struct mmci_host *host)
 {
@@ -1820,7 +1790,8 @@ static int mmci_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops mmci_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_PM_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
-- 
1.7.9.5

