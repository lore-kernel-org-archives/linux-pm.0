From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 33/34] cpufreq: speedstep: remove calls to cpufreq_notify_transition()
Date: Fri, 16 Aug 2013 07:55:30 +0530
Message-ID: <8602c77300aa5a535cf95df8eb884cc5f3b9c0ba.1376619363.git.viresh.kumar@linaro.org>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376619363.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376619363.git.viresh.kumar@linaro.org>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

Most of the drivers do following in their ->target_index() routines:

	struct cpufreq_freqs freqs;
	freqs.old = old freq...
	freqs.new = new freq...

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);

	/* Change rate here */

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);

This is replicated over all cpufreq drivers today and there doesn't exists a
good enough reason why this shouldn't be moved to cpufreq core instead.

Earlier patches have added support in cpufreq core to do cpufreq notification on
frequency change, this one removes it from this driver.

Some related minor cleanups are also done along with it.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/speedstep-centrino.c | 20 +-------------------
 drivers/cpufreq/speedstep-ich.c      |  9 ---------
 drivers/cpufreq/speedstep-smi.c      |  7 -------
 3 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index b7a2f8d..90b4581 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -424,9 +424,8 @@ static int centrino_cpu_exit(struct cpufreq_policy *policy)
 static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned int	msr, oldmsr = 0, h = 0, cpu = policy->cpu;
-	struct cpufreq_freqs	freqs;
 	int			retval = 0;
-	unsigned int		j, first_cpu, tmp;
+	unsigned int		j, first_cpu;
 	struct cpufreq_frequency_table *op_points;
 	cpumask_var_t covered_cpus;
 
@@ -474,15 +473,6 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 				goto out;
 			}
 
-			freqs.old = extract_clock(oldmsr, cpu, 0);
-			freqs.new = extract_clock(msr, cpu, 0);
-
-			pr_debug("target=%dkHz old=%d new=%d msr=%04x\n",
-				op_points->frequency, freqs.old, freqs.new, msr);
-
-			cpufreq_notify_transition(policy, &freqs,
-					CPUFREQ_PRECHANGE);
-
 			first_cpu = 0;
 			/* all but 16 LSB are reserved, treat them with care */
 			oldmsr &= ~0xffff;
@@ -497,8 +487,6 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 		cpumask_set_cpu(j, covered_cpus);
 	}
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
 	if (unlikely(retval)) {
 		/*
 		 * We have failed halfway through the frequency change.
@@ -509,12 +497,6 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 
 		for_each_cpu(j, covered_cpus)
 			wrmsr_on_cpu(j, MSR_IA32_PERF_CTL, oldmsr, h);
-
-		tmp = freqs.new;
-		freqs.new = freqs.old;
-		freqs.old = tmp;
-		cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-		cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 	}
 	retval = 0;
 
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index 707721e..7639b2b 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -258,21 +258,12 @@ static unsigned int speedstep_get(unsigned int cpu)
 static int speedstep_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned int policy_cpu;
-	struct cpufreq_freqs freqs;
 
 	policy_cpu = cpumask_any_and(policy->cpus, cpu_online_mask);
-	freqs.old = speedstep_get(policy_cpu);
-	freqs.new = speedstep_freqs[index].frequency;
-
-	pr_debug("transiting from %u to %u kHz\n", freqs.old, freqs.new);
-
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	smp_call_function_single(policy_cpu, _speedstep_set_state, &index,
 				 true);
 
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
 	return 0;
 }
 
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 19446e4..0f5326d 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -241,14 +241,7 @@ static void speedstep_set_state(unsigned int state)
  */
 static int speedstep_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	struct cpufreq_freqs freqs;
-
-	freqs.old = speedstep_freqs[speedstep_get_state()].frequency;
-	freqs.new = speedstep_freqs[index].frequency;
-
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 	speedstep_set_state(index);
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e
