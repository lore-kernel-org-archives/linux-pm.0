From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/8] spi: pl022: Let runtime PM callbacks be available for CONFIG_PM
Date: Sat,  1 Mar 2014 11:56:06 +0100
Message-ID: <1393671371-2398-4-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:40381 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbaCAK4Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Mar 2014 05:56:25 -0500
Received: by mail-lb0-f176.google.com with SMTP id 10so3382859lbg.21
        for <linux-pm@vger.kernel.org>; Sat, 01 Mar 2014 02:56:24 -0800 (PST)
In-Reply-To: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>

Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
callbacks. This means the callbacks becomes available for both
CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed to handle the
combinations of these scenarios.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi-pl022.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 74a0729..6dfcabf 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2277,7 +2277,7 @@ pl022_remove(struct amba_device *adev)
 	return 0;
 }
 
-#if defined(CONFIG_SUSPEND) || defined(CONFIG_PM_RUNTIME)
+#ifdef CONFIG_PM
 /*
  * These two functions are used from both suspend/resume and
  * the runtime counterparts to handle external resources like
@@ -2343,7 +2343,7 @@ static int pl022_resume(struct device *dev)
 }
 #endif	/* CONFIG_PM */
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int pl022_runtime_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
@@ -2363,7 +2363,7 @@ static int pl022_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops pl022_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
-	SET_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
+	SET_PM_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
 };
 
 static struct vendor_data vendor_arm = {
-- 
1.7.9.5

