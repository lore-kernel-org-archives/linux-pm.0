From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH] cpufreq: exynos: Broadcast frequency change notifications for
 all cores
Date: Tue, 13 Nov 2012 10:26:12 +0100
Message-ID: <1887364.fvxYYNb7Mm@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8963 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab2KMJ0S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 04:26:18 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Exynos SoCs all cores share the same frequency setting, so changing
frequency of one core will affect rest of cores.

This patch modifies the exynos-cpufreq driver to inform cpufreq core
about this behavior and broadcast frequency change notifications for all
cores.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index af2d81e..c0d54a8 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -100,7 +100,8 @@ static int exynos_target(struct cpufreq_policy *policy,
 	}
 	arm_volt = volt_table[index];
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	for_each_cpu(freqs.cpu, policy->cpus)
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	/* When the new frequency is higher than current frequency */
 	if ((freqs.new > freqs.old) && !safe_arm_volt) {
@@ -115,7 +116,8 @@ static int exynos_target(struct cpufreq_policy *policy,
 	if (freqs.new != freqs.old)
 		exynos_info->set_freq(old_index, index);
 
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	for_each_cpu(freqs.cpu, policy->cpus)
+		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	/* When the new frequency is lower than current frequency */
 	if ((freqs.new < freqs.old) ||
@@ -235,6 +237,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		cpumask_copy(policy->related_cpus, cpu_possible_mask);
 		cpumask_copy(policy->cpus, cpu_online_mask);
 	} else {
+		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 		cpumask_setall(policy->cpus);
 	}
 
-- 
1.8.0


