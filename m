From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 09/15] PM / cpu_domains: Add PM Domain governor for CPUs
Date: Thu,  4 Aug 2016 17:04:56 -0600
Message-ID: <1470351902-43103-10-git-send-email-lina.iyer@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35067 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759373AbcHDXF4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2016 19:05:56 -0400
Received: by mail-pf0-f174.google.com with SMTP id x72so90842214pfd.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2016 16:05:56 -0700 (PDT)
In-Reply-To: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

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
index a25a77e..5dd28fd 100644
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
 
@@ -52,6 +55,81 @@ struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
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
 static int cpu_pd_attach_cpu(struct cpu_pm_domain *cpu_pd, int cpu)
 {
 	int ret;
@@ -165,7 +243,7 @@ static struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 
 	/* Register the CPU genpd */
 	pr_debug("adding %s as CPU PM domain\n", pd->genpd->name);
-	ret = pm_genpd_init(pd->genpd, &simple_qos_governor, false);
+	ret = pm_genpd_init(pd->genpd, &cpu_pd_gov, false);
 	if (ret) {
 		pr_err("Unable to initialize domain %s\n", dn->full_name);
 		goto fail;
-- 
2.7.4

