From: ahaslam@baylibre.com
Subject: [RFC v11 1/3] PM / Domains: Support for multiple states
Date: Tue,  9 Feb 2016 14:15:49 +0100
Message-ID: <1455023751-32521-2-git-send-email-ahaslam@baylibre.com>
References: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38811 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133AbcBINQO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 08:16:14 -0500
Received: by mail-wm0-f43.google.com with SMTP id p63so22641065wmp.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 05:16:13 -0800 (PST)
In-Reply-To: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, lina.iyer@linaro.org
Cc: khilman@baylibre.com, linux-pm@vger.kernel.org, geert@linux-m68k.org, mtitinger@baylibre.com, rjw@rjwysocki.net, bcousson@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Some hardware (eg. OMAP), has the ability to enter different low power
modes for a given power domain. This allows for more fine grained control
over the power state of the platform. As a typical example, some registers
of the hardware may be implemented with retention flip-flops and be able to
retain their state at lower voltages allowing for faster on/off latencies
and an increased window of opportunity to enter an intermediate low power
state other than "off"

When trying to set a power domain to off, the genpd governor will
choose the deepest state that will respect the qos constraints of all the
devices and sub-domains on the power domain. The state chosen by the
governor is saved in the "state_idx" field of the generic_pm_domain structure
and shall be used by the power_off and power_on callbacks to perform the
necessary actions to set the power domain into (and out of) the state
indicated by state_idx.

States shall be declared in ascending order from shallowest to deepest,
deepest meaning the state which takes longer to enter and exit.

For plaforms that are declaring power on and off latencies, on platorm
data, a single state is allocated which uses those values. Once all
platforms are converted to use the state array, the legacy on/off latencies
will be removed.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
[Lina: Modified genpd state initialization and remove use of
save_state_latency_ns in genpd timing data]
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c          | 59 +++++++++++++++++++++++++++---
 drivers/base/power/domain_governor.c | 70 +++++++++++++++++++++++-------------
 include/linux/pm_domain.h            |  9 +++++
 3 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 301b785..7099eb3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -104,6 +104,7 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 
 static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
+	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -120,10 +121,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-	if (elapsed_ns <= genpd->power_on_latency_ns)
+	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
 		return ret;
 
-	genpd->power_on_latency_ns = elapsed_ns;
+	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "on", elapsed_ns);
@@ -133,6 +134,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 
 static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 {
+	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
 	int ret;
@@ -149,10 +151,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
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
@@ -585,6 +587,8 @@ static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd,
 	    || atomic_read(&genpd->sd_count) > 0)
 		return;
 
+	/* Choose the deepest state when suspending */
+	genpd->state_idx = genpd->state_count - 1;
 	genpd_power_off(genpd, timed);
 
 	genpd->status = GPD_STATE_POWER_OFF;
@@ -1210,6 +1214,36 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
+static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(genpd)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	genpd->states = kcalloc(1, sizeof(struct genpd_power_state),
+				GFP_KERNEL);
+	if (!genpd->states) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	genpd->states[0].power_on_latency_ns =
+				genpd->power_on_latency_ns;
+
+	genpd->states[0].power_off_latency_ns =
+				genpd->power_off_latency_ns;
+
+	genpd->state_count = 1;
+	genpd->state_idx = 0;
+
+	return 0;
+err:
+	return ret;
+}
+
 /**
  * __pm_genpd_add_device - Add a device to an I/O PM domain.
  * @genpd: PM domain to add the device to.
@@ -1464,9 +1498,19 @@ static int pm_genpd_default_restore_state(struct device *dev)
 void pm_genpd_init(struct generic_pm_domain *genpd,
 		   struct dev_power_governor *gov, bool is_off)
 {
+	int ret;
+
 	if (IS_ERR_OR_NULL(genpd))
 		return;
 
+	if (genpd->state_count == 0) {
+		ret = genpd_alloc_default_state(genpd);
+		if (ret) {
+			pr_err("unable to allocate default state.");
+			return;
+		}
+	}
+
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
@@ -1872,7 +1916,12 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-	seq_printf(s, "%-30s  %-15s ", genpd->name, status_lookup[genpd->status]);
+	seq_printf(s, "%-30s  %s", genpd->name, status_lookup[genpd->status]);
+
+	if (genpd->status == GPD_STATE_POWER_OFF)
+		seq_printf(s, " %-13d ", genpd->state_idx);
+	else
+		seq_printf(s, " %-15s ", "");
 
 	/*
 	 * Modifications on the list require holding locks on both
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 1e937ac..c4fe0f1 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -98,7 +98,8 @@ static bool default_stop_ok(struct device *dev)
  *
  * This routine must be executed under the PM domain's lock.
  */
