From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/8] mmc: mmci: Let runtime PM callbacks be available for CONFIG_PM
Date: Sat,  1 Mar 2014 11:56:10 +0100
Message-ID: <1393671371-2398-8-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36954 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbaCAK4e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Mar 2014 05:56:34 -0500
Received: by mail-lb0-f169.google.com with SMTP id l4so2613399lbv.28
        for <linux-pm@vger.kernel.org>; Sat, 01 Mar 2014 02:56:33 -0800 (PST)
In-Reply-To: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>

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

