From: ahaslam@baylibre.com
Subject: [RFC v5 1/8] PM / Domains: structure changes for multiple states
Date: Fri, 24 Apr 2015 19:35:17 +0200
Message-ID: <1429896924-21540-2-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37128 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966362AbbDXRfm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:42 -0400
Received: by widdi4 with SMTP id di4so28087401wid.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:41 -0700 (PDT)
In-Reply-To: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

Add the structure changes to be able to declare
multiple states. When trying to set a power domain
to off, genpd will be able to choose from an array
of states declared by the platform.

The power on and off latencies are now tied to
a particular state.

States should be declared in ascending order from
shallowest to deepest, deepest meaning the state
which takes longer to enter and exit.

the power_off and power_on function can use the
'state_idx' field of the generic_pm_domain structure,
to distinguish between the different states and act
accordingly.

if the genpd is initially off, the user should set the
state_idx field when registering the genpd.

An genpd with multiple states would look something like:

static int pd1_power_on(struct generic_pm_domain *domain)
{
	/* domain->state_idx contains state the domain is coming from */
}

static int pd1_power_off(struct generic_pm_domain *domain)
{
	/* domain->state_idx contains desired powered off state */
}

struct genpd_power_state pd_states[] = {
	{
		.name = "RET",
		.power_on_latency_ns = ON_LATENCY_FAST,
		.power_off_latency_ns = OFF_LATENCY_FAST,
	},
	{
		.name = "DEEP_RET",
		.power_on_latency_ns = ON_LATENCY_MED,
		.power_off_latency_ns = OFF_LATENCY_MED,
	},
	{
		.name = "OFF",
		.power_on_latency_ns = ON_LATENCY_SLOW,
		.power_off_latency_ns = OFF_LATENCY_SLOW,
	}
};

struct generic_pm_domain pd1 = {
	.name = "PD1",
	.states = pd_states,
	.state_count = ARRAY_SIZE(pd_states),
	.state_idx = 2, /* needed if domain is off at init. */
	.power_on = pd1_power_on,
	.power_off = pd1_power_off,
	...
};

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/domain.c          | 102 +++++++++++++++++++++++++++++++----
 drivers/base/power/domain_governor.c |  15 ++++--
 include/linux/pm_domain.h            |  10 ++++
 3 files changed, 115 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 45937f8..b519926 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -141,12 +141,17 @@ static void genpd_set_active(struct generic_pm_domain *genpd)
 
 static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 {
+	int state_idx = genpd->state_idx;
 	s64 usecs64;
 
 	if (!genpd->cpuidle_data)
 		return;
 
-	usecs64 = genpd->power_on_latency_ns;
+	if (genpd->state_count == 0)
+		usecs64 = genpd->power_on_latency_ns;
+	else
+		usecs64 = genpd->states[state_idx].power_on_latency_ns;
+
 	do_div(usecs64, NSEC_PER_USEC);
 	usecs64 += genpd->cpuidle_data->saved_exit_latency;
 	genpd->cpuidle_data->idle_state->exit_latency = usecs64;
@@ -154,6 +159,7 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 
 static int genpd_power_on(struct generic_pm_domain *genpd)
 {
+	int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -167,10 +173,16 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_on_latency_ns)
-		return ret;
+	if (genpd->state_count == 0) {
+		if (elapsed_ns <= genpd->power_on_latency_ns)
+			return ret;
+		genpd->power_on_latency_ns = elapsed_ns;
+	} else {
+		if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
+			return ret;
+		genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
+	}
 
-	genpd->power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	genpd_recalc_cpu_exit_latency(genpd);
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
@@ -181,6 +193,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 
 static int genpd_power_off(struct generic_pm_domain *genpd)
 {
+	int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -194,10 +207,15 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_off_latency_ns)
-		return ret;
-
-	genpd->power_off_latency_ns = elapsed_ns;
+	if (genpd->state_count == 0) {
+		if (elapsed_ns <= genpd->power_off_latency_ns)
+			return ret;
+		genpd->power_off_latency_ns = elapsed_ns;
+	} else {
+		if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
+			return ret;
+		genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
+	}
 	genpd->max_off_time_changed = true;
 	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
 		genpd->name, "off", elapsed_ns);
@@ -486,6 +504,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 	unsigned int not_suspended;
+	int state_idx;
 	int ret = 0;
 
  start:
@@ -538,6 +557,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 
 	genpd->status = GPD_STATE_BUSY;
 	genpd->poweroff_task = current;
