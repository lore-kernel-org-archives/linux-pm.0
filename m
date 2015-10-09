From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC v2 2/6] PM / Domains: prepare for devices that might
 register a power state
Date: Fri, 9 Oct 2015 12:22:17 -0600
Message-ID: <20151009182217.GE921@linaro.org>
References: <20151006022702.GA78570@linaro.org>
 <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
 <1444141665-18534-3-git-send-email-mtitinger+renesas@baylibre.com>
 <20151008161156.GA921@linaro.org>
 <56178B44.6040604@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36165 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbbJISWV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 14:22:21 -0400
Received: by pablk4 with SMTP id lk4so93184996pab.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2015 11:22:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56178B44.6040604@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: khilman@kernel.org, rjw@rjwysocki.net, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>

On Fri, Oct 09 2015 at 03:39 -0600, Marc Titinger wrote:
>On 08/10/2015 18:11, Lina Iyer wrote:
>>Hi Marc,
>>
>>Thanks for rebasing on top of my latest series.
>>
>>On Tue, Oct 06 2015 at 08:27 -0600, Marc Titinger wrote:
>>>Devices may register an intermediate retention state into the domain upon
>>>
>>I may agree with the usability of dynamic adding a state to the domain,
>>but I dont see why a device attaching to a domain should bring about a
>>new domain state.
>
>Hi Lina,
>
>thanks a lot for taking the time to look into this. The initial 
>discussion behind it was about to see how a device like a PMU, FPU, 
>cache, or a Healthcheck IP in the same power domain than CPUs, with 
>special retention states can be handled in a way 'unified' with CPUs.
>Also I admit it is partly an attempt from us to create something 
>useful out of the "collision" of Axel's multiple states and your 
>CPUs-as-generic-power-domain-devices, hence the RFC!
>
>Looking at Juno for instance, she currently has a platform-initiated 
>mode implemented in the arm-trusted-firmware through psci as a 
>cpuidle-driver. the menu governor will select a possibly deep c-state, 
>but the last-man CPU and actual power state is known to ATF. Similarly 
>my idea was to have a genpd-initiated mode so to say, where the actual 
>power state results from the cpu-domain's governor choice based on 
>possible retention states, and their latency.
>
Okay, I must admit that my ideas are quite partial to OS-initiated PSCI
(v1.0 onwards). So you have C-States that allow domains to enter idle as
well. Fair.

>A Health-check IP or Cache will not (to my current knowledge) have a 
>driver calling runtime_put, but may have a retention state "D1_RET" 
>with a off/on latency between CPU_SLEEP and CLUSTER_SLEEP, so that 
>CLUSTER_SLEEP may be ruled out by the governor, but D1_RET is ok given 
>the time slot available. 
>
A couple of questions here.

You say there is no driver for HIP, is there a device for it atleast?
How is the CPU/Domain going to know if the HIP is running or not?

To me this seems like you want to set a QoS on the PM domain here.

>Some platform code can be called so that the 
>cluster goes to D1_RET in that case, upon the last-man CPU 
>waiting-for-interrupt. Note that in the case of a Health-Check HIP, 
>the state my actually be a working state (all CPUs power down, and 
>time slot OK for sampling stuff).
>
Building on my previous statement, if you have a QoS for a domain and a
domain governor, it could consider the QoS requirement and choose to do
retention. However that needs a driver or some entity that know the HIP
is requesting a D1_RET mode only.

>>
>>A domain should define its power states, independent of the devices that
>>may attach. The way I see it, devices have their own idle states and
>>domains have their own. I do see a relationship between possible domain
>>states depending on the states of the individual devices in the domain.
>>For ex, a CPU domain can only be in a retention state (low voltage,
>>memory retained), if its CPU devices are in retention state, i.e, the
>>domain cannot be powered off; alternately, the domain may be in
>>retention or power down if the CPU devices are in power down state.
>>
>>Could you elaborate on why this is a need?
>
>Well, it may not be a need TBH, it is an attempt to have cluster-level 
>devices act like hotplugged CPUs but with heterogeneous c-states and 
>latencies. I hope it makes some sense :)
>
Hmm.. Let me think about it.

What would be a difference between a cluster-level device and a CPU in
the same domain?

