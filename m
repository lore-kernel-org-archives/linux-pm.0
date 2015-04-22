From: ahaslam@baylibre.com
Subject: [RFC v4 1/8] PM / Domains: structure changes for multiple states
Date: Wed, 22 Apr 2015 11:45:28 +0200
Message-ID: <1429695935-15815-2-git-send-email-ahaslam@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33835 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964945AbbDVJq2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 05:46:28 -0400
Received: by wicmx19 with SMTP id mx19so82431424wic.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 02:46:27 -0700 (PDT)
In-Reply-To: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

Add the structure changes to be able to declare
multiple states. When trying to set a power domain
to off, genpd will be able to choose from an array
of states declared by the platform.

The power on and off callbacks and latencies are
now tied to a particular state.

States should be declared in ascending order from
shallowest to deepest, deepest meaning the state
which takes longer to enter and exit.

if the genpd is initially off, the user should set the
.init_state field when registering the genpd,
so that genpd knows which callbacks to call to set the
domain to on.

An genpd with multiple states would look something like:

struct generic_pm_domain pd1 = {
	.name = "PD1",
	.states = {
		[0] = {
			.name= "D0",
			.power_off = D0_power_off_cb,
			.power_on = D0_power_on_cb,
			.power_off_latency_ns = D0_POWER_OFF_LATENCY,
			.power_on_latency_ns = D0_POWER_ON_LATENCY,
		},
		[1] = {
			.name= "D1",
			.power_off = D1_power_off_cb,
			.power_on = D1_power_on_cb,
			.power_off_latency_ns = D1_POWER_OFF_LATENCY,
			.power_on_latency_ns = D1_POWER_ON_LATENCY,
		},
		[2] = {
			.name= "D2",
			.power_off = D2_power_off_cb,
			.power_on = D2_power_on_cb,
			.power_off_latency_ns = D2_POWER_OFF_LATENCY,
			.power_on_latency_ns = D2_POWER_ON_LATENCY,
		},
	},
	.state_count = 3,
	.init_state = 2,
	[...]
};

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/domain.c          | 43 +++++++++++++++++++++++++++---------
 drivers/base/power/domain_governor.c |  8 ++++---
 include/linux/pm_domain.h            | 17 ++++++++++++++
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 45937f8..f60a175 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -141,12 +141,13 @@ static void genpd_set_active(struct generic_pm_domain *genpd)
 
 static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 {
+	int target_state = genpd->target_state;
 	s64 usecs64;
 
 	if (!genpd->cpuidle_data)
 		return;
 
-	usecs64 = genpd->power_on_latency_ns;
+	usecs64 = genpd->states[target_state].power_on_latency_ns;
 	do_div(usecs64, NSEC_PER_USEC);
 	usecs64 += genpd->cpuidle_data->saved_exit_latency;
 	genpd->cpuidle_data->idle_state->exit_latency = usecs64;
@@ -154,23 +155,24 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 
 static int genpd_power_on(struct generic_pm_domain *genpd)
 {
+	int target_state = genpd->target_state;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
 
-	if (!genpd->power_on)
+	if (!genpd->states[target_state].power_on)
 		return 0;
 
 	time_start = ktime_get();
-	ret = genpd->power_on(genpd);
+	ret = genpd->states[target_state].power_on(genpd);
 	if (ret)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_on_latency_ns)
+	if (elapsed_ns <= genpd->states[target_state].power_on_latency_ns)
 		return ret;
 
-	genpd->power_on_latency_ns = elapsed_ns;
+	genpd->states[target_state].power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	genpd_recalc_cpu_exit_latency(genpd);
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
@@ -181,23 +183,24 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 
 static int genpd_power_off(struct generic_pm_domain *genpd)
 {
+	int target_state = genpd->target_state;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
 
-	if (!genpd->power_off)
+	if (!genpd->states[target_state].power_off)
 		return 0;
 
 	time_start = ktime_get();
-	ret = genpd->power_off(genpd);
+	ret = genpd->states[target_state].power_off(genpd);
 	if (ret == -EBUSY)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_off_latency_ns)
+	if (elapsed_ns <= genpd->states[target_state].power_off_latency_ns)
 		return ret;
 
-	genpd->power_off_latency_ns = elapsed_ns;
+	genpd->states[target_state].power_off_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
 		genpd->name, "off", elapsed_ns);
