From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/3] cpufreq: Restructure if/else block to avoid unintended
 behavior
Date: Thu, 12 Sep 2013 01:43:25 +0530
Message-ID: <20130911201313.7832.32462.stgit@srivatsabhat.in.ibm.com>
References: <20130911201239.7832.72612.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130911201239.7832.72612.stgit@srivatsabhat.in.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@wwwdotorg.org, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

In __cpufreq_remove_dev_prepare(), the code which decides whether to remove
the sysfs link or nominate a new policy cpu, is governed by an if/else block
with a rather complex set of conditionals. Worse, they harbor a subtlety
which leads to certain unintended behavior.

The code looks like this:

        if (cpu != policy->cpu && !frozen) {
                sysfs_remove_link(&dev->kobj, "cpufreq");
        } else if (cpus > 1) {
		new_cpu = cpufreq_nominate_new_policy_cpu(...);
		...
		update_policy_cpu(..., new_cpu);
	}

The original intention was:
If the CPU going offline is not policy->cpu, just remove the link.
On the other hand, if the CPU going offline is the policy->cpu itself,
handover the policy->cpu job to some other surviving CPU in that policy.

But because the 'if' condition also includes the 'frozen' check, now there
are *two* possibilities by which we can enter the 'else' block:

1. cpu == policy->cpu (intended)
2. cpu != policy->cpu && frozen (unintended)

Due to the second (unintended) scenario, we end up spuriously nominating
a CPU as the policy->cpu, even when the existing policy->cpu is alive and
well. This can cause problems further down the line, especially when we end
up nominating the same policy->cpu as the new one (ie., old == new),
because it totally confuses update_policy_cpu().

To avoid this mess, restructure the if/else block to only do what was
originally intended, and thus prevent any unwelcome surprises.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
---

 drivers/cpufreq/cpufreq.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 62bdb95..247842b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1193,8 +1193,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 		cpumask_clear_cpu(cpu, policy->cpus);
 	unlock_policy_rwsem_write(cpu);
 
-	if (cpu != policy->cpu && !frozen) {
-		sysfs_remove_link(&dev->kobj, "cpufreq");
+	if (cpu != policy->cpu) {
+		if (!frozen)
+			sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else if (cpus > 1) {
 
 		new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu, frozen);

