From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: governor: Ensure sufficiently large sampling intervals
Date: Mon, 18 Dec 2017 02:15:32 +0100
Message-ID: <5893809.nB6uDLgMiy@aspire.rjw.lan>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <002001d37577$9706a730$c513f590$@net> <002501d375d2$54f942c0$feebc840$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61508 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757508AbdLRBQU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Dec 2017 20:16:20 -0500
In-Reply-To: <002501d375d2$54f942c0$feebc840$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, 'Andy Tang' <andy.tang@nxp.com>, 'Linux PM' <linux-pm@vger.kernel.org>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit aa7519af450d (cpufreq: Use transition_delay_us for legacy
governors as well) the sampling_rate field of struct dbs_data may be
less than the tick period which causes dbs_update() to produce
incorrect results, so make the code ensure that the value of that
field will always be sufficiently large.

Fixes: aa7519af450d (cpufreq: Use transition_delay_us for legacy governors as well)
Reported-by: Andy Tang <andy.tang@nxp.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -22,6 +22,8 @@
 
 #include "cpufreq_governor.h"
 
+#define CPUFREQ_DBS_MIN_SAMPLING_INTERVAL	(2 * TICK_NSEC / NSEC_PER_USEC)
+
 static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
 
 static DEFINE_MUTEX(gov_dbs_data_mutex);
@@ -47,11 +49,15 @@ ssize_t store_sampling_rate(struct gov_a
 {
 	struct dbs_data *dbs_data = to_dbs_data(attr_set);
 	struct policy_dbs_info *policy_dbs;
+	unsigned int sampling_interval;
 	int ret;
-	ret = sscanf(buf, "%u", &dbs_data->sampling_rate);
-	if (ret != 1)
+
+	ret = sscanf(buf, "%u", &sampling_interval);
+	if (ret != 1 || sampling_interval < CPUFREQ_DBS_MIN_SAMPLING_INTERVAL)
 		return -EINVAL;
 
+	dbs_data->sampling_rate = sampling_interval;
+
 	/*
 	 * We are operating under dbs_data->mutex and so the list and its
 	 * entries can't be freed concurrently.
@@ -430,7 +436,14 @@ int cpufreq_dbs_governor_init(struct cpu
 	if (ret)
 		goto free_policy_dbs_info;
 
-	dbs_data->sampling_rate = cpufreq_policy_transition_delay_us(policy);
+	/*
+	 * The sampling interval should not be less than the transition latency
+	 * of the CPU and it also cannot be too small for dbs_update() to work
+	 * correctly.
+	 */
+	dbs_data->sampling_rate = max_t(unsigned int,
+					CPUFREQ_DBS_MIN_SAMPLING_INTERVAL,
+					cpufreq_policy_transition_delay_us(policy));
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = dbs_data;
