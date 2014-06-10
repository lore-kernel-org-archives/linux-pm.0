From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 13/24] PM / Domains: Remove genpd_queue_power_off_work() API
Date: Tue, 10 Jun 2014 12:51:26 +0200
Message-ID: <1402397497-26737-14-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:48660 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaFJKwh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:37 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so3788550lab.6
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:35 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

There are no active users of this API. Let's remove it and if future
needs shows up which could consider to have a get/put API instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |    5 ++++-
 include/linux/pm_domain.h   |    2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2d20766..825e81d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -423,7 +423,7 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
  * Queue up the execution of pm_genpd_poweroff() unless it's already been done
  * before.
  */
-void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 {
 	queue_work(pm_wq, &genpd->power_off_work);
 }
@@ -730,6 +730,9 @@ static inline int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static inline void
+genpd_queue_power_off_work(struct generic_pm_domain *genpd) {}
+
 static inline void genpd_power_off_work_fn(struct work_struct *work) {}
 
 #define pm_genpd_runtime_suspend	NULL
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index eacf6a1..5cd8000 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -241,10 +241,8 @@ static inline int pm_genpd_name_add_device(const char *domain_name,
 }
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_RUNTIME
-extern void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
 extern void pm_genpd_poweroff_unused(void);
 #else
-static inline void genpd_queue_power_off_work(struct generic_pm_domain *gpd) {}
 static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
-- 
1.7.9.5

