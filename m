From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 2/3] cpufreq: pmac64: provide cpufreq transition latency for older G5 models
Date: Sat, 31 Aug 2013 20:23:51 +0300
Message-ID: <1377969832-27699-3-git-send-email-aaro.koskinen@iki.fi>
References: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:34923 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab3HaR0L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2013 13:26:11 -0400
In-Reply-To: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Currently cpufreq ondemand governor cannot used on older G5 models,
because the transition latency is set to CPUFREQ_ETERNAL. Provide a
value based on a measurement on Xserve G5, which happens to be also the
highest allowed latency.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/cpufreq/pmac64-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 674807d..d3d1995 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -674,8 +674,10 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 	g5_cpu_freqs[0].frequency = max_freq;
 	g5_cpu_freqs[1].frequency = min_freq;
 
+	/* Based on a measurement on Xserve G5, rounded up. */
+	transition_latency = 10 * NSEC_PER_MSEC;
+
 	/* Set callbacks */
-	transition_latency = CPUFREQ_ETERNAL;
 	g5_switch_volt = g5_pfunc_switch_volt;
 	g5_switch_freq = g5_pfunc_switch_freq;
 	g5_query_freq = g5_pfunc_query_freq;
-- 
1.8.3.2

