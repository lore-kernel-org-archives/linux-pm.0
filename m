From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 12/13] cpufreq/sparc-us2e: Replace racy task affinity
 logic
Date: Thu, 13 Apr 2017 10:22:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1704131020280.2408@nanos>
References: <20170412200726.941336635@linutronix.de> <20170412201043.129216383@linutronix.de> <alpine.DEB.2.20.1704131017590.2408@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdDMIXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 04:23:03 -0400
In-Reply-To: <alpine.DEB.2.20.1704131017590.2408@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

The access to the HBIRD_ESTAR_MODE register in the cpu frequency control
functions must happen on the target CPU. This is achieved by temporarily
setting the affinity of the calling user space thread to the requested CPU
and reset it to the original affinity afterwards.

That's racy vs. CPU hotplug and concurrent affinity settings for that
thread resulting in code executing on the wrong CPU and overwriting the
new affinity setting.

Replace it by a straight forward smp function call. 

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---

V3: Include the proper patch
V2: Fix build-bot complaint (-ENOTAWAKEYET / -EWRONGPATCH)
 
 drivers/cpufreq/sparc-us2e-cpufreq.c |   45 ++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

Index: b/drivers/cpufreq/sparc-us2e-cpufreq.c
===================================================================
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -118,10 +118,6 @@ static void us2e_transition(unsigned lon
 			    unsigned long clock_tick,
 			    unsigned long old_divisor, unsigned long divisor)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-
 	estar &= ~ESTAR_MODE_DIV_MASK;
 
 	/* This is based upon the state transition diagram in the IIe manual.  */
@@ -152,8 +148,6 @@ static void us2e_transition(unsigned lon
 	} else {
 		BUG();
 	}
-
-	local_irq_restore(flags);
 }
 
 static unsigned long index_to_estar_mode(unsigned int index)
@@ -229,48 +223,51 @@ static unsigned long estar_to_divisor(un
 	return ret;
 }
 
+static void __us2e_freq_get(void *arg)
+{
+	unsigned long *estar = arg;
+
+	*estar = read_hbreg(HBIRD_ESTAR_MODE_ADDR);
+}
+
 static unsigned int us2e_freq_get(unsigned int cpu)
 {
-	cpumask_t cpus_allowed;
 	unsigned long clock_tick, estar;
 
-	cpumask_copy(&cpus_allowed, &current->cpus_allowed);
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-
 	clock_tick = sparc64_get_clock_tick(cpu) / 1000;
-	estar = read_hbreg(HBIRD_ESTAR_MODE_ADDR);
-
-	set_cpus_allowed_ptr(current, &cpus_allowed);
+	if (smp_call_function_single(cpu, __us2e_freq_get, &estar, 1))
+		return 0;
 
 	return clock_tick / estar_to_divisor(estar);
 }
 
-static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
+static void __us2e_freq_target(void *arg)
 {
-	unsigned int cpu = policy->cpu;
+	unsigned int cpu = smp_processor_id();
+	unsigned int *index = arg;
 	unsigned long new_bits, new_freq;
 	unsigned long clock_tick, divisor, old_divisor, estar;
-	cpumask_t cpus_allowed;
-
-	cpumask_copy(&cpus_allowed, &current->cpus_allowed);
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
 	new_freq = clock_tick = sparc64_get_clock_tick(cpu) / 1000;
-	new_bits = index_to_estar_mode(index);
-	divisor = index_to_divisor(index);
+	new_bits = index_to_estar_mode(*index);
+	divisor = index_to_divisor(*index);
 	new_freq /= divisor;
 
 	estar = read_hbreg(HBIRD_ESTAR_MODE_ADDR);
 
 	old_divisor = estar_to_divisor(estar);
 
-	if (old_divisor != divisor)
+	if (old_divisor != divisor) {
 		us2e_transition(estar, new_bits, clock_tick * 1000,
 				old_divisor, divisor);
+	}
+}
 
-	set_cpus_allowed_ptr(current, &cpus_allowed);
+static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
+{
+	unsigned int cpu = policy->cpu;
 
-	return 0;
+	return smp_call_function_single(cpu, __us2e_freq_target, &index, 1);
 }
 
 static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
