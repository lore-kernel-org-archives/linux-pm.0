From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v14 4/4] PM / Domains: Add genpd governor for CPUs
Date: Thu, 11 Apr 2019 20:17:33 +0200
Message-ID: <20190411181733.21437-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

After some preceding changes, PM domains managed by genpd may contain
CPU devices, so idle state residency values should be taken into
account during the state selection process. [The residency value is
the minimum amount of time to be spent by a CPU (or a group of CPUs)
in an idle state in order to save more energy than could be saved
by picking up a shallower idle state.]

For this purpose, add a new genpd governor, pm_domain_cpu_gov, to be
used for selecting idle states of PM domains with CPU devices attached
either directly or through subdomains.

The new governor computes the minimum expected idle duration for all
online CPUs attached to a PM domain and its subdomains.  Next, it
finds the deepest idle state whose target residency is within the
expected idle duration and selects it as the target idle state of
the domain.

It should be noted that the minimum expected idle duration computation
is based on the closest timer event information stored in the per-CPU
variables cpuidle_devices for all of the CPUs in the domain.  That
needs to be revisited in future, as obviously there are other reasons
why a CPU may be woken up from idle.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ rjw: Changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes in v4:
	- Fix build error when CONFIG_CPU_IDLE is unset.

---
 drivers/base/power/domain_governor.c | 67 +++++++++++++++++++++++++++-
 include/linux/pm_domain.h            |  4 ++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 4d07e38a8247..7912bc957244 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -10,6 +10,9 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/ktime.h>
 
 static int dev_update_qos_constraint(struct device *dev, void *data)
 {
@@ -210,8 +213,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
 
-	if (!genpd->max_off_time_changed)
+	if (!genpd->max_off_time_changed) {
+		genpd->state_idx = genpd->cached_power_down_state_idx;
 		return genpd->cached_power_down_ok;
+	}
 
 	/*
 	 * We have to invalidate the cached results for the masters, so
@@ -236,6 +241,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		genpd->state_idx--;
 	}
 
+	genpd->cached_power_down_state_idx = genpd->state_idx;
 	return genpd->cached_power_down_ok;
 }
 
@@ -244,6 +250,65 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 	return false;
 }
 
+#ifdef CONFIG_CPU_IDLE
+static bool cpu_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct cpuidle_device *dev;
+	ktime_t domain_wakeup, next_hrtimer;
+	s64 idle_duration_ns;
+	int cpu, i;
+
+	/* Validate dev PM QoS constraints. */
+	if (!default_power_down_ok(pd))
+		return false;
+
+	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
+		return true;
+
+	/*
+	 * Find the next wakeup for any of the online CPUs within the PM domain
+	 * and its subdomains. Note, we only need the genpd->cpus, as it already
+	 * contains a mask of all CPUs from subdomains.
+	 */
+	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		if (dev) {
+			next_hrtimer = READ_ONCE(dev->next_hrtimer);
+			if (ktime_before(next_hrtimer, domain_wakeup))
+				domain_wakeup = next_hrtimer;
+		}
+	}
+
+	/* The minimum idle duration is from now - until the next wakeup. */
+	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
+	if (idle_duration_ns <= 0)
+		return false;
+
+	/*
+	 * Find the deepest idle state that has its residency value satisfied
+	 * and by also taking into account the power off latency for the state.
+	 * Start at the state picked by the dev PM QoS constraint validation.
+	 */
+	i = genpd->state_idx;
+	do {
+		if (idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) {
+			genpd->state_idx = i;
+			return true;
+		}
+	} while (--i >= 0);
+
+	return false;
+}
+
+struct dev_power_governor pm_domain_cpu_gov = {
+	.suspend_ok = default_suspend_ok,
+	.power_down_ok = cpu_power_down_ok,
+};
+#endif
+
 struct dev_power_governor simple_qos_governor = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a6e251fe9deb..bc82e74560ee 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -118,6 +118,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -202,6 +203,9 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+#ifdef CONFIG_CPU_IDLE
+extern struct dev_power_governor pm_domain_cpu_gov;
+#endif
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
-- 
2.17.1
