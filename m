From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH] cpufreq: Remove unnecessary braces
Date: Wed, 19 Mar 2014 23:33:00 +0200
Message-ID: <532A0D0C.50507@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Remove 3 sets of unnecessary braces

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1eafd8c..ca3c01f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1325,17 +1325,16 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 	cpus = cpumask_weight(policy->cpus);
 	up_read(&policy->rwsem);
 
-	if (cpu != policy->cpu) {
+	if (cpu != policy->cpu)
 		sysfs_remove_link(&dev->kobj, "cpufreq");
-	} else if (cpus > 1) {
+	else if (cpus > 1) {
 		new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu);
 		if (new_cpu >= 0) {
 			update_policy_cpu(policy, new_cpu);
 
-			if (!cpufreq_suspended) {
+			if (!cpufreq_suspended)
 				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
 					 __func__, new_cpu, cpu);
-			}
 		}
 	}
 
@@ -2158,11 +2157,9 @@ int cpufreq_update_policy(unsigned int cpu)
 		if (!policy->cur) {
 			pr_debug("Driver did not initialize current freq\n");
 			policy->cur = new_policy.cur;
-		} else {
-			if (policy->cur != new_policy.cur && has_target())
+		} else if (policy->cur != new_policy.cur && has_target())
 				cpufreq_out_of_sync(cpu, policy->cur,
 								new_policy.cur);
-		}
 	}
 
 	ret = cpufreq_set_policy(policy, &new_policy);
-- 
1.8.5.3
