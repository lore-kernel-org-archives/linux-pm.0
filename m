From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 10/16] PM / cpu_domains: Add PM Domain governor for CPUs
Date: Thu, 25 Aug 2016 14:03:19 -0600
Message-ID: <1472155405-41841-11-git-send-email-lina.iyer@linaro.org>
References: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

A PM domain comprising of CPUs may be powered off when all the CPUs in
the domain are powered down. Powering down a CPU domain is generally a
expensive operation and therefore the power performance trade offs
should be considered. The time between the last CPU powering down and
the first CPU powering up in a domain, is the time available for the
domain to sleep. Ideally, the sleep time of the domain should fulfill
the residency requirement of the domains' idle state.

To do this effectively, read the time before the wakeup of the cluster's
CPUs and ensure that the domain's idle state sleep time guarantees the
QoS requirements of each of the CPU, the PM QoS CPU_DMA_LATENCY and the
state's residency.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/cpu_domains.c | 80 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
index 8bf61e2..79fa4ae 100644
--- a/drivers/base/power/cpu_domains.c
+++ b/drivers/base/power/cpu_domains.c
@@ -17,9 +17,12 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
+#include <linux/tick.h>
 
 #define CPU_PD_NAME_MAX 36
 
@@ -51,6 +54,81 @@ static inline struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
 	return res;
 }
 
+static bool cpu_pd_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct cpu_pm_domain *cpu_pd = to_cpu_pd(genpd);
+	int qos_ns = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+	u64 sleep_ns;
+	ktime_t earliest, next_wakeup;
+	int cpu;
+	int i;
+
+	/* Reset the last set genpd state, default to index 0 */
+	genpd->state_idx = 0;
+
+	/* We don't want to power down, if QoS is 0 */
+	if (!qos_ns)
+		return false;
+
+	/*
+	 * Find the sleep time for the cluster.
+	 * The time between now and the first wake up of any CPU that
+	 * are in this domain hierarchy is the time available for the
+	 * domain to be idle.
+	 *
+	 * We only care about the next wakeup for any online CPU in that
+	 * cluster. Hotplug off any of the CPUs that we care about will
+	 * wait on the genpd lock, until we are done. Any other CPU hotplug
+	 * is not of consequence to our sleep time.
+	 */
+	earliest = ktime_set(KTIME_SEC_MAX, 0);
+	for_each_cpu_and(cpu, cpu_pd->cpus, cpu_online_mask) {
+		next_wakeup = tick_nohz_get_next_wakeup(cpu);
+		if (earliest.tv64 > next_wakeup.tv64)
+			earliest = next_wakeup;
+	}
+
+	sleep_ns = ktime_to_ns(ktime_sub(earliest, ktime_get()));
+	if (sleep_ns <= 0)
+		return false;
+
+	/*
+	 * Find the deepest sleep state that satisfies the residency
+	 * requirement and the QoS constraint
+	 */
+	for (i = genpd->state_count - 1; i >= 0; i--) {
+		u64 state_sleep_ns;
+
+		state_sleep_ns = genpd->states[i].power_off_latency_ns +
+			genpd->states[i].power_on_latency_ns +
+			genpd->states[i].residency_ns;
+
+		/*
+		 * If we can't sleep to save power in the state, move on
+		 * to the next lower idle state.
+		 */
+		if (state_sleep_ns > sleep_ns)
+			continue;
+
+		/*
+		 * We also don't want to sleep more than we should to
+		 * gaurantee QoS.
+		 */
+		if (state_sleep_ns < (qos_ns * NSEC_PER_USEC))
+			break;
+	}
+
+	if (i >= 0)
+		genpd->state_idx = i;
+
+	return (i >= 0);
+}
+
+static struct dev_power_governor cpu_pd_gov = {
+	.power_down_ok = cpu_pd_down_ok,
+};
+
 static int cpu_pd_power_on(struct generic_pm_domain *genpd)
 {
 	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
@@ -172,7 +250,7 @@ struct generic_pm_domain *cpu_pd_init(struct generic_pm_domain *genpd,
 	list_add_rcu(&pd->link, &of_cpu_pd_list);
 	mutex_unlock(&cpu_pd_list_lock);
 
-	ret = pm_genpd_init(genpd, &simple_qos_governor, false);
+	ret = pm_genpd_init(genpd, &cpu_pd_gov, false);
 	if (ret) {
 		pr_err("Unable to initialize domain %s\n", genpd->name);
 		goto fail;
-- 
2.7.4
