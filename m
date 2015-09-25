From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 3/7] PM / Domains: prepare for devices that might register a power state
Date: Fri, 25 Sep 2015 15:04:05 +0200
Message-ID: <1443186249-14596-4-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, lina.iyer@linaro.org, Marc Titinger <mtitinger@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

Devices may register an intermediate retention state into the domain upon
attaching. Currently generic domain would register an array of states upon
init. This patch prepares for later insertion (sort per depth, remove).

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/base/power/domain.c | 187 +++++++++++++++++++-------------------------
 include/linux/pm_domain.h   |  18 ++++-
 2 files changed, 95 insertions(+), 110 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index aa8e842..8c8ea94 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
+#include <linux/sort.h>
 
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
@@ -50,12 +51,6 @@
 	__retval;								\
 })
 
-#define GENPD_MAX_NAME_SIZE 20
-
-static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
-				       const struct genpd_power_state *st,
-				       unsigned int st_count);
-
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
@@ -1353,46 +1348,6 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
-static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
-				   const struct genpd_power_state *st,
-				   unsigned int st_count)
-{
-	int ret = 0;
-	unsigned int i;
-
-	if (IS_ERR_OR_NULL(genpd)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	if (!st || (st_count < 1)) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	/* Allocate the local memory to keep the states for this genpd */
-	genpd->states = kcalloc(st_count, sizeof(*st), GFP_KERNEL);
-	if (!genpd->states) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < st_count; i++) {
-		genpd->states[i].power_on_latency_ns =
-			st[i].power_on_latency_ns;
-		genpd->states[i].power_off_latency_ns =
-			st[i].power_off_latency_ns;
-	}
-
-	genpd->state_count = st_count;
-
-	/* to save memory, Name allocation will happen if debug is enabled */
-	pm_genpd_alloc_states_names(genpd, st, st_count);
-
-err:
-	return ret;
-}
-
 /**
  * __pm_genpd_add_device - Add a device to an I/O PM domain.
  * @genpd: PM domain to add the device to.
@@ -1963,6 +1918,73 @@ int pm_genpd_add_pstates(struct generic_pm_domain *genpd,
 	return 0;
 }
 
+/*
+* state depth comparison function.
+*/
+static int state_cmp(const void *a, const void *b)
+{
+	struct genpd_power_state *state_a = (struct genpd_power_state *)(a);
+	struct genpd_power_state *state_b = (struct genpd_power_state *)(b);
+
+	s64 depth_a =
+	    state_a->power_on_latency_ns + state_a->power_off_latency_ns;
+	s64 depth_b =
+	    state_b->power_on_latency_ns + state_b->power_off_latency_ns;
+
+	return (depth_a > depth_b) ? 0 : -1;
+}
+
+/*
+ * TODO: antagonist routine.
+*/
+int pm_genpd_insert_state(struct generic_pm_domain *genpd,
+			  const struct genpd_power_state *state)
+{
+	int ret = 0;
+	int state_count = genpd->state_count;
+
+	if (IS_ERR_OR_NULL(genpd) || (!state))
+		ret = -EINVAL;
+
+	if (state_count >= GENPD_POWER_STATES_MAX)
+		ret = -ENOMEM;
+
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+	/* to save memory, Name allocation will happen if debug is enabled */
+	genpd->states[state_count].name = kstrndup(state->name,
+						   GENPD_MAX_NAME_SIZE,
+						   GFP_KERNEL);
+	if (!genpd->states[state_count].name) {
+		pr_err("%s Failed to allocate state '%s' name.\n",
+		       genpd->name, state->name);
+		ret = -ENOMEM;
+	}
+#endif
+	genpd_lock(genpd);
+
+	if (!ret) {
+		genpd->states[state_count].power_on_latency_ns =
+		    state->power_on_latency_ns;
+		genpd->states[state_count].power_off_latency_ns =
+		    state->power_off_latency_ns;
+		genpd->state_count++;
+	}
+
+	/* sort from shallowest to deepest */
+	sort(genpd->states, genpd->state_count,
+	     sizeof(genpd->states[0]), state_cmp, NULL /*generic swap */);
+
+	/* Sanity check for current state index */
+	if (genpd->state_idx >= genpd->state_count) {
+		pr_warn("pm domain %s Invalid initial state.\n", genpd->name);
+		genpd->state_idx = genpd->state_count - 1;
+	}
+
+	genpd_unlock(genpd);
+
+	return ret;
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1976,36 +1998,24 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 		   const struct genpd_power_state *states,
 		   unsigned int state_count, bool is_off)
 {
-	static const struct genpd_power_state genpd_default_state[] = {
-		{
-			.name = "OFF",
-			.power_off_latency_ns = 0,
-			.power_on_latency_ns = 0,
-		},
-	};
-	int ret;
+	int i;
 
 	if (IS_ERR_OR_NULL(genpd))
 		return;
 
-	/* If no states defined, use the default OFF state */
-	if (!states || (state_count < 1))
-		ret = genpd_alloc_states_data(genpd, genpd_default_state,
-					      ARRAY_SIZE(genpd_default_state));
-	else
-		ret = genpd_alloc_states_data(genpd, states, state_count);
-
-	if (ret) {
-		pr_err("Fail to allocate states for %s\n", genpd->name);
-		return;
-	}
+	/* simply use an array, we wish to add/remove new retention states
+	   from later device init/exit. */
+	memset(genpd->states, 0, GENPD_POWER_STATES_MAX
+	       * sizeof(struct genpd_power_state));
 
-	/* Sanity check for initial state */
-	if (genpd->state_idx >= genpd->state_count) {
-		pr_warn("pm domain %s Invalid initial state.\n",
-			genpd->name);
-		genpd->state_idx = genpd->state_count - 1;
-	}
+	if (!states || !state_count) {
+		/* require a provider for a default state */
+		genpd->state_count = 0;
+		genpd->state_idx = 0;
+	} else
+		for (i = 0; i < state_count; i++)
+			if (pm_genpd_insert_state(genpd, &states[i]))
+				return;
 
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
@@ -2364,33 +2374,6 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 #include <linux/kobject.h>
 static struct dentry *pm_genpd_debugfs_dir;
 
-static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
-				       const struct genpd_power_state *st,
-				       unsigned int st_count)
-{
-	unsigned int i;
-
-	if (IS_ERR_OR_NULL(genpd))
-		return -EINVAL;
-
-	if (genpd->state_count != st_count) {
-		pr_err("Invalid allocated state count\n");
-		return -EINVAL;
-	}
-
-	for (i = 0; i < st_count; i++) {
-		genpd->states[i].name = kstrndup(st[i].name,
-				GENPD_MAX_NAME_SIZE, GFP_KERNEL);
-		if (!genpd->states[i].name) {
-			pr_err("%s Failed to allocate state %d name.\n",
-				genpd->name, i);
-			return -ENOMEM;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * TODO: This function is a slightly modified version of rtpm_status_show
  * from sysfs.c, so generalize it.
@@ -2529,12 +2512,4 @@ static void __exit pm_genpd_debug_exit(void)
 {
 	debugfs_remove_recursive(pm_genpd_debugfs_dir);
 }
-__exitcall(pm_genpd_debug_exit);
-#else
-static inline int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
-					const struct genpd_power_state *st,
-					unsigned int st_count)
-{
-	return 0;
-}
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index da3c789..39dda2c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -45,6 +45,13 @@ struct gpd_cpuidle_data {
 	struct cpuidle_state *idle_state;
 };
 
+
+/* Arbitrary max number of devices registering a special
+ * retention state with the PD, to keep things simple.
+ */
+#define GENPD_POWER_STATES_MAX	12
+#define GENPD_MAX_NAME_SIZE	40
+
 struct genpd_power_state {
 	char *name;
 	s64 power_off_latency_ns;
@@ -81,7 +88,8 @@ struct generic_pm_domain {
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
 
-	struct genpd_power_state *states;
+	struct genpd_power_state states[GENPD_POWER_STATES_MAX];
+
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
 
@@ -163,10 +171,12 @@ extern int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
 extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
 extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_detach_cpuidle(const char *name);
+extern int pm_genpd_insert_state(struct generic_pm_domain *genpd,
+			const struct genpd_power_state *state);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
-			  struct dev_power_governor *gov,
-			  const struct genpd_power_state *states,
-			  unsigned int state_count, bool is_off);
+			struct dev_power_governor *gov,
+			const struct genpd_power_state *states,
+			unsigned int state_count, bool is_off);
 
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
-- 
1.9.1
