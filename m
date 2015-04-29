From: ahaslam@baylibre.com
Subject: [PATCH/RFC v6 2/5] PM / Domains: core changes for multiple states
Date: Wed, 29 Apr 2015 21:10:12 +0200
Message-ID: <1430334615-1161-3-git-send-email-ahaslam@baylibre.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33090 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbD2TLU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 15:11:20 -0400
Received: by wief7 with SMTP id f7so47239421wie.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2015 12:11:19 -0700 (PDT)
In-Reply-To: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Add the core changes to be able to declare multiple states.
When trying to set a power domain to off, genpd will be able
to choose from an array of states declared by the platform.

The power on and off latencies are now tied to a state.

States should be declared in ascending order from shallowest
to deepest, deepest meaning the state which takes longer to
enter and exit.

the power_off and power_on function can use the 'state_idx'
field of the generic_pm_domain structure, to distinguish between
the different states and act accordingly.

 - if the genpd is initially off, the user should set the state_idx
   field when registering the genpd.

 - if no states are passed to pm_genpd_init, a single OFF
   state with no latency is assumed.

Example:

static int pd1_power_on(struct generic_pm_domain *domain)
{
	/* domain->state_idx = state the domain is coming from */
}

static int pd1_power_off(struct generic_pm_domain *domain)
{
	/* domain->state_idx = desired powered off state */
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
	.state_idx = 2, /* needed if domain is not on at init. */
	.power_on = pd1_power_on,
	.power_off = pd1_power_off,
	...
};

int xxx_init_pm_domain(){

	pm_genpd_init(struct generic_pm_domain,
			pd1, pd_states, ARRAY_SIZE(pd_states), true);

}

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain.c          | 145 +++++++++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c |  13 +++-
 include/linux/pm_domain.h            |   4 +
 3 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3849312..4ea1365 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -47,6 +47,12 @@
 	__retval;								\
 })
 
+#define GENPD_MAX_NAME_SIZE 20
+
+static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
+				       const struct genpd_power_state *st,
+				       int st_count);
+
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
@@ -170,12 +176,13 @@ static void genpd_set_active(struct generic_pm_domain *genpd)
 
 static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 {
+	int state_idx = genpd->state_idx;
 	s64 usecs64;
 
 	if (!genpd->cpuidle_data)
 		return;
 
-	usecs64 = genpd->power_on_latency_ns;
+	usecs64 = genpd->states[state_idx].power_on_latency_ns;
 	do_div(usecs64, NSEC_PER_USEC);
 	usecs64 += genpd->cpuidle_data->saved_exit_latency;
 	genpd->cpuidle_data->idle_state->exit_latency = usecs64;
@@ -183,6 +190,7 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
 
 static int genpd_power_on(struct generic_pm_domain *genpd)
 {
+	int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -196,10 +204,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_on_latency_ns)
+	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
 		return ret;
 
-	genpd->power_on_latency_ns = elapsed_ns;
+	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	genpd_recalc_cpu_exit_latency(genpd);
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
@@ -210,6 +218,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 
 static int genpd_power_off(struct generic_pm_domain *genpd)
 {
+	int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -223,10 +232,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_off_latency_ns)
+	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
 		return ret;
 
-	genpd->power_off_latency_ns = elapsed_ns;
+	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "off", elapsed_ns);
@@ -847,6 +856,8 @@ static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd)
 	    || atomic_read(&genpd->sd_count) > 0)
 		return;
 
+	/* Choose the deepest state when suspending */
+	genpd->state_idx = genpd->state_count - 1;
 	genpd_power_off(genpd);
 
 	genpd->status = GPD_STATE_POWER_OFF;
