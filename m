From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 3/10] cpufreq: governor: Avoid passing dbs_data pointers around unnecessarily
Date: Fri, 05 Feb 2016 03:15:24 +0100
Message-ID: <2409601.HbxMdSfn4m@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44911 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752319AbcBECVi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 21:21:38 -0500
In-Reply-To: <9008098.QDD8C89zDx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do not pass struct dbs_data pointers to the family of functions
implementing governor operations in cpufreq_governor.c as they can
take that pointer from policy->governor by themselves.

The cpufreq_governor_init() case is slightly more complicated, since
policy->governor may be NULL when it is invoked, but then it can reach
the pointer in question via its cdata argument just fine.

While at it, rework cpufreq_governor_dbs() to avoid a pointless
policy_governor check in the CPUFREQ_GOV_POLICY_INIT case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   68 ++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -325,9 +325,9 @@ static void free_common_dbs_info(struct
 }
 
 static int cpufreq_governor_init(struct cpufreq_policy *policy,
-				 struct dbs_data *dbs_data,
 				 struct common_dbs_data *cdata)
 {
+	struct dbs_data *dbs_data = cdata->gdbs_data;
 	unsigned int latency;
 	int ret;
 
@@ -399,9 +399,9 @@ free_dbs_data:
 	return ret;
 }
 
-static int cpufreq_governor_exit(struct cpufreq_policy *policy,
-				 struct dbs_data *dbs_data)
+static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
 
@@ -428,9 +428,9 @@ static int cpufreq_governor_exit(struct
 	return 0;
 }
 
-static int cpufreq_governor_start(struct cpufreq_policy *policy,
-				  struct dbs_data *dbs_data)
+static int cpufreq_governor_start(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
@@ -497,9 +497,9 @@ static int cpufreq_governor_start(struct
 	return 0;
 }
 
-static int cpufreq_governor_stop(struct cpufreq_policy *policy,
-				 struct dbs_data *dbs_data)
+static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
 
@@ -513,9 +513,9 @@ static int cpufreq_governor_stop(struct
 	return 0;
 }
 
-static int cpufreq_governor_limits(struct cpufreq_policy *policy,
-				   struct dbs_data *dbs_data)
+static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
@@ -540,45 +540,31 @@ static int cpufreq_governor_limits(struc
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 			 struct common_dbs_data *cdata, unsigned int event)
 {
-	struct dbs_data *dbs_data;
-	int ret;
+	int ret = -EINVAL;
 
 	/* Lock governor to block concurrent initialization of governor */
 	mutex_lock(&dbs_data_mutex);
 
-	if (have_governor_per_policy())
-		dbs_data = policy->governor_data;
-	else
-		dbs_data = cdata->gdbs_data;
-
-	if (!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT)) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	switch (event) {
-	case CPUFREQ_GOV_POLICY_INIT:
-		ret = cpufreq_governor_init(policy, dbs_data, cdata);
-		break;
-	case CPUFREQ_GOV_POLICY_EXIT:
-		ret = cpufreq_governor_exit(policy, dbs_data);
-		break;
-	case CPUFREQ_GOV_START:
-		ret = cpufreq_governor_start(policy, dbs_data);
-		break;
-	case CPUFREQ_GOV_STOP:
-		ret = cpufreq_governor_stop(policy, dbs_data);
-		break;
-	case CPUFREQ_GOV_LIMITS:
-		ret = cpufreq_governor_limits(policy, dbs_data);
-		break;
-	default:
-		ret = -EINVAL;
+	if (event == CPUFREQ_GOV_POLICY_INIT) {
+		ret = cpufreq_governor_init(policy, cdata);
+	} else if (policy->governor_data) {
+		switch (event) {
+		case CPUFREQ_GOV_POLICY_EXIT:
+			ret = cpufreq_governor_exit(policy);
+			break;
+		case CPUFREQ_GOV_START:
+			ret = cpufreq_governor_start(policy);
+			break;
+		case CPUFREQ_GOV_STOP:
+			ret = cpufreq_governor_stop(policy);
+			break;
+		case CPUFREQ_GOV_LIMITS:
+			ret = cpufreq_governor_limits(policy);
+			break;
+		}
 	}
 
-unlock:
 	mutex_unlock(&dbs_data_mutex);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);

