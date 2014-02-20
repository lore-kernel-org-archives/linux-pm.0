From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/8] mmc: mmci: Let runtime PM callbacks be available for CONFIG_PM
Date: Thu, 20 Feb 2014 16:31:19 +0100
Message-ID: <1392910280-12891-8-git-send-email-ulf.hansson@linaro.org>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:33659 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbaBTPbn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 10:31:43 -0500
Received: by mail-we0-f182.google.com with SMTP id u57so1561284wes.41
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2014 07:31:42 -0800 (PST)
In-Reply-To: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Ulf Hansson <ulf.hansson@linaro.org>

Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
callbacks. This means the callbacks becomes available for both
CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed to handle the
combinations of these scenarios.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 178868a..c88da1c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1753,7 +1753,7 @@ static int mmci_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static void mmci_save(struct mmci_host *host)
 {
 	unsigned long flags;
@@ -1821,7 +1821,7 @@ static int mmci_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
-	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
+	SET_PM_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
 static struct amba_id mmci_ids[] = {
-- 
1.7.9.5

