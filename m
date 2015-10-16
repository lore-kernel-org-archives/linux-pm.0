From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 2/6] PM / Domains: core changes for multiple states
Date: Fri, 16 Oct 2015 16:51:48 -0600
Message-ID: <20151016225148.GA72832@linaro.org>
References: <1444911396-3473-1-git-send-email-ahaslam@baylibre.com>
 <1444911396-3473-3-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32904 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbJPWvv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 18:51:51 -0400
Received: by pabrc13 with SMTP id rc13so132278582pab.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 15:51:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444911396-3473-3-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: khilman@linaro.org, ulf.hansson@linaro.org, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, bcousson@baylibre.com, mturquette@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

On Thu, Oct 15 2015 at 06:16 -0600, ahaslam@baylibre.com wrote:
>From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
>Add the core changes to be able to declare multiple states.
>When trying to set a power domain to off, genpd will be able to choose
>from an array of states declared by the platform. The power on and off
>latencies are now tied to a state.
>
>States should be declared in ascending order from shallowest to deepest,
>deepest meaning the state which takes longer to enter and exit.
>
>the power_off and power_on function can use the 'state_idx' field of the
>generic_pm_domain structure, to distinguish between the different states
>and act accordingly.
>
>Example:
>
>static int pd1_power_on(struct generic_pm_domain *domain)
>{
>	/* domain->state_idx = state the domain is coming from */
>}
>
>static int pd1_power_off(struct generic_pm_domain *domain)
>{
>	/* domain->state_idx = desired powered off state */
>}
>
>const struct genpd_power_state pd_states[] = {
>	{
>		.name = "RET",
>		.power_on_latency_ns = ON_LATENCY_FAST,
>		.power_off_latency_ns = OFF_LATENCY_FAST,
>	},
>	{
>		.name = "DEEP_RET",
>		.power_on_latency_ns = ON_LATENCY_MED,
>		.power_off_latency_ns = OFF_LATENCY_MED,
>	},
>	{
>		.name = "OFF",
>		.power_on_latency_ns = ON_LATENCY_SLOW,
>		.power_off_latency_ns = OFF_LATENCY_SLOW,
>	}
>};
>
>struct generic_pm_domain pd1 = {
>	.name = "PD1",
>	.power_on = pd1_power_on,
>	.power_off = pd1_power_off,
>	[...]
>};
>
>int xxx_init_pm_domain(){
>
>	pm_genpd_init(struct generic_pm_domain,
>		pd1, pd_states, ARRAY_SIZE(pd_states), true);
>
>}
>
>Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>---
> drivers/base/power/domain.c          | 144 +++++++++++++++++++++++++++++++++--
> drivers/base/power/domain_governor.c |  13 +++-
> include/linux/pm_domain.h            |   4 +
> 3 files changed, 151 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index a51c4b0..c475fdd 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -50,6 +50,12 @@
> 	__retval;								\
> })
>
>+#define GENPD_MAX_NAME_SIZE 20
>+
>+static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>+				       const struct genpd_power_state *st,
>+				       unsigned int st_count);
>+
> static LIST_HEAD(gpd_list);
> static DEFINE_MUTEX(gpd_list_lock);
>
>@@ -142,12 +148,13 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>
> static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
> {

Could you rebase your patches on top of latest linux-next?

genpd->cpuidle_data is gone after this commit cea3ad93.

Thanks,
Lina

>+	unsigned int state_idx = genpd->state_idx;
> 	s64 usecs64;
>
> 	if (!genpd->cpuidle_data)
> 		return;
>
>-	usecs64 = genpd->power_on_latency_ns;
>+	usecs64 = genpd->states[state_idx].power_on_latency_ns;
> 	do_div(usecs64, NSEC_PER_USEC);
> 	usecs64 += genpd->cpuidle_data->saved_exit_latency;
> 	genpd->cpuidle_data->idle_state->exit_latency = usecs64;
>@@ -155,6 +162,7 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>
> static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> {
>+	unsigned int state_idx = genpd->state_idx;
> 	ktime_t time_start;
> 	s64 elapsed_ns;
> 	int ret;
>@@ -171,10 +179,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> 		return ret;
>
> 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>-	if (elapsed_ns <= genpd->power_on_latency_ns)
>+	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
> 		return ret;
>
>-	genpd->power_on_latency_ns = elapsed_ns;
>+	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
> 	genpd->max_off_time_changed = true;
> 	genpd_recalc_cpu_exit_latency(genpd);
> 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
>@@ -185,6 +193,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>
> static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
> {
>+	unsigned int state_idx = genpd->state_idx;
> 	ktime_t time_start;
> 	s64 elapsed_ns;
> 	int ret;
>@@ -201,10 +210,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
> 		return ret;
>
> 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>-	if (elapsed_ns <= genpd->power_off_latency_ns)
>+	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
> 		return ret;
>
>-	genpd->power_off_latency_ns = elapsed_ns;
>+	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
> 	genpd->max_off_time_changed = true;
> 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> 		 genpd->name, "off", elapsed_ns);
>@@ -646,6 +655,8 @@ static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd,
> 	    || atomic_read(&genpd->sd_count) > 0)
> 		return;
>
>+	/* Choose the deepest state when suspending */
>+	genpd->state_idx = genpd->state_count - 1;
> 	genpd_power_off(genpd, timed);
>
> 	genpd->status = GPD_STATE_POWER_OFF;
>@@ -1268,6 +1279,61 @@ static void genpd_free_dev_data(struct device *dev,
> 	dev_pm_put_subsys_data(dev);
> }
>
>+static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
>+				   const struct genpd_power_state *st,
>+				   unsigned int st_count)
>+{
>+	int ret = 0;
>+	unsigned int i;
>+
>+	if (IS_ERR_OR_NULL(genpd)) {
>+		ret = -EINVAL;
>+		goto err;
>+	}
>+
>+	if (!st || (st_count < 1)) {
>+		ret = -EINVAL;
>+		goto err;
>+	}
>+
>+	/* Allocate the local memory to keep the states for this genpd */
>+	genpd->states = kcalloc(st_count, sizeof(*st), GFP_KERNEL);
>+	if (!genpd->states) {
>+		ret = -ENOMEM;
>+		goto err;
>+	}
>+
>+	for (i = 0; i < st_count; i++) {
>+		genpd->states[i].power_on_latency_ns =
>+			st[i].power_on_latency_ns;
>+		genpd->states[i].power_off_latency_ns =
>+			st[i].power_off_latency_ns;
>+	}
>+
>+	/*
>+	 * Copy the latency values To keep compatibility with
>+	 * platforms that are not converted to use the multiple states.
>+	 * This will be removed once all platforms are converted to use
>+	 * multiple states. note that non converted platforms will use the
>+	 * default single off state.
>+	 */
>+	if (genpd->power_on_latency_ns != 0)
>+		genpd->states[0].power_on_latency_ns =
>+				genpd->power_on_latency_ns;
>+
>+	if (genpd->power_off_latency_ns != 0)
>+		genpd->states[0].power_off_latency_ns =
>+				genpd->power_off_latency_ns;
>+
>+	genpd->state_count = st_count;
>+
>+	/* to save memory, Name allocation will happen if debug is enabled */
>+	pm_genpd_alloc_states_names(genpd, st, st_count);
>+
>+err:
>+	return ret;
>+}
>+
> /**
>  * __pm_genpd_add_device - Add a device to an I/O PM domain.
>  * @genpd: PM domain to add the device to.
>@@ -1683,9 +1749,23 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
> 		   const struct genpd_power_state *states,
> 		   unsigned int state_count, bool is_off)
> {
>+	int ret;
>+
> 	if (IS_ERR_OR_NULL(genpd))
> 		return;
>
>+	/* State data should be provided */
>+	if (!states || (state_count < 1)) {
>+		pr_err("Invalid state data\n");
>+		return;
>+	}
>+
>+	ret = genpd_alloc_states_data(genpd, states, state_count);
>+	if (ret) {
>+		pr_err("Failed to allocate states for %s\n", genpd->name);
>+		return;
>+	}
>+
> 	INIT_LIST_HEAD(&genpd->master_links);
> 	INIT_LIST_HEAD(&genpd->slave_links);
> 	INIT_LIST_HEAD(&genpd->dev_list);
>@@ -1698,6 +1778,8 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
> 	genpd->device_count = 0;
> 	genpd->max_off_time_ns = -1;
> 	genpd->max_off_time_changed = true;
>+	/* Assume the deepest state on init*/
>+	genpd->state_idx = genpd->state_count - 1;
> 	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
> 	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
> 	genpd->domain.ops.prepare = pm_genpd_prepare;
>@@ -1743,7 +1825,16 @@ EXPORT_SYMBOL_GPL(pm_genpd_init);
> void pm_genpd_init_simple(struct generic_pm_domain *genpd,
> 		   struct dev_power_governor *gov, bool is_off)
> {
>-	pm_genpd_init(genpd, gov, NULL, 0, is_off);
>+	static const struct genpd_power_state genpd_default_idle_states[] = {
>+		{
>+			.name = "OFF",
>+			.power_off_latency_ns = 0,
>+			.power_on_latency_ns = 0,
>+		},
>+	};
>+
>+	pm_genpd_init(genpd, gov, genpd_default_idle_states,
>+			ARRAY_SIZE(genpd_default_idle_states), is_off);
> }
> EXPORT_SYMBOL_GPL(pm_genpd_init_simple);
>
>@@ -2060,6 +2151,33 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
> #include <linux/kobject.h>
> static struct dentry *pm_genpd_debugfs_dir;
>
>+static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>+				       const struct genpd_power_state *st,
>+				       unsigned int st_count)
>+{
>+	unsigned int i;
>+
>+	if (IS_ERR_OR_NULL(genpd))
>+		return -EINVAL;
>+
>+	if (genpd->state_count != st_count) {
>+		pr_err("Invalid allocated state count\n");
>+		return -EINVAL;
>+	}
>+
>+	for (i = 0; i < st_count; i++) {
>+		genpd->states[i].name = kstrndup(st[i].name,
>+				GENPD_MAX_NAME_SIZE, GFP_KERNEL);
>+		if (!genpd->states[i].name) {
>+			pr_err("%s Failed to allocate state %d name.\n",
>+				genpd->name, i);
>+			return -ENOMEM;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
> /*
>  * TODO: This function is a slightly modified version of rtpm_status_show
>  * from sysfs.c, so generalize it.
>@@ -2093,6 +2211,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
> 		[GPD_STATE_ACTIVE] = "on",
> 		[GPD_STATE_POWER_OFF] = "off"
> 	};
>+	unsigned int state_idx = genpd->state_idx;
> 	struct pm_domain_data *pm_data;
> 	const char *kobj_path;
> 	struct gpd_link *link;
>@@ -2104,7 +2223,11 @@ static int pm_genpd_summary_one(struct seq_file *s,
>
> 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
> 		goto exit;
>-	seq_printf(s, "%-30s  %-15s ", genpd->name, status_lookup[genpd->status]);
>+
>+	seq_printf(s, "%-30s  %-15s  ", genpd->name,
>+		   (genpd->status == GPD_STATE_POWER_OFF) ?
>+		   genpd->states[state_idx].name :
>+		   status_lookup[genpd->status]);
>
> 	/*
> 	 * Modifications on the list require holding locks on both
>@@ -2192,4 +2315,11 @@ static void __exit pm_genpd_debug_exit(void)
> 	debugfs_remove_recursive(pm_genpd_debugfs_dir);
> }
> __exitcall(pm_genpd_debug_exit);
>+#else
>+static inline int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>+					const struct genpd_power_state *st,
>+					unsigned int st_count)
>+{
>+	return 0;
>+}
> #endif /* CONFIG_PM_ADVANCED_DEBUG */
>diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>index 2a4154a..5e63a84 100644
>--- a/drivers/base/power/domain_governor.c
>+++ b/drivers/base/power/domain_governor.c
>@@ -124,8 +124,12 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> 		return genpd->cached_power_down_ok;
> 	}
>
>-	off_on_time_ns = genpd->power_off_latency_ns +
>-				genpd->power_on_latency_ns;
>+	/*
>+	 * Use the only available state, until multiple state support is added
>+	 * to the governor.
>+	 */
>+	off_on_time_ns = genpd->states[0].power_off_latency_ns +
>+				genpd->states[0].power_on_latency_ns;
> 	/*
> 	 * It doesn't make sense to remove power from the domain if saving
> 	 * the state of all devices in it and the power off/power on operations
>@@ -215,8 +219,11 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> 	 * The difference between the computed minimum subdomain or device off
> 	 * time and the time needed to turn the domain on is the maximum
> 	 * theoretical time this domain can spend in the "off" state.
>+	 * Use the only available state, until multiple state support is added
>+	 * to the governor.
> 	 */
>-	genpd->max_off_time_ns = min_off_time_ns - genpd->power_on_latency_ns;
>+	genpd->max_off_time_ns = min_off_time_ns -
>+		genpd->states[0].power_on_latency_ns;
> 	return true;
> }
>
>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>index e5e7ca9..52d91d0 100644
>--- a/include/linux/pm_domain.h
>+++ b/include/linux/pm_domain.h
>@@ -80,6 +80,10 @@ struct generic_pm_domain {
> 	void (*detach_dev)(struct generic_pm_domain *domain,
> 			   struct device *dev);
> 	unsigned int flags;		/* Bit field of configs for genpd */
>+	struct genpd_power_state *states;
>+	unsigned int state_count; /* number of states */
>+	unsigned int state_idx; /* state that genpd will go to when off */
>+
> };
>
> static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
>-- 
>2.4.5
>
