From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 3/3] cpufreq: Prevent problems in update_policy_cpu() if
 last_cpu == new_cpu
Date: Thu, 12 Sep 2013 01:43:42 +0530
Message-ID: <20130911201334.7832.49714.stgit@srivatsabhat.in.ibm.com>
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

If update_policy_cpu() is invoked with the existing policy->cpu itself
as the new-cpu parameter, then a lot of things can go terribly wrong.

In its present form, update_policy_cpu() always assumes that the new-cpu
is different from policy->cpu and invokes other functions to perform their
respective updates. And those functions implement the actual update like
this:

per_cpu(..., new_cpu) = per_cpu(..., last_cpu);
per_cpu(..., last_cpu) = NULL;

Thus, when new_cpu == last_cpu, the final NULL assignment makes the per-cpu
references vanish into thin air! (memory leak). From there, it leads to more
problems: cpufreq_stats_create_table() now doesn't find the per-cpu reference
and hence tries to create a new sysfs-group; but sysfs already had created
the group earlier, so it complains that it cannot create a duplicate filename.
In short, the repercussions of a rather innocuous invocation of
update_policy_cpu() can turn out to be pretty nasty.

Ideally update_policy_cpu() should handle this situation (new == last)
gracefully, and not lead to such severe problems. So fix it by adding an
appropriate check.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
---

 drivers/cpufreq/cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 247842b..d32040c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -949,6 +949,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 
 static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
 {
+	if (cpu == policy->cpu)
+		return;
+
 	policy->last_cpu = policy->cpu;
 	policy->cpu = cpu;
 

