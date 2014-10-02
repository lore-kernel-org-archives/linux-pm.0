From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Rename cpu_data to cpuidle_data
Date: Thu,  2 Oct 2014 21:12:34 +0200
Message-ID: <1412277154-5853-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36537 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaJBTMp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 15:12:45 -0400
Received: by mail-la0-f52.google.com with SMTP id hz20so2971320lab.39
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2014 12:12:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>

The "cpu_data" are defined for some archs and thus conflicting with the
"cpu_data" member in the struct gpd_cpu_data. This causes a compiler
error for those archs.

Let's fix it by rename the member to cpuidle_data. In this context it
also seems appropriate to rename the struct to gpd_cpuidle_data to
better reflect its use.

Fixes: f48c767ce895 (PM / Domains: Move dev_pm_domain_attach|detach() to pm_domain.h)
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 54 ++++++++++++++++++++++-----------------------
 include/linux/pm_domain.h   |  4 ++--
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 18cc68d..40bc2f4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -142,13 +142,13 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 {
 	s64 usecs64;
 
-	if (!genpd->cpu_data)
+	if (!genpd->cpuidle_data)
 		return;
 
 	usecs64 = genpd->power_on_latency_ns;
 	do_div(usecs64, NSEC_PER_USEC);
-	usecs64 += genpd->cpu_data->saved_exit_latency;
-	genpd->cpu_data->idle_state->exit_latency = usecs64;
+	usecs64 += genpd->cpuidle_data->saved_exit_latency;
+	genpd->cpuidle_data->idle_state->exit_latency = usecs64;
 }
 
 /**
@@ -188,9 +188,9 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 		return 0;
 	}
 
-	if (genpd->cpu_data) {
+	if (genpd->cpuidle_data) {
 		cpuidle_pause_and_lock();
-		genpd->cpu_data->idle_state->disabled = true;
+		genpd->cpuidle_data->idle_state->disabled = true;
 		cpuidle_resume_and_unlock();
 		goto out;
 	}
@@ -513,17 +513,17 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		}
 	}
 
-	if (genpd->cpu_data) {
+	if (genpd->cpuidle_data) {
 		/*
-		 * If cpu_data is set, cpuidle should turn the domain off when
-		 * the CPU in it is idle.  In that case we don't decrement the
-		 * subdomain counts of the master domains, so that power is not
-		 * removed from the current domain prematurely as a result of
-		 * cutting off the masters' power.
+		 * If cpuidle_data is set, cpuidle should turn the domain off
+		 * when the CPU in it is idle.  In that case we don't decrement
+		 * the subdomain counts of the master domains, so that power is
+		 * not removed from the current domain prematurely as a result
+		 * of cutting off the masters' power.
 		 */
 		genpd->status = GPD_STATE_POWER_OFF;
 		cpuidle_pause_and_lock();
-		genpd->cpu_data->idle_state->disabled = false;
+		genpd->cpuidle_data->idle_state->disabled = false;
 		cpuidle_resume_and_unlock();
 		goto out;
 	}
@@ -1698,7 +1698,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 {
 	struct cpuidle_driver *cpuidle_drv;
-	struct gpd_cpu_data *cpu_data;
+	struct gpd_cpuidle_data *cpuidle_data;
 	struct cpuidle_state *idle_state;
 	int ret = 0;
 
@@ -1707,12 +1707,12 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 
 	genpd_acquire_lock(genpd);
 
-	if (genpd->cpu_data) {
+	if (genpd->cpuidle_data) {
 		ret = -EEXIST;
 		goto out;
 	}
-	cpu_data = kzalloc(sizeof(*cpu_data), GFP_KERNEL);
-	if (!cpu_data) {
+	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
+	if (!cpuidle_data) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1730,9 +1730,9 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 		ret = -EAGAIN;
 		goto err;
 	}
-	cpu_data->idle_state = idle_state;
-	cpu_data->saved_exit_latency = idle_state->exit_latency;
-	genpd->cpu_data = cpu_data;
+	cpuidle_data->idle_state = idle_state;
+	cpuidle_data->saved_exit_latency = idle_state->exit_latency;
+	genpd->cpuidle_data = cpuidle_data;
 	genpd_recalc_cpu_exit_latency(genpd);
 
  out:
@@ -1743,7 +1743,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	cpuidle_driver_unref();
 
  err_drv:
-	kfree(cpu_data);
+	kfree(cpuidle_data);
 	goto out;
 }
 
@@ -1766,7 +1766,7 @@ int pm_genpd_name_attach_cpuidle(const char *name, int state)
  */
 int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 {
-	struct gpd_cpu_data *cpu_data;
+	struct gpd_cpuidle_data *cpuidle_data;
 	struct cpuidle_state *idle_state;
 	int ret = 0;
 
@@ -1775,20 +1775,20 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 
 	genpd_acquire_lock(genpd);
 
-	cpu_data = genpd->cpu_data;
-	if (!cpu_data) {
+	cpuidle_data = genpd->cpuidle_data;
+	if (!cpuidle_data) {
 		ret = -ENODEV;
 		goto out;
 	}
-	idle_state = cpu_data->idle_state;
+	idle_state = cpuidle_data->idle_state;
 	if (!idle_state->disabled) {
 		ret = -EAGAIN;
 		goto out;
 	}
-	idle_state->exit_latency = cpu_data->saved_exit_latency;
+	idle_state->exit_latency = cpuidle_data->saved_exit_latency;
 	cpuidle_driver_unref();
-	genpd->cpu_data = NULL;
-	kfree(cpu_data);
+	genpd->cpuidle_data = NULL;
+	kfree(cpuidle_data);
 
  out:
 	genpd_release_lock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9004743..73e938b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -38,7 +38,7 @@ struct gpd_dev_ops {
 	bool (*active_wakeup)(struct device *dev);
 };
 
-struct gpd_cpu_data {
+struct gpd_cpuidle_data {
 	unsigned int saved_exit_latency;
 	struct cpuidle_state *idle_state;
 };
@@ -71,7 +71,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
-	struct gpd_cpu_data *cpu_data;
+	struct gpd_cpuidle_data *cpuidle_data;
 	void (*attach_dev)(struct device *dev);
 	void (*detach_dev)(struct device *dev);
 };
-- 
1.9.1

