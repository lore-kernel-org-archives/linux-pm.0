From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/24] PM / Domains: Remove dev_irq_safe from genpd config
Date: Tue, 10 Jun 2014 12:51:22 +0200
Message-ID: <1402397497-26737-10-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:40918 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbaFJKw0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:26 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so3828888lbv.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:25 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

The genpd dev_irq_safe configuration overlaps with the runtime PM
pm_runtime_irq_safe() option. Let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |    4 ----
 include/linux/pm_domain.h   |    1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da058e9..a2ebc77 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -616,8 +616,6 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	might_sleep_if(!genpd->dev_irq_safe);
-
 	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
 	if (stop_ok && !stop_ok(dev))
 		return -EBUSY;
@@ -662,8 +660,6 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	might_sleep_if(!genpd->dev_irq_safe);
-
 	/* If power.irq_safe, the PM domain is never powered off. */
 	if (dev->power.irq_safe)
 		return genpd_start_dev_no_timing(genpd, dev);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 87810a7..7aadf40 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -63,7 +63,6 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	bool suspend_power_off;	/* Power status before system suspend */
-	bool dev_irq_safe;	/* Device callbacks are IRQ-safe */
 	int (*power_off)(struct generic_pm_domain *domain);
 	s64 power_off_latency_ns;
 	int (*power_on)(struct generic_pm_domain *domain);
-- 
1.7.9.5

