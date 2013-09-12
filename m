From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: Detect spurious invocations of update_policy_cpu()
Date: Thu, 12 Sep 2013 17:29:09 +0530
Message-ID: <20130912115710.25951.98497.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, viresh.kumar@linaro.org, swarren@wwwdotorg.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

The function update_policy_cpu() is expected to be called when the policy->cpu
of a cpufreq policy is to be changed: ie., the new CPU nominated to become the
policy->cpu is different from the old one.

Print a warning if it is invoked with new_cpu == old_cpu, since such an
invocation might hint at a faulty logic in the caller.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/cpufreq/cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 43c24aa..2084132 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -949,7 +949,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 
 static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
 {
-	if (cpu == policy->cpu)
+	if (WARN_ON(cpu == policy->cpu))
 		return;
 
 	policy->last_cpu = policy->cpu;

