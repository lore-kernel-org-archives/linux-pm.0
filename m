From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Always remove sysfs cpuX/cpufreq link on ->remove_dev()
Date: Sat, 21 Nov 2015 09:04:59 +0530
Message-ID: <1d6d4fe9794e4547e0a899141e67313e7d3f453a.1448076816.git.viresh.kumar@linaro.org>
References: <1448074212.3450.4.camel@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448074212.3450.4.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, srinivas.pandruvada@linux.intel.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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
@Srinivas: This should fix it for you.

 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c48e7316d91..163ba0503ddf 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1401,13 +1401,12 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
+	remove_cpu_dev_symlink(policy, cpu);
 
 	if (cpumask_empty(policy->real_cpus)) {
 		cpufreq_policy_free(policy, true);
 		return;
 	}
-
-	remove_cpu_dev_symlink(policy, cpu);
 }
 
 static void handle_update(struct work_struct *work)
-- 
2.6.2.198.g614a2ac