-static bool default_power_down_ok(struct dev_pm_domain *pd)
+static bool __default_power_down_ok(struct dev_pm_domain *pd,
+				     unsigned int state)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
@@ -106,27 +107,9 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
 
-	if (genpd->max_off_time_changed) {
-		struct gpd_link *link;
-
-		/*
-		 * We have to invalidate the cached results for the masters, so
-		 * use the observation that default_power_down_ok() is not
-		 * going to be called for any master until this instance
-		 * returns.
-		 */
-		list_for_each_entry(link, &genpd->slave_links, slave_node)
-			link->master->max_off_time_changed = true;
-
-		genpd->max_off_time_changed = false;
-		genpd->cached_power_down_ok = false;
-		genpd->max_off_time_ns = -1;
-	} else {
-		return genpd->cached_power_down_ok;
-	}
+	off_on_time_ns = genpd->states[state].power_off_latency_ns +
+		genpd->states[state].power_on_latency_ns;
 
-	off_on_time_ns = genpd->power_off_latency_ns +
-				genpd->power_on_latency_ns;
 
 	min_off_time_ns = -1;
 	/*
@@ -186,8 +169,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 			min_off_time_ns = constraint_ns;
 	}
 
-	genpd->cached_power_down_ok = true;
-
 	/*
 	 * If the computed minimum device off time is negative, there are no
 	 * latency constraints, so the domain can spend arbitrary time in the
@@ -201,10 +182,51 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
 	 */
-	genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
+	genpd->max_off_time_ns = min_off_time_ns -
+		genpd->states[state].power_on_latency_ns;
 	return true;
 }
 
+static bool default_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct gpd_link *link;
+
+	/* There should always be at least one state. */
+	if (genpd->state_count < 1) {
+		pr_err("Invalid state count.");
+		return false;
+	}
+
+	if (!genpd->max_off_time_changed)
+		return genpd->cached_power_down_ok;
+
+	/*
+	 * We have to invalidate the cached results for the masters, so
+	 * use the observation that default_power_down_ok() is not
+	 * going to be called for any master until this instance
+	 * returns.
+	 */
+	list_for_each_entry(link, &genpd->slave_links, slave_node)
+		link->master->max_off_time_changed = true;
+
+	genpd->max_off_time_ns = -1;
+	genpd->max_off_time_changed = false;
+	genpd->cached_power_down_ok = true;
+	genpd->state_idx = genpd->state_count - 1;
+
+	/* Find a state to power down to, starting from the deepest. */
+	while (!__default_power_down_ok(pd, genpd->state_idx)) {
+		if (genpd->state_idx == 0) {
+			genpd->cached_power_down_ok = false;
+			break;
+		}
+		genpd->state_idx--;
+	}
+
+	return genpd->cached_power_down_ok;
+}
+
 static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 {
 	return false;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index db21d39..a5c3b68 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -37,6 +37,11 @@ struct gpd_dev_ops {
 	bool (*active_wakeup)(struct device *dev);
 };
 
+struct genpd_power_state {
+	s64 power_off_latency_ns;
+	s64 power_on_latency_ns;
+};
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
@@ -66,6 +71,10 @@ struct generic_pm_domain {
 	void (*detach_dev)(struct generic_pm_domain *domain,
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
+	struct genpd_power_state *states;
+	unsigned int state_count; /* number of states */
+	unsigned int state_idx; /* state that genpd will go to when off */
+
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
2.6.3