@@ -1468,6 +1479,61 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
+static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
+				   const struct genpd_power_state *st,
+				   int st_count)
+{
+	int ret = 0;
+	int i;
+
+	if (IS_ERR_OR_NULL(genpd)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (!st || (st_count < 1)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Allocate the local memory to keep the states for this genpd */
+	genpd->states = kcalloc(st_count, sizeof(*st), GFP_KERNEL);
+	if (!genpd->states) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < st_count; i++) {
+		genpd->states[i].power_on_latency_ns =
+			st[i].power_on_latency_ns;
+		genpd->states[i].power_off_latency_ns =
+			st[i].power_off_latency_ns;
+	}
+
+	/*
+	 * Copy the latency values To keep compatibility with
+	 * platfroms that are not converted to use the multiple states.
+	 * This will be removed once all platfroms are converted to use
+	 * multiple states. note that non converted platfroms will use the
+	 * default single off state.
+	 */
+	if (genpd->power_on_latency_ns != 0)
+		genpd->states[0].power_on_latency_ns =
+				genpd->power_on_latency_ns;
+
+	if (genpd->power_off_latency_ns != 0)
+		genpd->states[0].power_off_latency_ns =
+				genpd->power_off_latency_ns;
+
+	genpd->state_count = st_count;
+
+	/* to save memory, Name allocation will happen if debug is enabled */
+	pm_genpd_alloc_states_names(genpd, st, st_count);
+
+err:
+	return ret;
+}
+
 /**
  * __pm_genpd_add_device - Add a device to an I/O PM domain.
  * @genpd: PM domain to add the device to.
@@ -1891,9 +1957,37 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 		   const struct genpd_power_state *states,
 		   int state_count, bool is_off)
 {
+	static const struct genpd_power_state genpd_default_state[] = {
+		{
+			.name = "OFF",
+			.power_off_latency_ns = 0,
+			.power_on_latency_ns = 0,
+		},
+	};
+	int ret;
+
 	if (IS_ERR_OR_NULL(genpd))
 		return;
 
+	/* If no states defined, use the default OFF state */
+	if (!states || (state_count < 1))
+		ret = genpd_alloc_states_data(genpd, genpd_default_state,
+					      ARRAY_SIZE(genpd_default_state));
+	else
+		ret = genpd_alloc_states_data(genpd, states, state_count);
+
+	if (ret) {
+		pr_err("Fail to allocate states for %s\n", genpd->name);
+		return;
+	}
+
+	/* Sanity check for initial state */
+	if (genpd->state_idx >= genpd->state_count) {
+		pr_warn("pm domain %s Invalid initial state.\n",
+			genpd->name);
+		genpd->state_idx = genpd->state_count - 1;
+	}
+
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
@@ -2247,6 +2341,33 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 #include <linux/kobject.h>
 static struct dentry *pm_genpd_debugfs_dir;
 
+static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
+				       const struct genpd_power_state *st,
+				       int st_count)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(genpd))
+		return -EINVAL;
+
+	if (genpd->state_count != st_count) {
+		pr_err("Invalid allocated state count\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < st_count; i++) {
+		genpd->states[i].name = kstrndup(st[i].name,
+				GENPD_MAX_NAME_SIZE, GFP_KERNEL);
+		if (!genpd->states[i].name) {
+			pr_err("%s Failed to allocate state %d name.\n",
+				genpd->name, i);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * TODO: This function is a slightly modified version of rtpm_status_show
  * from sysfs.c, so generalize it.
@@ -2283,6 +2404,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 		[GPD_STATE_REPEAT] = "off-in-progress",
 		[GPD_STATE_POWER_OFF] = "off"
 	};
+	int state_idx = genpd->state_idx;
 	struct pm_domain_data *pm_data;
 	const char *kobj_path;
 	struct gpd_link *link;
@@ -2294,7 +2416,11 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-	seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
+
+	seq_printf(s, "%-30s  %-15s  ", genpd->name,
+		   (genpd->status == GPD_STATE_POWER_OFF) ?
+		   genpd->states[state_idx].name :
+		   status_lookup[genpd->status]);
 
 	/*
 	 * Modifications on the list require holding locks on both
@@ -2382,4 +2508,11 @@ static void __exit pm_genpd_debug_exit(void)
 	debugfs_remove_recursive(pm_genpd_debugfs_dir);
 }
 __exitcall(pm_genpd_debug_exit);
+#else
+static inline int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
+					const struct genpd_power_state *st,
+					int st_count)
+{
+	return 0;
+}
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2a4154a..5e63a84 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -124,8 +124,12 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		return genpd->cached_power_down_ok;
 	}
 
-	off_on_time_ns = genpd->power_off_latency_ns +
-				genpd->power_on_latency_ns;
+	/*
+	 * Use the only available state, until multiple state support is added
+	 * to the governor.
+	 */
+	off_on_time_ns = genpd->states[0].power_off_latency_ns +
+				genpd->states[0].power_on_latency_ns;
 	/*
 	 * It doesn't make sense to remove power from the domain if saving
 	 * the state of all devices in it and the power off/power on operations
@@ -215,8 +219,11 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	 * The difference between the computed minimum subdomain or device off
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
+	 * Use the only available state, until multiple state support is added
+	 * to the governor.
 	 */
-	genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
+	genpd->max_off_time_ns = min_off_time_ns -
+		genpd->states[0].power_on_latency_ns;
 	return true;
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 96265d5..8a3d43f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -86,6 +86,10 @@ struct generic_pm_domain {
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

