From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Fri,  1 Aug 2014 15:55:58 +0530
Message-ID: <2b0ca5cc52f1840c70cbf8208d7f620f0898364e.1406888629.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

commit 92c14bd9477a20a83144f08c0ca25b0308bf0730 upstream.

This is only relevant to implementations with multiple clusters, where clusters
have separate clock lines but all CPUs within a cluster share it.

Consider a dual cluster platform with 2 cores per cluster. During suspend we
start hot unplugging CPUs in order 1 to 3. When CPU2 is removed, policy->kobj
would be moved to CPU3 and when CPU3 goes down we wouldn't free policy or its
kobj as we want to retain permissions/values/etc.

Now on resume, we will get CPU2 before CPU3 and will call __cpufreq_add_dev().
We will recover the old policy and update policy->cpu from 3 to 2 from
update_policy_cpu().

But the kobj is still tied to CPU3 and isn't moved to CPU2. We wouldn't create a
link for CPU2, but would try that for CPU3 while bringing it online. Which will
report errors as CPU3 already has kobj assigned to it.

This bug got introduced with commit 42f921a, which overlooked this scenario.

To fix this, lets move kobj to the new policy->cpu while bringing first CPU of a
cluster back. Also do a WARN_ON() if kobject_move failed, as we would reach here
only for the first CPU of a non-boot cluster. And we can't recover from this
situation, if kobject_move() fails.

Fixes: ("42f921a cpufreq: remove sysfs files for CPUs which failed to come back after resume")
Cc: <stable@vger.kernel.org> # 3.13
Cc: <stable@vger.kernel.org> # 3.14
Reported-and-tested-by: Bu Yitian <ybu@qti.qualcomm.com>
Reported-by: Saravana Kannan <skannan@codeaurora.org>
Reviewed-by: Srivatsa S. Bhat <srivatsa@mit.edu>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 199b52b..153f4b9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1089,10 +1089,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 	 * the creation of a brand new one. So we need to perform this update
 	 * by invoking update_policy_cpu().
 	 */
-	if (frozen && cpu != policy->cpu)
+	if (frozen && cpu != policy->cpu) {
 		update_policy_cpu(policy, cpu);
-	else
+		WARN_ON(kobject_move(&policy->kobj, &dev->kobj));
+	} else {
 		policy->cpu = cpu;
+	}
 
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
-- 
2.0.0.rc2
