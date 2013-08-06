From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/11] cpufreq: Fix broken usage of governor->owner's refcount
Date: Tue,  6 Aug 2013 22:53:10 +0530
Message-ID: <28d948514a30b279afb99ff156bc3a3f74234641.1375809311.git.viresh.kumar@linaro.org>
References: <cover.1375809311.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1375809311.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375809311.git.viresh.kumar@linaro.org>
References: <cover.1375809311.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Governor's owner refcount usage was broken. We should increment refcount only
when CPUFREQ_GOV_POLICY_INIT event has come and should decrement only if
CPUFREQ_GOV_POLICY_EXIT has come.

Currently there can be situations where governor is in use but we have allowed
it to be unloaded which may result in undefined behavior.
Lets fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fe04b79..62eddb6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1708,8 +1708,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 		}
 	}
 
-	if (!try_module_get(policy->governor->owner))
-		return -EINVAL;
+	if (event == CPUFREQ_GOV_POLICY_INIT)
+		if (!try_module_get(policy->governor->owner))
+			return -EINVAL;
 
 	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
 						policy->cpu, event);
@@ -1718,6 +1719,8 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 	if ((!policy->governor_enabled && (event == CPUFREQ_GOV_STOP)) ||
 	    (policy->governor_enabled && (event == CPUFREQ_GOV_START))) {
 		mutex_unlock(&cpufreq_governor_lock);
+		if (event == CPUFREQ_GOV_POLICY_INIT)
+			module_put(policy->governor->owner);
 		return -EBUSY;
 	}
 
@@ -1745,11 +1748,8 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 		mutex_unlock(&cpufreq_governor_lock);
 	}
 
-	/* we keep one module reference alive for
-			each CPU governed by this CPU */
-	if ((event != CPUFREQ_GOV_START) || ret)
-		module_put(policy->governor->owner);
-	if ((event == CPUFREQ_GOV_STOP) && !ret)
+	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
+			((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
 		module_put(policy->governor->owner);
 
 	return ret;
-- 
1.7.12.rc2.18.g61b472e

