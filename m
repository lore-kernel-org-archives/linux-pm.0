From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v2 07/12] PM / cpu_domains: Add PM Domain governor for CPUs
Date: Fri, 12 Feb 2016 13:50:33 -0700
Message-ID: <1455310238-8963-8-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32975 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbcBLUvd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 15:51:33 -0500
Received: by mail-pf0-f182.google.com with SMTP id q63so52949801pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 12:51:33 -0800 (PST)
In-Reply-To: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>

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
Changes since RFC v1 -
- bug fix

 drivers/base/power/cpu_domains.c | 75 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
index c99710c..7069411 100644
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
 
@@ -52,6 +55,76 @@ struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
 	return res;
 }
 
+static bool cpu_pd_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct cpu_pm_domain *cpu_pd = to_cpu_pd(genpd);
+	int qos = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+	u64 sleep_ns;
+	ktime_t earliest, next_wakeup;
+	int cpu;
+	int i;
+
+	/* Reset the last set genpd state, default to index 0 */
+	genpd->state_idx = 0;
+
+	/* We dont want to power down, if QoS is 0 */
+	if (!qos)
+		return false;
+
+	/*
+	 * Find the sleep time for the cluster.
+	 * The time between now and the first wake up of any CPU that
+	 * are in this domain hierarchy is the time available for the
+	 * domain to be idle.
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
+		 * If we cant sleep to save power in the state, move on
+		 * to the next lower idle state.
+		 */
+		if (state_sleep_ns > sleep_ns)
+			continue;
+
+		/*
+		 * We also dont want to sleep more than we should to
+		 * gaurantee QoS.
+		 */
+		if (state_sleep_ns < (qos * NSEC_PER_USEC))
+			break;
+	}
+
+	if (i >= 0)
+		genpd->state_idx = i;
+
+	return  (i >= 0) ? true : false;
+}
+
+static struct dev_power_governor cpu_pd_gov = {
+	.power_down_ok = cpu_pd_down_ok,
+};
+
 static int cpu_pd_attach_cpu(struct cpu_pm_domain *cpu_pd, int cpu)
 {
 	int ret;
@@ -143,7 +216,7 @@ static struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
 
 	/* Register the CPU genpd */
 	pr_debug("adding %s as CPU PM domain.\n", pd->genpd->name);
-	ret = of_pm_genpd_init(dn, pd->genpd, &simple_qos_governor, false);
+	ret = of_pm_genpd_init(dn, pd->genpd, &cpu_pd_gov, false);
 	if (ret) {
 		pr_err("Unable to initialize domain %s\n", dn->full_name);
 		goto fail;
-- 
2.1.4

