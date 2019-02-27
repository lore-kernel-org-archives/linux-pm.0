From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v12 2/4] PM / Domains: Add support for CPU devices to genpd
Date: Wed, 27 Feb 2019 20:58:34 +0100
Message-ID: <20190227195836.24739-3-ulf.hansson@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227195836.24739-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To enable a device belonging to a CPU to be attached to a PM domain managed
by genpd, let's do a few changes to it, as to make it convenient to manage
the specifics around CPUs.

To be able to quickly find out what CPUs that are attached to a genpd,
which typically becomes useful from a genpd governor as following changes
is about to show, let's add a cpumask to the struct generic_pm_domain. At
the point when a CPU device gets attached to a genpd, let's update the
genpd's cpumask. Moreover, let's also propagate changes to the cpumask
upwards in the topology to the master PM domains. In this way, the cpumask
for a genpd hierarchically reflects all CPUs attached to the topology below
it.

Finally, let's make this an opt-in feature, to avoid having to manage CPUs
and the cpumask for a genpd that doesn't need it. For that reason, let's
add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v12:
	- None.

---
 drivers/base/power/domain.c | 66 ++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   | 13 ++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 03885c003c6a..da10052e6427 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
+#include <linux/cpu.h>
 
 #include "power.h"
 
@@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
+#define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -1452,6 +1454,56 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
+static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
+				   int cpu, bool set, unsigned int depth)
+{
+	struct gpd_link *link;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		struct generic_pm_domain *master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		__genpd_update_cpumask(master, cpu, set, depth + 1);
+		genpd_unlock(master);
+	}
+
+	if (set)
+		cpumask_set_cpu(cpu, genpd->cpus);
+	else
+		cpumask_clear_cpu(cpu, genpd->cpus);
+}
+
+static void genpd_update_cpumask(struct generic_pm_domain *genpd,
+				 struct device *dev, bool set)
+{
+	int cpu;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (get_cpu_device(cpu) == dev) {
+			__genpd_update_cpumask(genpd, cpu, set, 0);
+			return;
+		}
+	}
+}
+
+static void genpd_set_cpumask(struct generic_pm_domain *genpd,
+			      struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, true);
+}
+
+static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
+				struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, false);
+}
+
 static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			    struct gpd_timing_data *td)
 {
@@ -1473,6 +1525,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		goto out;
 
+	genpd_set_cpumask(genpd, dev);
+
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1534,6 +1588,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
+	genpd_clear_cpumask(genpd, dev);
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
@@ -1767,11 +1822,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
 		return -EINVAL;
 
+	if (genpd_is_cpu_domain(genpd) &&
+	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* Use only one "off" state if there were no states declared */
 	if (genpd->state_count == 0) {
 		ret = genpd_set_default_power_state(genpd);
-		if (ret)
+		if (ret) {
+			if (genpd_is_cpu_domain(genpd))
+				free_cpumask_var(genpd->cpus);
 			return ret;
+		}
 	} else if (!gov) {
 		pr_warn("%s : no governor for states\n", genpd->name);
 	}
@@ -1817,6 +1879,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
+	if (genpd_is_cpu_domain(genpd))
+		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
 		genpd->free_states(genpd->states, genpd->state_count);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 8e1399231753..a6e251fe9deb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
+#include <linux/cpumask.h>
 
 /*
  * Flags to control the behaviour of a genpd.
@@ -42,11 +43,22 @@
  * GENPD_FLAG_ACTIVE_WAKEUP:	Instructs genpd to keep the PM domain powered
  *				on, in case any of its attached devices is used
  *				in the wakeup path to serve system wakeups.
+ *
+ * GENPD_FLAG_CPU_DOMAIN:	Instructs genpd that it should expect to get
+ *				devices attached, which may belong to CPUs or
+ *				possibly have subdomains with CPUs attached.
+ *				This flag enables the genpd backend driver to
+ *				deploy idle power management support for CPUs
+ *				and groups of CPUs. Note that, the backend
+ *				driver must then comply with the so called,
+ *				last-man-standing algorithm, for the CPUs in the
+ *				PM domain.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
 #define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
+#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
@@ -94,6 +106,7 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
+	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct opp_table *opp_table;	/* OPP table of the genpd */
-- 
2.17.1
