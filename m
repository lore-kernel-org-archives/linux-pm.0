From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 10:49:01 +0530
Message-ID: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, srivatsa@mit.edu, skannan@codeaurora.org, ybu@qti.qualcomm.com, Viresh Kumar <viresh.kumar@linaro.org>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This is only relevant to implementations with multiple clusters, where clusters
have separate clock lines but all CPUs within a cluster share it.

Consider a dual cluster platform with 2 cores per cluster. During suspend we
start offlining CPUs from 1 to 3. When CPU2 is remove, policy->kobj would be
moved to CPU3 and when CPU3 goes down we wouldn't free policy or its kobj.

Now on resume, we will get CPU2 before CPU3 and will call __cpufreq_add_dev().
We will recover the old policy and update policy->cpu from 3 to 2 from
update_policy_cpu().

But the kobj is still tied to CPU3 and wasn't moved to CPU2. We wouldn't create
a link for CPU2, but would try that while bringing CPU3 online. Which will
report errors as CPU3 already has kobj assigned to it.

This bug got introduced with commit 42f921a, which overlooked this scenario.

To fix this, lets move kobj to the new policy->cpu while bringing first CPU of a
cluster back.

Fixes: ("42f921a cpufreq: remove sysfs files for CPUs which failed to come back after resume")
Cc: Stable <stable@vger.kernel.org> # 3.13+
Reported-by: Bu Yitian <ybu@qti.qualcomm.com>
Reported-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

This is for 3.16 release, please take it once Yitian/Saravana test this out.

@Yitian/Saravana: Sorry of overlooking this when both of you reported this
first. I (and Srivatsa as well) was damn sure that this scenario is taken into
account in current code and a close look proved that wrong.

I couldn't test it out, can any of you please see if it fixes things for you?

 drivers/cpufreq/cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 62259d2..6f02485 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1153,10 +1153,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	 * the creation of a brand new one. So we need to perform this update
 	 * by invoking update_policy_cpu().
 	 */
-	if (recover_policy && cpu != policy->cpu)
+	if (recover_policy && cpu != policy->cpu) {
 		update_policy_cpu(policy, cpu);
-	else
+		WARN_ON(kobject_move(&policy->kobj, &dev->kobj));
+	} else {
 		policy->cpu = cpu;
+	}
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
 
-- 
2.0.0.rc2
