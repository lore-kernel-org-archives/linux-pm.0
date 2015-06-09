From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 5/6] cpufreq: Restart governor as soon as possible
Date: Tue, 9 Jun 2015 08:39:43 +0530
Message-ID: <20150609030943.GF4829@linux>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
 <5802c619494ba09e5c7621722e5a0778519c6a98.1433767914.git.viresh.kumar@linaro.org>
 <1969774.NfEI2hyvTT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34599 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbFIDJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 23:09:48 -0400
Received: by payr10 with SMTP id r10so4612980pay.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 20:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1969774.NfEI2hyvTT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On 09-06-15, 01:27, Rafael J. Wysocki wrote:
> Any explanation why this is correct here?

Does this look better ? (Code isn't updated)

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 19 Feb 2015 11:53:02 +0530
Subject: [PATCH] cpufreq: Restart governor as soon as possible

__cpufreq_remove_dev_finish() is doing two things today:
- Restarts the governor if some CPUs from concerned policy are still
  online.
- Frees the policy if all CPUs are offline.

The first task of restarting the governor can be moved to
__cpufreq_remove_dev_prepare() to restart the governor early. There is
no race between _prepare() and _finish() as they would be handling
completely different cases. _finish() will only be required if we are
going to free the policy and that has nothing to do with restarting the
governor.

[ Something similar attempted by Saravana earlier ]

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 59 +++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8b810071ddd2..c355ab656dfb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1428,8 +1428,8 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 static int __cpufreq_remove_dev_prepare(struct device *dev,
 					struct subsys_interface *sif)
 {
-	unsigned int cpu = dev->id, cpus;
-	int ret;
+	unsigned int cpu = dev->id;
+	int ret = 0;
 	struct cpufreq_policy *policy;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
@@ -1449,23 +1449,33 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 	}
 
 	down_write(&policy->rwsem);
-	cpus = cpumask_weight(policy->cpus);
+	cpumask_clear_cpu(cpu, policy->cpus);
 
-	if (has_target() && cpus == 1)
-		strncpy(policy->last_governor, policy->governor->name,
-			CPUFREQ_NAME_LEN);
+	if (policy_is_inactive(policy)) {
+		if (has_target())
+			strncpy(policy->last_governor, policy->governor->name,
+				CPUFREQ_NAME_LEN);
+	} else if (cpu == policy->cpu) {
+		/* Nominate new CPU */
+		policy->cpu = cpumask_any(policy->cpus);
+	}
 	up_write(&policy->rwsem);
 
-	if (cpu != policy->cpu)
-		return 0;
+	/* Start governor again for active policy */
+	if (!policy_is_inactive(policy)) {
+		if (has_target()) {
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			if (!ret)
+				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
-	if (cpus > 1)
-		/* Nominate new CPU */
-		update_policy_cpu(policy, cpumask_any_but(policy->cpus, cpu));
-	else if (cpufreq_driver->stop_cpu)
+			if (ret)
+				pr_err("%s: Failed to start governor\n", __func__);
+		}
+	} else if (cpufreq_driver->stop_cpu) {
 		cpufreq_driver->stop_cpu(policy);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int __cpufreq_remove_dev_finish(struct device *dev,
@@ -1473,33 +1483,16 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 {
 	unsigned int cpu = dev->id;
 	int ret;
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
 		return -EINVAL;
 	}
 
-	down_write(&policy->rwsem);
-	cpumask_clear_cpu(cpu, policy->cpus);
-	up_write(&policy->rwsem);
-
-	/* Not the last cpu of policy, start governor again ? */
-	if (!policy_is_inactive(policy)) {
-		if (!has_target())
-			return 0;
-
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
-		if (!ret)
-			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
-
-		if (ret) {
-			pr_err("%s: Failed to start governor\n", __func__);
-			return ret;
-		}
-
+	/* Only proceed for inactive policies */
+	if (!policy_is_inactive(policy))
 		return 0;
-	}
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {


-- 
viresh
