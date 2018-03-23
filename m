From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 14/97] cpufreq/sh: Replace racy task affinity logic
Date: Fri, 23 Mar 2018 10:54:01 +0100
Message-ID: <20180323094158.305904501@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Siewior <bigeasy@linutronix.de>, linux-pm@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Len Brown <lenb@kernel.org>, Sasha Levin <alexander.levin@microsoft.com>
List-Id: linux-pm@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>


[ Upstream commit 205dcc1ecbc566cbc20acf246e68de3b080b3ecf ]

The target() callback must run on the affected cpu. This is achieved by
temporarily setting the affinity of the calling thread to the requested CPU
and reset it to the original affinity afterwards.

That's racy vs. concurrent affinity settings for that thread resulting in
code executing on the wrong CPU.

Replace it by work_on_cpu(). All call pathes which invoke the callbacks are
already protected against CPU hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linux-pm@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.958216363@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/sh-cpufreq.c |   45 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -30,54 +30,63 @@
 
 static DEFINE_PER_CPU(struct clk, sh_cpuclk);
 
+struct cpufreq_target {
+	struct cpufreq_policy	*policy;
+	unsigned int		freq;
+};
+
 static unsigned int sh_cpufreq_get(unsigned int cpu)
 {
 	return (clk_get_rate(&per_cpu(sh_cpuclk, cpu)) + 500) / 1000;
 }
 
-/*
- * Here we notify other drivers of the proposed change and the final change.
- */
-static int sh_cpufreq_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static long __sh_cpufreq_target(void *arg)
 {
-	unsigned int cpu = policy->cpu;
+	struct cpufreq_target *target = arg;
+	struct cpufreq_policy *policy = target->policy;
+	int cpu = policy->cpu;
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, cpu);
-	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 	struct device *dev;
 	long freq;
 
-	cpus_allowed = current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-
-	BUG_ON(smp_processor_id() != cpu);
+	if (smp_processor_id() != cpu)
+		return -ENODEV;
 
 	dev = get_cpu_device(cpu);
 
 	/* Convert target_freq from kHz to Hz */
-	freq = clk_round_rate(cpuclk, target_freq * 1000);
+	freq = clk_round_rate(cpuclk, target->freq * 1000);
 
 	if (freq < (policy->min * 1000) || freq > (policy->max * 1000))
 		return -EINVAL;
 
-	dev_dbg(dev, "requested frequency %u Hz\n", target_freq * 1000);
+	dev_dbg(dev, "requested frequency %u Hz\n", target->freq * 1000);
 
 	freqs.old	= sh_cpufreq_get(cpu);
 	freqs.new	= (freq + 500) / 1000;
 	freqs.flags	= 0;
 
-	cpufreq_freq_transition_begin(policy, &freqs);
-	set_cpus_allowed_ptr(current, &cpus_allowed);
+	cpufreq_freq_transition_begin(target->policy, &freqs);
 	clk_set_rate(cpuclk, freq);
-	cpufreq_freq_transition_end(policy, &freqs, 0);
+	cpufreq_freq_transition_end(target->policy, &freqs, 0);
 
 	dev_dbg(dev, "set frequency %lu Hz\n", freq);
-
 	return 0;
 }
 
+/*
+ * Here we notify other drivers of the proposed change and the final change.
+ */
+static int sh_cpufreq_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	struct cpufreq_target data = { .policy = policy, .freq = target_freq };
+
+	return work_on_cpu(policy->cpu, __sh_cpufreq_target, &data);
+}
+
 static int sh_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	struct clk *cpuclk = &per_cpu(sh_cpuclk, policy->cpu);
