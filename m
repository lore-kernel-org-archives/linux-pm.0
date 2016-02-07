From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpufreq: governor: Simplify cpufreq_governor_limits()
Date: Sun, 07 Feb 2016 16:23:49 +0100
Message-ID: <1465939.LaiBibfCQO@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <9008098.QDD8C89zDx@vostro.rjw.lan> <2998470.K7oslgfuja@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2998470.K7oslgfuja@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use the observation that cpufreq_governor_limits() doesn't have to
get to the policy object it wants to manipulate by walking the
reference chain cdbs->policy_dbs->policy, as the final pointer is
actually equal to its argument, and make it access the policy
object directy via its argument.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -518,20 +518,19 @@ static int cpufreq_governor_limits(struc
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
+	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 
 	/* State should be equivalent to START */
-	if (!cdbs->policy_dbs || !cdbs->policy_dbs->policy)
+	if (!policy_dbs || !policy_dbs->policy)
 		return -EBUSY;
 
-	mutex_lock(&cdbs->policy_dbs->timer_mutex);
-	if (policy->max < cdbs->policy_dbs->policy->cur)
-		__cpufreq_driver_target(cdbs->policy_dbs->policy, policy->max,
-					CPUFREQ_RELATION_H);
-	else if (policy->min > cdbs->policy_dbs->policy->cur)
-		__cpufreq_driver_target(cdbs->policy_dbs->policy, policy->min,
-					CPUFREQ_RELATION_L);
+	mutex_lock(&policy_dbs->timer_mutex);
+	if (policy->max < policy->cur)
+		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
+	else if (policy->min > policy->cur)
+		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
 	dbs_check_cpu(policy);
-	mutex_unlock(&cdbs->policy_dbs->timer_mutex);
+	mutex_unlock(&policy_dbs->timer_mutex);
 
 	return 0;
 }