-- Lina

>Thanks,
>Marc.
>
>
>>
>>Thanks,
>>Lina
>>
>>>attaching. Currently generic domain would register an array of states
>>>upon
>>>init. This patch prepares for later insertion (sort per depth, remove).
>>>
>>>Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>>>---
>>>drivers/base/power/domain.c | 189
>>>+++++++++++++++++++-------------------------
>>>include/linux/pm_domain.h   |  18 ++++-
>>>2 files changed, 97 insertions(+), 110 deletions(-)
>>>
>>>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>index 3e27a2b..e5f4c00b 100644
>>>--- a/drivers/base/power/domain.c
>>>+++ b/drivers/base/power/domain.c
>>>@@ -19,6 +19,7 @@
>>>#include <linux/sched.h>
>>>#include <linux/suspend.h>
>>>#include <linux/export.h>
>>>+#include <linux/sort.h>
>>>
>>>#define GENPD_RETRY_MAX_MS    250        /* Approximate */
>>>
>>>@@ -50,12 +51,6 @@
>>>    __retval;                                \
>>>})
>>>
>>>-#define GENPD_MAX_NAME_SIZE 20
>>>-
>>>-static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>>>-                       const struct genpd_power_state *st,
>>>-                       unsigned int st_count);
>>>-
>>>static LIST_HEAD(gpd_list);
>>>static DEFINE_MUTEX(gpd_list_lock);
>>>
>>>@@ -1364,46 +1359,6 @@ static void genpd_free_dev_data(struct device
>>>*dev,
>>>    dev_pm_put_subsys_data(dev);
>>>}
>>>
>>>-static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
>>>-                   const struct genpd_power_state *st,
>>>-                   unsigned int st_count)
>>>-{
>>>-    int ret = 0;
>>>-    unsigned int i;
>>>-
>>>-    if (IS_ERR_OR_NULL(genpd)) {
>>>-        ret = -EINVAL;
>>>-        goto err;
>>>-    }
>>>-
>>>-    if (!st || (st_count < 1)) {
>>>-        ret = -EINVAL;
>>>-        goto err;
>>>-    }
>>>-
>>>-    /* Allocate the local memory to keep the states for this genpd */
>>>-    genpd->states = kcalloc(st_count, sizeof(*st), GFP_KERNEL);
>>>-    if (!genpd->states) {
>>>-        ret = -ENOMEM;
>>>-        goto err;
>>>-    }
>>>-
>>>-    for (i = 0; i < st_count; i++) {
>>>-        genpd->states[i].power_on_latency_ns =
>>>-            st[i].power_on_latency_ns;
>>>-        genpd->states[i].power_off_latency_ns =
>>>-            st[i].power_off_latency_ns;
>>>-    }
>>>-
>>>-    genpd->state_count = st_count;
>>>-
>>>-    /* to save memory, Name allocation will happen if debug is
>>>enabled */
>>>-    pm_genpd_alloc_states_names(genpd, st, st_count);
>>>-
>>>-err:
>>>-    return ret;
>>>-}
>>>-
>>>/**
>>> * __pm_genpd_add_device - Add a device to an I/O PM domain.
>>> * @genpd: PM domain to add the device to.
>>>@@ -1833,6 +1788,75 @@ static void genpd_lock_init(struct
>>>generic_pm_domain *genpd)
>>>    }
>>>}
>>>
>>>+
>>>+/*
>>>+* state depth comparison function.
>>>+*/
>>>+static int state_cmp(const void *a, const void *b)
>>>+{
>>>+    struct genpd_power_state *state_a = (struct genpd_power_state *)(a);
>>>+    struct genpd_power_state *state_b = (struct genpd_power_state *)(b);
>>>+
>>>+    s64 depth_a =
>>>+        state_a->power_on_latency_ns + state_a->power_off_latency_ns;
>>>+    s64 depth_b =
>>>+        state_b->power_on_latency_ns + state_b->power_off_latency_ns;
>>>+
>>>+    return (depth_a > depth_b) ? 0 : -1;
>>>+}
>>>+
>>>+/*
>>>+* TODO: antagonist routine.
>>>+*/
>>>+int pm_genpd_insert_state(struct generic_pm_domain *genpd,
>>>+    const struct genpd_power_state *state)
>>>+{
>>>+    int ret = 0;
>>>+    int state_count = genpd->state_count;
>>>+
>>>+    if (IS_ERR_OR_NULL(genpd) || (!state))
>>>+        ret = -EINVAL;
>>>+
>>>+    if (state_count >= GENPD_POWER_STATES_MAX)
>>>+        ret = -ENOMEM;
>>>+
>>>+#ifdef CONFIG_PM_ADVANCED_DEBUG
>>>+    /* to save memory, Name allocation will happen if debug is
>>>enabled */
>>>+    genpd->states[state_count].name = kstrndup(state->name,
>>>+            GENPD_MAX_NAME_SIZE,
>>>+            GFP_KERNEL);
>>>+    if (!genpd->states[state_count].name) {
>>>+        pr_err("%s Failed to allocate state '%s' name.\n",
>>>+            genpd->name, state->name);
>>>+        ret = -ENOMEM;
>>>+    }
>>>+#endif
>>>+    genpd_lock(genpd);
>>>+
>>>+    if (!ret) {
>>>+        genpd->states[state_count].power_on_latency_ns =
>>>+            state->power_on_latency_ns;
>>>+        genpd->states[state_count].power_off_latency_ns =
>>>+            state->power_off_latency_ns;
>>>+        genpd->state_count++;
>>>+    }
>>>+
>>>+    /* sort from shallowest to deepest */
>>>+    sort(genpd->states, genpd->state_count,
>>>+        sizeof(genpd->states[0]), state_cmp, NULL /*generic swap */);
>>>+
>>>+    /* Sanity check for current state index */
>>>+    if (genpd->state_idx >= genpd->state_count) {
>>>+        pr_warn("pm domain %s Invalid initial state.\n", genpd->name);
>>>+        genpd->state_idx = genpd->state_count - 1;
>>>+    }
>>>+
>>>+    genpd_unlock(genpd);
>>>+
>>>+    return ret;
>>>+}
>>>+
>>>+
>>>/**
>>> * pm_genpd_init - Initialize a generic I/O PM domain object.
>>> * @genpd: PM domain object to initialize.
>>>@@ -1846,36 +1870,24 @@ void pm_genpd_init(struct generic_pm_domain
>>>*genpd,
>>>           const struct genpd_power_state *states,
>>>           unsigned int state_count, bool is_off)
>>>{
>>>-    static const struct genpd_power_state genpd_default_state[] = {
>>>-        {
>>>-            .name = "OFF",
>>>-            .power_off_latency_ns = 0,
>>>-            .power_on_latency_ns = 0,
>>>-        },
>>>-    };
>>>-    int ret;
>>>+    int i;
>>>
>>>    if (IS_ERR_OR_NULL(genpd))
>>>        return;
>>>
>>>-    /* If no states defined, use the default OFF state */
>>>-    if (!states || (state_count < 1))
>>>-        ret = genpd_alloc_states_data(genpd, genpd_default_state,
>>>-                          ARRAY_SIZE(genpd_default_state));
>>>-    else
>>>-        ret = genpd_alloc_states_data(genpd, states, state_count);
>>>-
>>>-    if (ret) {
>>>-        pr_err("Fail to allocate states for %s\n", genpd->name);
>>>-        return;
>>>-    }
>>>+    /* simply use an array, we wish to add/remove new retention states
>>>+       from later device init/exit. */
>>>+    memset(genpd->states, 0, GENPD_POWER_STATES_MAX
>>>+           * sizeof(struct genpd_power_state));
>>>
>>>-    /* Sanity check for initial state */
>>>-    if (genpd->state_idx >= genpd->state_count) {
>>>-        pr_warn("pm domain %s Invalid initial state.\n",
>>>-            genpd->name);
>>>-        genpd->state_idx = genpd->state_count - 1;
>>>-    }
>>>+    if (!states || !state_count) {
>>>+        /* require a provider for a default state */
>>>+        genpd->state_count = 0;
>>>+        genpd->state_idx = 0;
>>>+    } else
>>>+        for (i = 0; i < state_count; i++)
>>>+            if (pm_genpd_insert_state(genpd, &states[i]))
>>>+                return;
>>>
>>>    INIT_LIST_HEAD(&genpd->master_links);
>>>    INIT_LIST_HEAD(&genpd->slave_links);
>>>@@ -2233,33 +2245,6 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>>>#include <linux/kobject.h>
>>>static struct dentry *pm_genpd_debugfs_dir;
>>>
>>>-static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
>>>-                       const struct genpd_power_state *st,
>>>-                       unsigned int st_count)
>>>-{
>>>-    unsigned int i;
>>>-
>>>-    if (IS_ERR_OR_NULL(genpd))
>>>-        return -EINVAL;
>>>-
>>>-    if (genpd->state_count != st_count) {
>>>-        pr_err("Invalid allocated state count\n");
>>>-        return -EINVAL;
>>>-    }
>>>-
>>>-    for (i = 0; i < st_count; i++) {
>>>-        genpd->states[i].name = kstrndup(st[i].name,
>>>-                GENPD_MAX_NAME_SIZE, GFP_KERNEL);
>>>-        if (!genpd->states[i].name) {
>>>-            pr_err("%s Failed to allocate state %d name.\n",
>>>-                genpd->name, i);
>>>-            return -ENOMEM;
>>>-        }
>>>-    }
>>>-
>>>-    return 0;
>>>-}
>>>-
>>>/*
>>> * TODO: This function is a slightly modified version of rtpm_status_show
>>> * from sysfs.c, so generalize it.
>>>@@ -2398,12 +2383,4 @@ static void __exit pm_genpd_debug_exit(void)
>>>{
>>>    debugfs_remove_recursive(pm_genpd_debugfs_dir);
>>>}
>>>-__exitcall(pm_genpd_debug_exit);
>>>-#else
>>>-static inline int pm_genpd_alloc_states_names(struct
>>>generic_pm_domain *genpd,
>>>-                    const struct genpd_power_state *st,
>>>-                    unsigned int st_count)
>>>-{
>>>-    return 0;
>>>-}
>>>#endif /* CONFIG_PM_ADVANCED_DEBUG */
>>>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>>>index 9d37292..8a4eab0 100644
>>>--- a/include/linux/pm_domain.h
>>>+++ b/include/linux/pm_domain.h
>>>@@ -45,6 +45,13 @@ struct gpd_cpuidle_data {
>>>    struct cpuidle_state *idle_state;
>>>};
>>>
>>>+
>>>+/* Arbitrary max number of devices registering a special
>>>+ * retention state with the PD, to keep things simple.
>>>+ */
>>>+#define GENPD_POWER_STATES_MAX    12
>>>+#define GENPD_MAX_NAME_SIZE    40
>>>+
>>>struct genpd_power_state {
>>>    char *name;
>>>    s64 power_off_latency_ns;
>>>@@ -80,7 +87,8 @@ struct generic_pm_domain {
>>>               struct device *dev);
>>>    unsigned int flags;        /* Bit field of configs for genpd */
>>>
>>>-    struct genpd_power_state *states;
>>>+    struct genpd_power_state states[GENPD_POWER_STATES_MAX];
>>>+
>>>    unsigned int state_count; /* number of states */
>>>    unsigned int state_idx; /* state that genpd will go to when off */
>>>
>>>@@ -159,10 +167,12 @@ extern int pm_genpd_attach_cpuidle(struct
>>>generic_pm_domain *genpd, int state);
>>>extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
>>>extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
>>>extern int pm_genpd_name_detach_cpuidle(const char *name);
>>>+extern int pm_genpd_insert_state(struct generic_pm_domain *genpd,
>>>+            const struct genpd_power_state *state);
>>>extern void pm_genpd_init(struct generic_pm_domain *genpd,
>>>-              struct dev_power_governor *gov,
>>>-              const struct genpd_power_state *states,
>>>-              unsigned int state_count, bool is_off);
>>>+            struct dev_power_governor *gov,
>>>+            const struct genpd_power_state *states,
>>>+            unsigned int state_count, bool is_off);
>>>
>>>extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
>>>extern int pm_genpd_name_poweron(const char *domain_name);
>>>--
>>>1.9.1
>>>
>
