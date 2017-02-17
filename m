From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] PM / Domains: Power off masters immediately in the power off sequence
Date: Fri, 17 Feb 2017 10:55:25 +0100
Message-ID: <1487325325-18212-4-git-send-email-ulf.hansson@linaro.org>
References: <1487325325-18212-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36291 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbdBQJzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 04:55:35 -0500
Received: by mail-lf0-f43.google.com with SMTP id z134so20190518lff.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2017 01:55:34 -0800 (PST)
In-Reply-To: <1487325325-18212-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Once a subdomain is powered off, genpd queues a power off work for each of
the subdomain's corresponding masters, thus postponing the masters to be
powered off to a later point.

When genpd used intermediate power off states, which was removed in
commit ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
power off sequence"), this behaviour made sense, but now it simply doesn't.

Genpd can easily try to power off the masters in the same context as the
subdomain, of course by acquiring/releasing the lock. Then, let's convert
to this behaviour, as it avoids unnecessary works from being queued.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 179bb26..e697dec 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -284,7 +284,8 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
  * If all of the @genpd's devices have been suspended and all of its subdomains
  * have been powered down, remove power from @genpd.
  */
-static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on)
+static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
+			   unsigned int depth)
 {
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
@@ -351,7 +352,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on)
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
-		genpd_queue_power_off_work(link->master);
+		genpd_lock_nested(link->master, depth + 1);
+		genpd_power_off(link->master, false, depth + 1);
+		genpd_unlock(link->master);
 	}
 
 	return 0;
@@ -405,7 +408,9 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 					&genpd->slave_links,
 					slave_node) {
 		genpd_sd_counter_dec(link->master);
-		genpd_queue_power_off_work(link->master);
+		genpd_lock_nested(link->master, depth + 1);
+		genpd_power_off(link->master, false, depth + 1);
+		genpd_unlock(link->master);
 	}
 
 	return ret;
@@ -462,7 +467,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
 	genpd_lock(genpd);
-	genpd_power_off(genpd, false);
+	genpd_power_off(genpd, false, 0);
 	genpd_unlock(genpd);
 }
 
@@ -581,7 +586,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
-	genpd_power_off(genpd, true);
+	genpd_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
 
 	return 0;
@@ -661,7 +666,7 @@ static int genpd_runtime_resume(struct device *dev)
 	if (!pm_runtime_is_irq_safe(dev) ||
 		(pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
 		genpd_lock(genpd);
-		genpd_power_off(genpd, true);
+		genpd_power_off(genpd, true, 0);
 		genpd_unlock(genpd);
 	}
 
-- 
1.9.1
