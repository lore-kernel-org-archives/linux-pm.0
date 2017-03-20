From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] PM / Domains: Enable users of genpd to specify always on PM domains
Date: Mon, 20 Mar 2017 11:19:21 +0100
Message-ID: <1490005163-28633-3-git-send-email-ulf.hansson@linaro.org>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35986 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753679AbdCTKUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 06:20:23 -0400
Received: by mail-lf0-f45.google.com with SMTP id y193so53267795lfd.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 03:19:37 -0700 (PDT)
In-Reply-To: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

The current way to implement an always on PM domain consists of returning
-EBUSY from the ->power_off() callback. This is a bit different compared to
using the always on genpd governor, which prevents the PM domain from being
powered off via runtime suspend, but not via system suspend.

The approach to return -EBUSY from the ->power_off() callback to support
always on PM domains in genpd is suboptimal. That is because it requires
genpd to follow the regular execution path of the power off sequence, which
ends by invoking the ->power_off() callback.

To enable genpd to early abort the power off sequence for always on PM
domains, it needs static information about these configurations. Therefore
let's add a new genpd configuration flag, GENPD_FLAG_ALWAYS_ON.

Users of the new GENPD_FLAG_ALWAYS_ON flag, are by genpd required to make
sure the PM domain is powered on before calling pm_genpd_init(). Moreover,
users don't need to implement the ->power_off() callback, as genpd doesn't
ever invoke it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 14 ++++++++++++--
 include/linux/pm_domain.h   |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7a8e70d..e63712d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -123,6 +123,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 
 #define genpd_status_on(genpd)		(genpd->status == GPD_STATE_ACTIVE)
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
+#define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		struct generic_pm_domain *genpd)
@@ -300,7 +301,12 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
 		return 0;
 
-	if (atomic_read(&genpd->sd_count) > 0)
+	/*
+	 * Abort power off for the PM domain in the following situations:
+	 * (1) The domain is configured as always on.
+	 * (2) When the domain has a subdomain being powered on.
+	 */
+	if (genpd_is_always_on(genpd) || atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
@@ -752,7 +758,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
-	if (!genpd_status_on(genpd))
+	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
 		return;
 
 	if (genpd->suspended_count != genpd->device_count
@@ -1491,6 +1497,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	/* Always-on domains must be powered on at initialization. */
+	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
+		return -EINVAL;
+
 	/* Use only one "off" state if there were no states declared */
 	if (genpd->state_count == 0) {
 		ret = genpd_set_default_power_state(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5..9b6abe6 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -20,6 +20,7 @@
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
 #define GENPD_FLAG_IRQ_SAFE	(1U << 1) /* PM domain operates in atomic */
+#define GENPD_FLAG_ALWAYS_ON	(1U << 2) /* PM domain is always powered on */
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-- 
2.7.4
