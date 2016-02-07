From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] cpufreq: governor: Symmetrize cpu_dbs_info initialization and cleanup
Date: Sun, 07 Feb 2016 16:25:02 +0100
Message-ID: <3371031.KKUQAzJ7qu@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan> <2998470.K7oslgfuja@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52607 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753885AbcBGPYG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 10:24:06 -0500
In-Reply-To: <2998470.K7oslgfuja@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the initialization of struct cpu_dbs_info objects in
alloc_policy_dbs_info() and the code that cleans them up in
free_policy_dbs_info() more symmetrical.  In particular,
set/clear the update_util.func field in those functions along
with the policy_dbs field.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -303,14 +303,18 @@ static struct policy_dbs_info *alloc_pol
 	if (!policy_dbs)
 		return NULL;
 
-	/* Set policy_dbs for all CPUs, online+offline */
-	for_each_cpu(j, policy->related_cpus)
-		gov->get_cpu_cdbs(j)->policy_dbs = policy_dbs;
-
 	mutex_init(&policy_dbs->timer_mutex);
 	atomic_set(&policy_dbs->skip_work, 0);
 	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
 	INIT_WORK(&policy_dbs->work, dbs_work_handler);
+
+	/* Set policy_dbs for all CPUs, online+offline */
+	for_each_cpu(j, policy->related_cpus) {
+		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
+
+		j_cdbs->policy_dbs = policy_dbs;
+		j_cdbs->update_util.func = dbs_update_util_handler;
+	}
 	return policy_dbs;
 }
 
@@ -323,9 +327,12 @@ static void free_policy_dbs_info(struct
 
 	mutex_destroy(&policy_dbs->timer_mutex);
 
-	for_each_cpu(j, policy->cpus)
-		gov->get_cpu_cdbs(j)->policy_dbs = NULL;
+	for_each_cpu(j, policy->related_cpus) {
+		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
 
+		j_cdbs->policy_dbs = NULL;
+		j_cdbs->update_util.func = NULL;
+	}
 	kfree(policy_dbs);
 }
 
@@ -476,8 +483,6 @@ static int cpufreq_governor_start(struct
 
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
-
-		j_cdbs->update_util.func = dbs_update_util_handler;
 	}
 	policy_dbs->policy = policy;
 