@@ -486,6 +489,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 	unsigned int not_suspended;
+	int target_state;
 	int ret = 0;
 
  start:
@@ -538,6 +542,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 
 	genpd->status = GPD_STATE_BUSY;
 	genpd->poweroff_task = current;
+	target_state = genpd->target_state;
 
 	list_for_each_entry_reverse(pdd, &genpd->dev_list, list_node) {
 		ret = atomic_read(&genpd->sd_count) == 0 ?
@@ -572,7 +577,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 		goto out;
 	}
 
-	if (genpd->power_off) {
+	if (genpd->states[target_state].power_off) {
 		if (atomic_read(&genpd->sd_count) > 0) {
 			ret = -EBUSY;
 			goto out;
@@ -1877,6 +1882,17 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->resume_count = 0;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
+
+	/*
+	 * set the target off state to the initial off state
+	 * so if the domain is initially off, when the genpd powers on,
+	 * it knows what callback to use.
+	 */
+	genpd->target_state = genpd->init_state;
+	if (genpd->state_count < 1) {
+		pr_err("Initializing genpd %s with invalid state_count %d!\n",
+			genpd->name, genpd->state_count);
+	}
 	genpd->max_off_time_changed = true;
 	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
@@ -2251,6 +2267,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 		[GPD_STATE_REPEAT] = "off-in-progress",
 		[GPD_STATE_POWER_OFF] = "off"
 	};
+	int target_state = genpd->target_state;
 	struct pm_domain_data *pm_data;
 	const char *kobj_path;
 	struct gpd_link *link;
@@ -2262,7 +2279,11 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-	seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
+
+	seq_printf(s, "%-30s  %-15s  ", genpd->name,
+		(genpd->status == GPD_STATE_POWER_OFF) ?
+			genpd->states[target_state].name :
+			status_lookup[genpd->status]);
 
 	/*
 	 * Modifications on the list require holding locks on both
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2a4154a..8630fce 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -104,6 +104,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	struct pm_domain_data *pdd;
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
+	int state = 0;
 
 	if (genpd->max_off_time_changed) {
 		struct gpd_link *link;
@@ -124,8 +125,8 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		return genpd->cached_power_down_ok;
 	}
 
-	off_on_time_ns = genpd->power_off_latency_ns +
-				genpd->power_on_latency_ns;
+	off_on_time_ns = genpd->states[state].power_off_latency_ns +
+			genpd->states[state].power_on_latency_ns;
 	/*
 	 * It doesn't make sense to remove power from the domain if saving
 	 * the state of all devices in it and the power off/power on operations
@@ -216,7 +217,8 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
 	 */
-	genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
+	genpd->max_off_time_ns = min_off_time_ns -
+			genpd->states[state].power_on_latency_ns;
 	return true;
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 080e778..f20c2c0 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,6 +17,8 @@
 #include <linux/notifier.h>
 #include <linux/cpuidle.h>
 
+#define GENPD_MAX_NSTATES 10
+
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	(1U << 0) /* PM domain uses PM clk */
 
@@ -46,6 +48,16 @@ struct gpd_cpuidle_data {
 	struct cpuidle_state *idle_state;
 };
 
+struct generic_pm_domain;
+
+struct genpd_power_state {
+	char *name;
+	s64 power_off_latency_ns;
+	s64 power_on_latency_ns;
+	int (*power_off)(struct generic_pm_domain *domain);
+	int (*power_on)(struct generic_pm_domain *domain);
+};
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
@@ -80,6 +92,11 @@ struct generic_pm_domain {
 	void (*detach_dev)(struct generic_pm_domain *domain,
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
+
+	struct genpd_power_state states[GENPD_MAX_NSTATES];
+	int target_state; /* state that genpd will go to when off */
+	int init_state; /* initial genpd state */
+	int state_count; /* number of states */
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
1.9.1

