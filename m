From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH V4 1/2] PM / Domains: Add time accounting to various genpd states.
Date: Fri, 14 Jul 2017 13:10:15 -0400
Message-ID: <1500052216-22252-2-git-send-email-thara.gopinath@linaro.org>
References: <1500052216-22252-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36863 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbdGNRKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 13:10:21 -0400
Received: by mail-qk0-f175.google.com with SMTP id v17so74497750qka.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2017 10:10:20 -0700 (PDT)
In-Reply-To: <1500052216-22252-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org

This patch adds support to calculate the time spent by the generic
power domains in on and various idle states.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3b8210e..640ffc5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -209,6 +209,34 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 	smp_mb__after_atomic();
 }
 
+#ifdef CONFIG_DEBUG_FS
+static void genpd_update_accounting(struct generic_pm_domain *genpd)
+{
+	ktime_t delta, now;
+
+	now = ktime_get();
+	delta = ktime_sub(now, genpd->accounting_time);
+
+	/*
+	 * If genpd->status is active, it means we are just
+	 * out of off and so update the idle time and vice
+	 * versa.
+	 */
+	if (genpd->status == GPD_STATE_ACTIVE) {
+		int state_idx = genpd->state_idx;
+
+		genpd->states[state_idx].idle_time =
+			ktime_add(genpd->states[state_idx].idle_time, delta);
+	} else {
+		genpd->on_time = ktime_add(genpd->on_time, delta);
+	}
+
+	genpd->accounting_time = now;
+}
+#else
+static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
+#endif
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -361,6 +389,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	}
 
 	genpd->status = GPD_STATE_POWER_OFF;
+	genpd_update_accounting(genpd);
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
@@ -413,6 +442,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 		goto err;
 
 	genpd->status = GPD_STATE_ACTIVE;
+	genpd_update_accounting(genpd);
+
 	return 0;
 
  err:
@@ -1540,6 +1571,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->max_off_time_changed = true;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
+	genpd->accounting_time = ktime_get();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
 	genpd->domain.ops.prepare = pm_genpd_prepare;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 41004d9..84f423d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -43,6 +43,7 @@ struct genpd_power_state {
 	s64 power_on_latency_ns;
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
+	ktime_t idle_time;
 };
 
 struct genpd_lock_ops;
@@ -78,6 +79,8 @@ struct generic_pm_domain {
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
 	void *free; /* Free the state that was allocated for default */
+	ktime_t on_time;
+	ktime_t accounting_time;
 	const struct genpd_lock_ops *lock_ops;
 	union {
 		struct mutex mlock;
-- 
2.1.4
