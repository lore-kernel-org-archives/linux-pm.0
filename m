From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/24] PM / Domains: Ignore callbacks for subsys generic_pm_domain_data
Date: Tue, 10 Jun 2014 12:51:17 +0200
Message-ID: <1402397497-26737-5-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:54275 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbaFJKwM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:12 -0400
Received: by mail-la0-f52.google.com with SMTP id s18so3857685lam.11
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:11 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

In a step of simplifying the generic power domain let's move away from
using these callbacks.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |  131 +++----------------------------------------
 1 file changed, 8 insertions(+), 123 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index dc766a7..3a6d1e4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -26,10 +26,6 @@
 	__routine = genpd->dev_ops.callback; 			\
 	if (__routine) {					\
 		__ret = __routine(dev); 			\
-	} else {						\
-		__routine = dev_gpd_data(dev)->ops.callback;	\
-		if (__routine) 					\
-			__ret = __routine(dev);			\
 	}							\
 	__ret;							\
 })
@@ -1978,10 +1974,6 @@ static int pm_genpd_default_save_state(struct device *dev)
 {
 	int (*cb)(struct device *__dev);
 
-	cb = dev_gpd_data(dev)->ops.save_state;
-	if (cb)
-		return cb(dev);
-
 	if (dev->type && dev->type->pm)
 		cb = dev->type->pm->runtime_suspend;
 	else if (dev->class && dev->class->pm)
@@ -2005,10 +1997,6 @@ static int pm_genpd_default_restore_state(struct device *dev)
 {
 	int (*cb)(struct device *__dev);
 
-	cb = dev_gpd_data(dev)->ops.restore_state;
-	if (cb)
-		return cb(dev);
-
 	if (dev->type && dev->type->pm)
 		cb = dev->type->pm->runtime_resume;
 	else if (dev->class && dev->class->pm)
@@ -2024,109 +2012,6 @@ static int pm_genpd_default_restore_state(struct device *dev)
 	return cb ? cb(dev) : 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-
-/**
- * pm_genpd_default_suspend - Default "device suspend" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_suspend(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.suspend;
-
-	return cb ? cb(dev) : pm_generic_suspend(dev);
-}
-
-/**
- * pm_genpd_default_suspend_late - Default "late device suspend" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_suspend_late(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.suspend_late;
-
-	return cb ? cb(dev) : pm_generic_suspend_late(dev);
-}
-
-/**
- * pm_genpd_default_resume_early - Default "early device resume" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_resume_early(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.resume_early;
-
-	return cb ? cb(dev) : pm_generic_resume_early(dev);
-}
-
-/**
- * pm_genpd_default_resume - Default "device resume" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_resume(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.resume;
-
-	return cb ? cb(dev) : pm_generic_resume(dev);
-}
-
-/**
- * pm_genpd_default_freeze - Default "device freeze" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_freeze(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.freeze;
-
-	return cb ? cb(dev) : pm_generic_freeze(dev);
-}
-
-/**
- * pm_genpd_default_freeze_late - Default "late device freeze" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_freeze_late(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.freeze_late;
-
-	return cb ? cb(dev) : pm_generic_freeze_late(dev);
-}
-
-/**
- * pm_genpd_default_thaw_early - Default "early device thaw" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_thaw_early(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.thaw_early;
-
-	return cb ? cb(dev) : pm_generic_thaw_early(dev);
-}
-
-/**
- * pm_genpd_default_thaw - Default "device thaw" for PM domians.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_thaw(struct device *dev)
-{
-	int (*cb)(struct device *__dev) = dev_gpd_data(dev)->ops.thaw;
-
-	return cb ? cb(dev) : pm_generic_thaw(dev);
-}
-
-#else /* !CONFIG_PM_SLEEP */
-
-#define pm_genpd_default_suspend	NULL
-#define pm_genpd_default_suspend_late	NULL
-#define pm_genpd_default_resume_early	NULL
-#define pm_genpd_default_resume		NULL
-#define pm_genpd_default_freeze		NULL
-#define pm_genpd_default_freeze_late	NULL
-#define pm_genpd_default_thaw_early	NULL
-#define pm_genpd_default_thaw		NULL
-
-#endif /* !CONFIG_PM_SLEEP */
-
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -2178,14 +2063,14 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.complete = pm_genpd_complete;
 	genpd->dev_ops.save_state = pm_genpd_default_save_state;
 	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
-	genpd->dev_ops.suspend = pm_genpd_default_suspend;
-	genpd->dev_ops.suspend_late = pm_genpd_default_suspend_late;
-	genpd->dev_ops.resume_early = pm_genpd_default_resume_early;
-	genpd->dev_ops.resume = pm_genpd_default_resume;
-	genpd->dev_ops.freeze = pm_genpd_default_freeze;
-	genpd->dev_ops.freeze_late = pm_genpd_default_freeze_late;
-	genpd->dev_ops.thaw_early = pm_genpd_default_thaw_early;
-	genpd->dev_ops.thaw = pm_genpd_default_thaw;
+	genpd->dev_ops.suspend = pm_generic_suspend;
+	genpd->dev_ops.suspend_late = pm_generic_suspend_late;
+	genpd->dev_ops.resume_early = pm_generic_resume_early;
+	genpd->dev_ops.resume = pm_generic_resume;
+	genpd->dev_ops.freeze = pm_generic_freeze;
+	genpd->dev_ops.freeze_late = pm_generic_freeze_late;
+	genpd->dev_ops.thaw_early = pm_generic_thaw_early;
+	genpd->dev_ops.thaw = pm_generic_thaw;
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
-- 
1.7.9.5