+	state_idx = genpd->state_idx;
 
 	list_for_each_entry_reverse(pdd, &genpd->dev_list, list_node) {
 		ret = atomic_read(&genpd->sd_count) == 0 ?
@@ -1438,6 +1458,54 @@ static void genpd_free_dev_data(struct device *dev,
 	kfree(gpd_data);
 	dev_pm_put_subsys_data(dev);
 }
+/**
+ * genpd_alloc_states_data - Allocate and copy state parameters
+ * @genpd: PM domain use to copy and allocate data
+ */
+static struct genpd_power_state *genpd_alloc_states_data(
+			struct generic_pm_domain *genpd)
+{
+	struct genpd_power_state *states;
+	size_t states_size;
+	int i;
+
+	if (IS_ERR_OR_NULL(genpd))
+		return NULL;
+
+	if (!genpd->states) {
+		pr_err("%s Null state pointer\n", genpd->name);
+		return NULL;
+	}
+
+	if (genpd->state_count < 1) {
+		pr_err("%s Invalid number of states %d\n",
+			genpd->name, genpd->state_count);
+		return NULL;
+	}
+
+	/* Allocate the local memory to keep the states for this genpd */
+	states_size = sizeof(*states) * genpd->state_count;
+	states = kzalloc(states_size, GFP_KERNEL);
+	if (!states) {
+		pr_err("%s states Allocation error\n", genpd->name);
+		return NULL;
+	}
+
+	/* Copy the parameters passed to the allocated structure */
+	for (i = 0; i < genpd->state_count; i++) {
+		states[i].power_off_latency_ns =
+			genpd->states[i].power_off_latency_ns;
+		states[i].power_on_latency_ns =
+			genpd->states[i].power_on_latency_ns;
+	}
+
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+	/* State name is used for debug. Avoid unnecessary allocations */
+	for (i = 0; i < genpd->state_count; i++)
+		states[i].name = kstrdup(genpd->states[i].name, GFP_KERNEL);
+#endif
+	return states;
+}
 
 /**
  * __pm_genpd_add_device - Add a device to an I/O PM domain.
@@ -1863,6 +1931,13 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd))
 		return;
 
+	if (genpd->state_count > 0) {
+		/* Copy the state data to allocated memory */
+		genpd->states = genpd_alloc_states_data(genpd);
+		if (!genpd->states)
+			return;
+	}
+
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
@@ -2251,6 +2326,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 		[GPD_STATE_REPEAT] = "off-in-progress",
 		[GPD_STATE_POWER_OFF] = "off"
 	};
+	int state_idx = genpd->state_idx;
 	struct pm_domain_data *pm_data;
 	const char *kobj_path;
 	struct gpd_link *link;
@@ -2262,7 +2338,15 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-	seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
+
+	if (genpd->state_count == 0)
+		seq_printf(s, "%-30s  %-15s  ",
+			genpd->name, status_lookup[genpd->status]);
+	else
+		seq_printf(s, "%-30s  %-15s  ", genpd->name,
+			(genpd->status == GPD_STATE_POWER_OFF) ?
+				genpd->states[state_idx].name :
+				status_lookup[genpd->status]);
 
 	/*
 	 * Modifications on the list require holding locks on both
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2a4154a..9d74885 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -124,8 +124,12 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		return genpd->cached_power_down_ok;
 	}
 
-	off_on_time_ns = genpd->power_off_latency_ns +
-				genpd->power_on_latency_ns;
+	if (genpd->state_count == 0)
+		off_on_time_ns = genpd->power_off_latency_ns +
+			genpd->power_on_latency_ns;
+	else
+		off_on_time_ns = genpd->states[0].power_off_latency_ns +
+			genpd->states[0].power_on_latency_ns;
 	/*
 	 * It doesn't make sense to remove power from the domain if saving
 	 * the state of all devices in it and the power off/power on operations
@@ -216,7 +220,12 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
 	 */
-	genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
+	if (genpd->state_count == 0)
+		genpd->max_off_time_ns =
+			min_off_time_ns - genpd->power_on_latency_ns;
+	else
+		genpd->max_off_time_ns = min_off_time_ns -
+			genpd->states[0].power_on_latency_ns;
 	return true;
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 080e778..25082f6 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -46,6 +46,12 @@ struct gpd_cpuidle_data {
 	struct cpuidle_state *idle_state;
 };
 
+struct genpd_power_state {
+	char *name;
+	s64 power_off_latency_ns;
+	s64 power_on_latency_ns;
+};
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
@@ -80,6 +86,10 @@ struct generic_pm_domain {
 	void (*detach_dev)(struct generic_pm_domain *domain,
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
+	struct genpd_power_state *states;
+	int state_count; /* number of states */
+	int state_idx; /* state that genpd will go to when off */
+
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
1.9.1

