From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: Always remove sysfs cpuX/cpufreq link on ->remove_dev()
Date: Sat, 21 Nov 2015 09:06:49 +0530
Message-ID: <c194a71ce0a2fac9b8a2ee8d12a00ec1642f9784.1448076972.git.viresh.kumar@linaro.org>
References: <1448074212.3450.4.camel@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34418 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934857AbbKUDg7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2015 22:36:59 -0500
Received: by padhx2 with SMTP id hx2so134761067pad.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2015 19:36:59 -0800 (PST)
In-Reply-To: <1448074212.3450.4.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, srinivas.pandruvada@linux.intel.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Subsys interface's ->remove_dev() is called when the cpufreq driver is
unregistering or the CPU is getting physically removed. We keep removing
the cpuX/cpufreq link for all CPUs except the last one, which is a
mistake as all CPUs contain a link now.

Because of this, one CPU from each policy will still contain a link (to
an already removed policyX directory), after the cpufreq driver is
unregistered.

Fix that by removing the link first and then only see if the policy is
required to be freed. That will make sure that no links are left out.

Fixes: 96bdda61f58b ("cpufreq: create cpu/cpufreq/policyX directories")
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
[v2] Drop the unnecessary 'return', sorry about that :(

 drivers/cpufreq/cpufreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c48e7316d91..a83c995a62df 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1401,13 +1401,10 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
+	remove_cpu_dev_symlink(policy, cpu);
 
-	if (cpumask_empty(policy->real_cpus)) {
+	if (cpumask_empty(policy->real_cpus))
 		cpufreq_policy_free(policy, true);
-		return;
-	}
-
-	remove_cpu_dev_symlink(policy, cpu);
 }
 
 static void handle_update(struct work_struct *work)
-- 
2.6.2.198.g614a2ac

