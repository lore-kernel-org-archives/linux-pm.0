From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] PM / Domains: Remove redundant system PM callbacks
Date: Wed, 21 Sep 2016 15:38:51 +0200
Message-ID: <1474465133-14865-3-git-send-email-ulf.hansson@linaro.org>
References: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34007 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934100AbcIUNjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 09:39:04 -0400
Received: by mail-lf0-f46.google.com with SMTP id y6so41710212lff.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2016 06:39:03 -0700 (PDT)
In-Reply-To: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>

In cases when the PM domain haven't assigned a system PM callback, the PM
core fall-backs to check for the callback at the driver level instead.
This makes it redundant to assign a pm_generic_* helper function to a
corresponding system PM callback at a PM domain level.

Therefore, let's remove these assignments in pm_genpd_init().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 63f0f8b..661ac3a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1316,24 +1316,12 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
 	genpd->domain.ops.prepare = pm_genpd_prepare;
-	genpd->domain.ops.suspend = pm_generic_suspend;
-	genpd->domain.ops.suspend_late = pm_generic_suspend_late;
 	genpd->domain.ops.suspend_noirq = pm_genpd_suspend_noirq;
 	genpd->domain.ops.resume_noirq = pm_genpd_resume_noirq;
-	genpd->domain.ops.resume_early = pm_generic_resume_early;
-	genpd->domain.ops.resume = pm_generic_resume;
-	genpd->domain.ops.freeze = pm_generic_freeze;
-	genpd->domain.ops.freeze_late = pm_generic_freeze_late;
 	genpd->domain.ops.freeze_noirq = pm_genpd_freeze_noirq;
 	genpd->domain.ops.thaw_noirq = pm_genpd_thaw_noirq;
-	genpd->domain.ops.thaw_early = pm_generic_thaw_early;
-	genpd->domain.ops.thaw = pm_generic_thaw;
-	genpd->domain.ops.poweroff = pm_generic_poweroff;
-	genpd->domain.ops.poweroff_late = pm_generic_poweroff_late;
 	genpd->domain.ops.poweroff_noirq = pm_genpd_suspend_noirq;
 	genpd->domain.ops.restore_noirq = pm_genpd_restore_noirq;
-	genpd->domain.ops.restore_early = pm_generic_restore_early;
-	genpd->domain.ops.restore = pm_generic_restore;
 	genpd->domain.ops.complete = pm_genpd_complete;
 
 	if (genpd->flags & GENPD_FLAG_PM_CLK) {
-- 
1.9.1

