From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3] cpufreq: Implement light weight ->target_index() routine
Date: Fri, 25 Oct 2013 19:45:48 +0530
Message-ID: <fd74333584d216427e59663634e4906de71074d4.1382710427.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:48780 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab3JYOP5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 10:15:57 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so4355085pbc.17
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2013 07:15:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Currently prototype of cpufreq_drivers target routines is:

int target(struct cpufreq_policy *policy, unsigned int target_freq,
		unsigned int relation);

And most of the drivers call cpufreq_frequency_table_target() to get a valid
index of their frequency table which is closest to the target_freq. And they
don't use target_freq and relation after it.

So, it makes sense to just do this work in cpufreq core before calling
cpufreq_frequency_table_target() and simply pass index instead. But this can be
done only with drivers which expose their frequency table with cpufreq core. For
others we need to stick with the old prototype of target() until those drivers
are converted to expose frequency tables.

This patch implements the new light weight prototype for target_index() routine.
It looks like this:

int target_index(struct cpufreq_policy *policy, unsigned int index);

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and pass index to it. Because CPUFreq core now requires to call routines
present in freq_table.c CONFIG_CPU_FREQ_TABLE must be enabled all the time.

This also marks target() interface as deprecated. So, that new drivers avoid
using it. And Documentation is updated accordingly.

It also converts existing .target() to newly defined light weight
.target_index() routine for many driver.

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Russell King <linux@arm.linux.org.uk>
Acked-by: David S. Miller <davem@davemloft.net>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Merged all 34 patches into a single patch
- Applied all Acks received.

This is rebased over latest bleeding-edge branch + this patch:
cpufreq: create per policy rwsem instead of per CPU cpu_policy_rwsem

 Documentation/cpu-freq/cpu-drivers.txt | 27 ++++++++++------
 Documentation/cpu-freq/governors.txt   |  4 +--
 arch/arm/mach-sa1100/generic.c         | 20 ------------
 arch/arm/mach-sa1100/generic.h         |  2 --
 drivers/cpufreq/acpi-cpufreq.c         | 21 ++++---------
 drivers/cpufreq/arm_big_little.c       | 17 +++-------
 drivers/cpufreq/at32ap-cpufreq.c       | 23 +++-----------
 drivers/cpufreq/blackfin-cpufreq.c     | 17 +++-------
 drivers/cpufreq/cpufreq-cpu0.c         | 17 ++--------
 drivers/cpufreq/cpufreq.c              | 57 +++++++++++++++++++++++++++-------
 drivers/cpufreq/cris-artpec3-cpufreq.c | 18 ++---------
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 17 ++--------
 drivers/cpufreq/davinci-cpufreq.c      | 16 ++--------
 drivers/cpufreq/dbx500-cpufreq.c       | 16 ++--------
 drivers/cpufreq/e_powersaver.c         | 17 ++--------
 drivers/cpufreq/elanfreq.c             | 34 ++------------------
 drivers/cpufreq/exynos-cpufreq.c       | 21 ++-----------
 drivers/cpufreq/exynos5440-cpufreq.c   | 21 +++----------
 drivers/cpufreq/ia64-acpi-cpufreq.c    | 21 ++-----------
 drivers/cpufreq/imx6q-cpufreq.c        | 17 ++--------
 drivers/cpufreq/kirkwood-cpufreq.c     | 19 ++----------
 drivers/cpufreq/longhaul.c             | 13 ++------
 drivers/cpufreq/loongson2_cpufreq.c    | 21 +++----------
 drivers/cpufreq/maple-cpufreq.c        | 16 +++-------
 drivers/cpufreq/omap-cpufreq.c         | 31 ++----------------
 drivers/cpufreq/p4-clockmod.c          | 18 +++--------
 drivers/cpufreq/pasemi-cpufreq.c       | 12 ++-----
 drivers/cpufreq/pmac32-cpufreq.c       | 12 ++-----
 drivers/cpufreq/pmac64-cpufreq.c       | 17 +++-------
 drivers/cpufreq/powernow-k6.c          | 35 +++------------------
 drivers/cpufreq/powernow-k7.c          | 22 +++----------
 drivers/cpufreq/powernow-k8.c          | 24 +++++---------
 drivers/cpufreq/ppc-corenet-cpufreq.c  | 15 +++------
 drivers/cpufreq/ppc_cbe_cpufreq.c      | 12 ++-----
 drivers/cpufreq/pxa2xx-cpufreq.c       | 13 ++------
 drivers/cpufreq/pxa3xx-cpufreq.c       | 17 ++--------
 drivers/cpufreq/s3c2416-cpufreq.c      | 17 +++-------
 drivers/cpufreq/s3c64xx-cpufreq.c      | 18 +++--------
 drivers/cpufreq/s5pv210-cpufreq.c      | 54 +++++++++-----------------------
 drivers/cpufreq/sa1100-cpufreq.c       | 24 +++-----------
 drivers/cpufreq/sa1110-cpufreq.c       | 26 +++-------------
 drivers/cpufreq/sc520_freq.c           | 19 ++----------
 drivers/cpufreq/sparc-us2e-cpufreq.c   | 21 ++-----------
 drivers/cpufreq/sparc-us3-cpufreq.c    | 23 ++------------
 drivers/cpufreq/spear-cpufreq.c        | 12 +++----
 drivers/cpufreq/speedstep-centrino.c   | 27 +++++-----------
 drivers/cpufreq/speedstep-ich.c        | 24 ++++----------
 drivers/cpufreq/speedstep-smi.c        | 20 +++---------
 drivers/cpufreq/tegra-cpufreq.c        | 12 ++-----
 include/linux/cpufreq.h                |  4 ++-
 50 files changed, 242 insertions(+), 759 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
index 40282e6..8b1a445 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.txt
@@ -23,8 +23,8 @@ Contents:
 1.1  Initialization
 1.2  Per-CPU Initialization
 1.3  verify
-1.4  target or setpolicy?
-1.5  target
+1.4  target/target_index or setpolicy?
+1.5  target/target_index
 1.6  setpolicy
 2.   Frequency Table Helpers
 
@@ -56,7 +56,8 @@ cpufreq_driver.init -		A pointer to the per-CPU initialization
 cpufreq_driver.verify -		A pointer to a "verification" function.
 
 cpufreq_driver.setpolicy _or_ 
-cpufreq_driver.target -		See below on the differences.
+cpufreq_driver.target/
+target_index		-	See below on the differences.
 
 And optionally
 
@@ -66,7 +67,7 @@ cpufreq_driver.resume -		A pointer to a per-CPU resume function
 				which is called with interrupts disabled
 				and _before_ the pre-suspend frequency
 				and/or policy is restored by a call to
-				->target or ->setpolicy.
+				->target/target_index or ->setpolicy.
 
 cpufreq_driver.attr -		A pointer to a NULL-terminated list of
 				"struct freq_attr" which allow to
@@ -103,8 +104,8 @@ policy->governor		must contain the "default policy" for
 				this CPU. A few moments later,
 				cpufreq_driver.verify and either
 				cpufreq_driver.setpolicy or
-				cpufreq_driver.target is called with
-				these values.
+				cpufreq_driver.target/target_index is called
+				with these values.
 
 For setting some of these values (cpuinfo.min[max]_freq, policy->min[max]), the
 frequency table helpers might be helpful. See the section 2 for more information
@@ -133,20 +134,28 @@ range) is within policy->min and policy->max. If necessary, increase
 policy->max first, and only if this is no solution, decrease policy->min.
 
 
-1.4 target or setpolicy?
+1.4 target/target_index or setpolicy?
 ----------------------------
 
 Most cpufreq drivers or even most cpu frequency scaling algorithms 
 only allow the CPU to be set to one frequency. For these, you use the
-->target call.
+->target/target_index call.
 
 Some cpufreq-capable processors switch the frequency between certain
 limits on their own. These shall use the ->setpolicy call
 
 
-1.4. target
+1.4. target/target_index
 -------------
 
+The target_index call has two arguments: struct cpufreq_policy *policy,
+and unsigned int index (into the exposed frequency table).
+
+The CPUfreq driver must set the new frequency when called here. The
+actual frequency must be determined by freq_table[index].frequency.
+
+Deprecated:
+----------
 The target call has three arguments: struct cpufreq_policy *policy,
 unsigned int target_frequency, unsigned int relation.
 
diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
index 219970b..77ec215 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -40,7 +40,7 @@ Most cpufreq drivers (in fact, all except one, longrun) or even most
 cpu frequency scaling algorithms only offer the CPU to be set to one
 frequency. In order to offer dynamic frequency scaling, the cpufreq
 core must be able to tell these drivers of a "target frequency". So
-these specific drivers will be transformed to offer a "->target"
+these specific drivers will be transformed to offer a "->target/target_index"
 call instead of the existing "->setpolicy" call. For "longrun", all
 stays the same, though.
 
@@ -71,7 +71,7 @@ CPU can be set to switch independently	 |	   CPU can only be set
 		    /			       the limits of policy->{min,max}
 		   /			            \
 		  /				     \
-	Using the ->setpolicy call,		 Using the ->target call,
+	Using the ->setpolicy call,		 Using the ->target/target_index call,
 	    the limits and the			  the frequency closest
 	     "policy" is set.			  to target_freq is set.
 						  It is assured that it
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index cb4b2ca..d4ea142 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -62,26 +62,6 @@ struct cpufreq_frequency_table sa11x0_freq_table[NR_FREQS+1] = {
 	{ .frequency = CPUFREQ_TABLE_END, },
 };
 
-/* rounds up(!)  */
-unsigned int sa11x0_freq_to_ppcr(unsigned int khz)
-{
-	int i;
-
-	for (i = 0; i < NR_FREQS; i++)
-		if (sa11x0_freq_table[i].frequency >= khz)
-			break;
-
-	return i;
-}
-
-unsigned int sa11x0_ppcr_to_freq(unsigned int idx)
-{
-	unsigned int freq = 0;
-	if (idx < NR_FREQS)
-		freq = sa11x0_freq_table[idx].frequency;
-	return freq;
-}
-
 unsigned int sa11x0_getspeed(unsigned int cpu)
 {
 	if (cpu)
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index cbdfae7..0d92e11 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -21,9 +21,7 @@ extern void sa1110_mb_enable(void);
 extern void sa1110_mb_disable(void);
 
 extern struct cpufreq_frequency_table sa11x0_freq_table[];
-extern unsigned int sa11x0_freq_to_ppcr(unsigned int khz);
 extern unsigned int sa11x0_getspeed(unsigned int cpu);
-extern unsigned int sa11x0_ppcr_to_freq(unsigned int idx);
 
 struct flash_platform_data;
 struct resource;
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a1717d7..889cec0 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -424,17 +424,17 @@ static unsigned int check_freqs(const struct cpumask *mask, unsigned int freq,
 }
 
 static int acpi_cpufreq_target(struct cpufreq_policy *policy,
-			       unsigned int target_freq, unsigned int relation)
+			       unsigned int index)
 {
 	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
 	struct acpi_processor_performance *perf;
 	struct cpufreq_freqs freqs;
 	struct drv_cmd cmd;
-	unsigned int next_state = 0; /* Index into freq_table */
 	unsigned int next_perf_state = 0; /* Index into perf table */
 	int result = 0;
 
-	pr_debug("acpi_cpufreq_target %d (%d)\n", target_freq, policy->cpu);
+	pr_debug("acpi_cpufreq_target %d (%d)\n",
+			data->freq_table[index].frequency, policy->cpu);
 
 	if (unlikely(data == NULL ||
 	     data->acpi_data == NULL || data->freq_table == NULL)) {
@@ -442,16 +442,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	}
 
 	perf = data->acpi_data;
-	result = cpufreq_frequency_table_target(policy,
-						data->freq_table,
-						target_freq,
-						relation, &next_state);
-	if (unlikely(result)) {
-		result = -ENODEV;
-		goto out;
-	}
-
-	next_perf_state = data->freq_table[next_state].driver_data;
+	next_perf_state = data->freq_table[index].driver_data;
 	if (perf->state == next_perf_state) {
 		if (unlikely(data->resume)) {
 			pr_debug("Called after resume, resetting to P%d\n",
@@ -493,7 +484,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 		cmd.mask = cpumask_of(policy->cpu);
 
 	freqs.old = perf->states[perf->state].core_frequency * 1000;
-	freqs.new = data->freq_table[next_state].frequency;
+	freqs.new = data->freq_table[index].frequency;
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	drv_write(&cmd);
@@ -923,7 +914,7 @@ static struct freq_attr *acpi_cpufreq_attr[] = {
 
 static struct cpufreq_driver acpi_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= acpi_cpufreq_target,
+	.target_index	= acpi_cpufreq_target,
 	.bios_limit	= acpi_processor_get_bios_limit,
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 086f7c1..163e337 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -49,28 +49,21 @@ static unsigned int bL_cpufreq_get(unsigned int cpu)
 
 /* Set clock frequency */
 static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+		unsigned int index)
 {
 	struct cpufreq_freqs freqs;
-	u32 cpu = policy->cpu, freq_tab_idx, cur_cluster;
+	u32 cpu = policy->cpu, cur_cluster;
 	int ret = 0;
 
 	cur_cluster = cpu_to_cluster(policy->cpu);
 
 	freqs.old = bL_cpufreq_get(policy->cpu);
-
-	/* Determine valid target frequency using freq_table */
-	cpufreq_frequency_table_target(policy, freq_table[cur_cluster],
-			target_freq, relation, &freq_tab_idx);
-	freqs.new = freq_table[cur_cluster][freq_tab_idx].frequency;
+	freqs.new = freq_table[cur_cluster][index].frequency;
 
 	pr_debug("%s: cpu: %d, cluster: %d, oldfreq: %d, target freq: %d, new freq: %d\n",
-			__func__, cpu, cur_cluster, freqs.old, target_freq,
+			__func__, cpu, cur_cluster, freqs.old, freqs.new,
 			freqs.new);
 
-	if (freqs.old == freqs.new)
-		return 0;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	ret = clk_set_rate(clk[cur_cluster], freqs.new * 1000);
@@ -200,7 +193,7 @@ static struct cpufreq_driver bL_cpufreq_driver = {
 	.flags			= CPUFREQ_STICKY |
 					CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
 	.verify			= cpufreq_generic_frequency_table_verify,
-	.target			= bL_cpufreq_set_target,
+	.target_index		= bL_cpufreq_set_target,
 	.get			= bL_cpufreq_get,
 	.init			= bL_cpufreq_init,
 	.exit			= bL_cpufreq_exit,
diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index 7439ded..81d0752 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -35,25 +35,12 @@ static unsigned int at32_get_speed(unsigned int cpu)
 static unsigned int	ref_freq;
 static unsigned long	loops_per_jiffy_ref;
 
-static int at32_set_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
+static int at32_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct cpufreq_freqs freqs;
-	long freq;
-
-	/* Convert target_freq from kHz to Hz */
-	freq = clk_round_rate(cpuclk, target_freq * 1000);
-
-	/* Check if policy->min <= new_freq <= policy->max */
-	if(freq < (policy->min * 1000) || freq > (policy->max * 1000))
-		return -EINVAL;
-
-	pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
 
 	freqs.old = at32_get_speed(0);
-	freqs.new = (freq + 500) / 1000;
-	freqs.flags = 0;
+	freqs.new = freq_table[index].frequency;
 
 	if (!ref_freq) {
 		ref_freq = freqs.old;
@@ -64,13 +51,13 @@ static int at32_set_target(struct cpufreq_policy *policy,
 	if (freqs.old < freqs.new)
 		boot_cpu_data.loops_per_jiffy = cpufreq_scale(
 				loops_per_jiffy_ref, ref_freq, freqs.new);
-	clk_set_rate(cpuclk, freq);
+	clk_set_rate(cpuclk, freqs.new * 1000);
 	if (freqs.new < freqs.old)
 		boot_cpu_data.loops_per_jiffy = cpufreq_scale(
 				loops_per_jiffy_ref, ref_freq, freqs.new);
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
-	pr_debug("cpufreq: set frequency %lu Hz\n", freq);
+	pr_debug("cpufreq: set frequency %u Hz\n", freqs.new * 1000);
 
 	return 0;
 }
@@ -139,7 +126,7 @@ static struct cpufreq_driver at32_driver = {
 	.name		= "at32ap",
 	.init		= at32_cpufreq_driver_init,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= at32_set_target,
+	.target_index	= at32_set_target,
 	.get		= at32_get_speed,
 	.flags		= CPUFREQ_STICKY,
 };
diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 0bc9e8c..12528b2 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -127,14 +127,11 @@ unsigned long cpu_set_cclk(int cpu, unsigned long new)
 }
 #endif
 
-static int bfin_target(struct cpufreq_policy *policy,
-			unsigned int target_freq, unsigned int relation)
+static int bfin_target(struct cpufreq_policy *policy, unsigned int index)
 {
 #ifndef CONFIG_BF60x
 	unsigned int plldiv;
 #endif
-	unsigned int index;
-	unsigned long cclk_hz;
 	struct cpufreq_freqs freqs;
 	static unsigned long lpj_ref;
 	static unsigned int  lpj_ref_freq;
@@ -144,17 +141,11 @@ static int bfin_target(struct cpufreq_policy *policy,
 	cycles_t cycles;
 #endif
 
-	if (cpufreq_frequency_table_target(policy, bfin_freq_table, target_freq,
-				relation, &index))
-		return -EINVAL;
-
-	cclk_hz = bfin_freq_table[index].frequency;
-
 	freqs.old = bfin_getfreq_khz(0);
-	freqs.new = cclk_hz;
+	freqs.new = bfin_freq_table[index].frequency;
 
 	pr_debug("cpufreq: changing cclk to %lu; target = %u, oldfreq = %u\n",
-			cclk_hz, target_freq, freqs.old);
+			freqs.new, freqs.new, freqs.old);
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 #ifndef CONFIG_BF60x
@@ -209,7 +200,7 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver bfin_driver = {
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target = bfin_target,
+	.target_index = bfin_target,
 	.get = bfin_getfreq_khz,
 	.init = __bfin_cpu_init,
 	.exit = cpufreq_generic_exit,
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 33ab650..4dbe7ef 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -35,24 +35,14 @@ static unsigned int cpu0_get_speed(unsigned int cpu)
 	return clk_get_rate(cpu_clk) / 1000;
 }
 
-static int cpu0_set_target(struct cpufreq_policy *policy,
-			   unsigned int target_freq, unsigned int relation)
+static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct cpufreq_freqs freqs;
 	struct dev_pm_opp *opp;
 	unsigned long volt = 0, volt_old = 0, tol = 0;
 	long freq_Hz, freq_exact;
-	unsigned int index;
 	int ret;
 
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-					     relation, &index);
-	if (ret) {
-		pr_err("failed to match target freqency %d: %d\n",
-		       target_freq, ret);
-		return ret;
-	}
-
 	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
 	if (freq_Hz < 0)
 		freq_Hz = freq_table[index].frequency * 1000;
@@ -60,9 +50,6 @@ static int cpu0_set_target(struct cpufreq_policy *policy,
 	freqs.new = freq_Hz / 1000;
 	freqs.old = clk_get_rate(cpu_clk) / 1000;
 
-	if (freqs.old == freqs.new)
-		return 0;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (!IS_ERR(cpu_reg)) {
@@ -128,7 +115,7 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver cpu0_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target = cpu0_set_target,
+	.target_index = cpu0_set_target,
 	.get = cpu0_get_speed,
 	.init = cpu0_cpufreq_init,
 	.exit = cpufreq_generic_exit,
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3f03dcb..6c9cbb9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -47,6 +47,11 @@ static LIST_HEAD(cpufreq_policy_list);
 static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
 #endif
 
+static inline bool has_target(void)
+{
+	return cpufreq_driver->target_index || cpufreq_driver->target;
+}
+
 /*
  * rwsem to guarantee that cpufreq driver module doesn't unload during critical
  * sections
@@ -351,7 +356,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 			*policy = CPUFREQ_POLICY_POWERSAVE;
 			err = 0;
 		}
-	} else if (cpufreq_driver->target) {
+	} else if (has_target()) {
 		struct cpufreq_governor *t;
 
 		mutex_lock(&cpufreq_governor_mutex);
@@ -509,7 +514,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 	ssize_t i = 0;
 	struct cpufreq_governor *t;
 
-	if (!cpufreq_driver->target) {
+	if (!has_target()) {
 		i += sprintf(buf, "performance powersave");
 		goto out;
 	}
@@ -794,7 +799,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 		if (ret)
 			goto err_out_kobj_put;
 	}
-	if (cpufreq_driver->target) {
+	if (has_target()) {
 		ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
 		if (ret)
 			goto err_out_kobj_put;
@@ -843,10 +848,10 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 				  unsigned int cpu, struct device *dev,
 				  bool frozen)
 {
-	int ret = 0, has_target = !!cpufreq_driver->target;
+	int ret = 0;
 	unsigned long flags;
 
-	if (has_target) {
+	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
@@ -864,7 +869,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 
 	up_write(&policy->rwsem);
 
-	if (has_target) {
+	if (has_target()) {
 		if ((ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
 			(ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {
 			pr_err("%s: Failed to start governor\n", __func__);
@@ -1169,7 +1174,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (cpufreq_driver->target) {
+	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
@@ -1234,7 +1239,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 	/* If cpu is last user of policy, free policy */
 	if (cpus == 1) {
-		if (cpufreq_driver->target) {
+		if (has_target()) {
 			ret = __cpufreq_governor(policy,
 					CPUFREQ_GOV_POLICY_EXIT);
 			if (ret) {
@@ -1277,7 +1282,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		if (!frozen)
 			cpufreq_policy_free(policy);
 	} else {
-		if (cpufreq_driver->target) {
+		if (has_target()) {
 			if ((ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
 					(ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {
 				pr_err("%s: Failed to start governor\n",
@@ -1651,12 +1656,41 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 			policy->cpu, target_freq, relation, old_target_freq);
 
+	/*
+	 * This might look like a redundant call as we are checking it again
+	 * after finding index. But it is left intentionally for cases where
+	 * exactly same freq is called again and so we can save on few function
+	 * calls.
+	 */
 	if (target_freq == policy->cur)
 		return 0;
 
 	if (cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
+	else if (cpufreq_driver->target_index) {
+		struct cpufreq_frequency_table *freq_table;
+		int index;
 
+		freq_table = cpufreq_frequency_get_table(policy->cpu);
+		if (unlikely(!freq_table)) {
+			pr_err("%s: Unable to find freq_table\n", __func__);
+			goto out;
+		}
+
+		retval = cpufreq_frequency_table_target(policy, freq_table,
+				target_freq, relation, &index);
+		if (unlikely(retval)) {
+			pr_err("%s: Unable to find matching freq\n", __func__);
+			goto out;
+		}
+
+		if (freq_table[index].frequency == policy->cur)
+			retval = 0;
+		else
+			retval = cpufreq_driver->target_index(policy, index);
+	}
+
+out:
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
@@ -1982,7 +2016,7 @@ int cpufreq_update_policy(unsigned int cpu)
 			pr_debug("Driver did not initialize current freq");
 			policy->cur = new_policy.cur;
 		} else {
-			if (policy->cur != new_policy.cur && cpufreq_driver->target)
+			if (policy->cur != new_policy.cur && has_target())
 				cpufreq_out_of_sync(cpu, policy->cur,
 								new_policy.cur);
 		}
@@ -2060,7 +2094,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 		return -ENODEV;
 
 	if (!driver_data || !driver_data->verify || !driver_data->init ||
-	    ((!driver_data->setpolicy) && (!driver_data->target)))
+	    !(driver_data->setpolicy || driver_data->target_index ||
+		    driver_data->target))
 		return -EINVAL;
 
 	pr_debug("trying to register driver %s\n", driver_data->name);
diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 05fdc7e..841857c 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -27,8 +27,7 @@ static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
 	return clk_ctrl.pll ? 200000 : 6000;
 }
 
-static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
-		unsigned int state)
+static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
 {
 	struct cpufreq_freqs freqs;
 	reg_clkgen_rw_clk_ctrl clk_ctrl;
@@ -52,19 +51,6 @@ static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
 	local_irq_enable();
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-};
-
-static int cris_freq_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
-{
-	unsigned int newstate = 0;
-
-	if (cpufreq_frequency_table_target(policy, cris_freq_table,
-			target_freq, relation, &newstate))
-		return -EINVAL;
-
-	cris_freq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
@@ -77,7 +63,7 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver cris_freq_driver = {
 	.get	= cris_freq_get_cpu_frequency,
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.target	= cris_freq_target,
+	.target_index = cris_freq_target,
 	.init	= cris_freq_cpu_init,
 	.exit	= cpufreq_generic_exit,
 	.name	= "cris_freq",
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index fac2b26..c58811a 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -27,8 +27,7 @@ static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
 	return clk_ctrl.pll ? 200000 : 6000;
 }
 
-static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
-		unsigned int state)
+static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
 {
 	struct cpufreq_freqs freqs;
 	reg_config_rw_clk_ctrl clk_ctrl;
@@ -52,18 +51,6 @@ static void cris_freq_set_cpu_state(struct cpufreq_policy *policy,
 	local_irq_enable();
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-};
-
-static int cris_freq_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq, unsigned int relation)
-{
-	unsigned int newstate = 0;
-
-	if (cpufreq_frequency_table_target
-	    (policy, cris_freq_table, target_freq, relation, &newstate))
-		return -EINVAL;
-
-	cris_freq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
@@ -76,7 +63,7 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver cris_freq_driver = {
 	.get = cris_freq_get_cpu_frequency,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target = cris_freq_target,
+	.target_index = cris_freq_target,
 	.init = cris_freq_cpu_init,
 	.exit = cpufreq_generic_exit,
 	.name = "cris_freq",
diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 972583b..1f5d8a5 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -66,28 +66,18 @@ static unsigned int davinci_getspeed(unsigned int cpu)
 	return clk_get_rate(cpufreq.armclk) / 1000;
 }
 
-static int davinci_target(struct cpufreq_policy *policy,
-				unsigned int target_freq, unsigned int relation)
+static int davinci_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	int ret = 0;
-	unsigned int idx;
 	struct cpufreq_freqs freqs;
 	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
 	struct clk *armclk = cpufreq.armclk;
 
 	freqs.old = davinci_getspeed(0);
-	freqs.new = clk_round_rate(armclk, target_freq * 1000) / 1000;
-
-	if (freqs.old == freqs.new)
-		return ret;
+	freqs.new = pdata->freq_table[idx].frequency;
 
 	dev_dbg(cpufreq.dev, "transition: %u --> %u\n", freqs.old, freqs.new);
 
-	ret = cpufreq_frequency_table_target(policy, pdata->freq_table,
-						freqs.new, relation, &idx);
-	if (ret)
-		return -EINVAL;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* if moving to higher frequency, up the voltage beforehand */
@@ -148,7 +138,7 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver davinci_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= davinci_verify_speed,
-	.target		= davinci_target,
+	.target_index	= davinci_target,
 	.get		= davinci_getspeed,
 	.init		= davinci_cpu_init,
 	.exit		= cpufreq_generic_exit,
diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index a60f769..238b169 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -20,23 +20,13 @@ static struct cpufreq_frequency_table *freq_table;
 static struct clk *armss_clk;
 
 static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
-				unsigned int target_freq,
-				unsigned int relation)
+				unsigned int index)
 {
 	struct cpufreq_freqs freqs;
-	unsigned int idx;
 	int ret;
 
-	/* Lookup the next frequency */
-	if (cpufreq_frequency_table_target(policy, freq_table, target_freq,
-					relation, &idx))
-		return -EINVAL;
-
 	freqs.old = policy->cur;
-	freqs.new = freq_table[idx].frequency;
-
-	if (freqs.old == freqs.new)
-		return 0;
+	freqs.new = freq_table[index].frequency;
 
 	/* pre-change notification */
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
@@ -80,7 +70,7 @@ static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver dbx500_cpufreq_driver = {
 	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target = dbx500_cpufreq_target,
+	.target_index = dbx500_cpufreq_target,
 	.get    = dbx500_cpufreq_getspeed,
 	.init   = dbx500_cpufreq_init,
 	.name   = "DBX500",
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 2c11ce3..b39c4ef 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -168,12 +168,9 @@ postchange:
 	return err;
 }
 
-static int eps_target(struct cpufreq_policy *policy,
-			       unsigned int target_freq,
-			       unsigned int relation)
+static int eps_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct eps_cpu_data *centaur;
-	unsigned int newstate = 0;
 	unsigned int cpu = policy->cpu;
 	unsigned int dest_state;
 	int ret;
@@ -182,16 +179,8 @@ static int eps_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 	centaur = eps_cpu[cpu];
 
-	if (unlikely(cpufreq_frequency_table_target(policy,
-			&eps_cpu[cpu]->freq_table[0],
-			target_freq,
-			relation,
-			&newstate))) {
-		return -EINVAL;
-	}
-
 	/* Make frequency transition */
-	dest_state = centaur->freq_table[newstate].driver_data & 0xffff;
+	dest_state = centaur->freq_table[index].driver_data & 0xffff;
 	ret = eps_set_state(centaur, policy, dest_state);
 	if (ret)
 		printk(KERN_ERR "eps: Timeout!\n");
@@ -418,7 +407,7 @@ static int eps_cpu_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver eps_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= eps_target,
+	.target_index	= eps_target,
 	.init		= eps_cpu_init,
 	.exit		= eps_cpu_exit,
 	.get		= eps_get,
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index d91a645..4ab4153 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -105,20 +105,8 @@ static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
 }
 
 
-/**
- *	elanfreq_set_cpu_frequency: Change the CPU core frequency
- *	@cpu: cpu number
- *	@freq: frequency in kHz
- *
- *	This function takes a frequency value and changes the CPU frequency
- *	according to this. Note that the frequency has to be checked by
- *	elanfreq_validatespeed() for correctness!
- *
- *	There is no return value.
- */
-
-static void elanfreq_set_cpu_state(struct cpufreq_policy *policy,
-		unsigned int state)
+static int elanfreq_target(struct cpufreq_policy *policy,
+			    unsigned int state)
 {
 	struct cpufreq_freqs    freqs;
 
@@ -162,25 +150,9 @@ static void elanfreq_set_cpu_state(struct cpufreq_policy *policy,
 	local_irq_enable();
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-};
-
-
-static int elanfreq_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
-{
-	unsigned int newstate = 0;
-
-	if (cpufreq_frequency_table_target(policy, &elanfreq_table[0],
-				target_freq, relation, &newstate))
-		return -EINVAL;
-
-	elanfreq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
-
-
 /*
  *	Module init and exit code
  */
@@ -237,7 +209,7 @@ __setup("elanfreq=", elanfreq_setup);
 static struct cpufreq_driver elanfreq_driver = {
 	.get		= elanfreq_get_cpu_frequency,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= elanfreq_target,
+	.target_index	= elanfreq_target,
 	.init		= elanfreq_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.name		= "elanfreq",
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 3e4af67..9982fcb 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -65,9 +65,6 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
-	if (freqs.new == freqs.old)
-		goto out;
-
 	/*
 	 * The policy max have been changed so that we cannot get proper
 	 * old_index with cpufreq_frequency_table_target(). Thus, ignore
@@ -151,13 +148,9 @@ out:
 	return ret;
 }
 
-static int exynos_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
+static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct cpufreq_frequency_table *freq_table = exynos_info->freq_table;
-	unsigned int index;
-	unsigned int new_freq;
 	int ret = 0;
 
 	mutex_lock(&cpufreq_lock);
@@ -165,15 +158,7 @@ static int exynos_target(struct cpufreq_policy *policy,
 	if (frequency_locked)
 		goto out;
 
-	if (cpufreq_frequency_table_target(policy, freq_table,
-					   target_freq, relation, &index)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	new_freq = freq_table[index].frequency;
-
-	ret = exynos_cpufreq_scale(new_freq);
+	ret = exynos_cpufreq_scale(freq_table[index].frequency);
 
 out:
 	mutex_unlock(&cpufreq_lock);
@@ -247,7 +232,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver exynos_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= exynos_target,
+	.target_index	= exynos_target,
 	.get		= exynos_getspeed,
 	.init		= exynos_cpufreq_cpu_init,
 	.exit		= cpufreq_generic_exit,
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 8ae5e29..1bf9b06 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -214,27 +214,17 @@ static unsigned int exynos_getspeed(unsigned int cpu)
 	return dvfs_info->cur_frequency;
 }
 
-static int exynos_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
+static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int index, tmp;
-	int ret = 0, i;
+	unsigned int tmp;
+	int i;
 	struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
 
 	mutex_lock(&cpufreq_lock);
 
-	ret = cpufreq_frequency_table_target(policy, freq_table,
-					   target_freq, relation, &index);
-	if (ret)
-		goto out;
-
 	freqs.old = dvfs_info->cur_frequency;
 	freqs.new = freq_table[index].frequency;
 
-	if (freqs.old == freqs.new)
-		goto out;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Set the target frequency in all C0_3_PSTATE register */
@@ -245,9 +235,8 @@ static int exynos_target(struct cpufreq_policy *policy,
 
 		__raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
 	}
-out:
 	mutex_unlock(&cpufreq_lock);
-	return ret;
+	return 0;
 }
 
 static void exynos_cpufreq_work(struct work_struct *work)
@@ -325,7 +314,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver exynos_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= exynos_target,
+	.target_index	= exynos_target,
 	.get		= exynos_getspeed,
 	.init		= exynos_cpufreq_cpu_init,
 	.exit		= cpufreq_generic_exit,
diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 90c6598..4695fa2 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -227,26 +227,11 @@ acpi_cpufreq_get (
 static int
 acpi_cpufreq_target (
 	struct cpufreq_policy   *policy,
-	unsigned int target_freq,
-	unsigned int relation)
+	unsigned int index)
 {
-	struct cpufreq_acpi_io *data = acpi_io_data[policy->cpu];
-	unsigned int next_state = 0;
-	unsigned int result = 0;
-
-	pr_debug("acpi_cpufreq_setpolicy\n");
-
-	result = cpufreq_frequency_table_target(policy,
-			data->freq_table, target_freq, relation, &next_state);
-	if (result)
-		return (result);
-
-	result = processor_set_freq(data, policy, next_state);
-
-	return (result);
+	return processor_set_freq(acpi_io_data[policy->cpu], policy, index);
 }
 
-
 static int
 acpi_cpufreq_cpu_init (
 	struct cpufreq_policy   *policy)
@@ -379,7 +364,7 @@ acpi_cpufreq_cpu_exit (
 
 static struct cpufreq_driver acpi_cpufreq_driver = {
 	.verify 	= cpufreq_generic_frequency_table_verify,
-	.target 	= acpi_cpufreq_target,
+	.target_index	= acpi_cpufreq_target,
 	.get 		= acpi_cpufreq_get,
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index be23892..07af3b0 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -40,30 +40,17 @@ static unsigned int imx6q_get_speed(unsigned int cpu)
 	return clk_get_rate(arm_clk) / 1000;
 }
 
-static int imx6q_set_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq, unsigned int relation)
+static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct cpufreq_freqs freqs;
 	struct dev_pm_opp *opp;
 	unsigned long freq_hz, volt, volt_old;
-	unsigned int index;
 	int ret;
 
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-					     relation, &index);
-	if (ret) {
-		dev_err(cpu_dev, "failed to match target frequency %d: %d\n",
-			target_freq, ret);
-		return ret;
-	}
-
 	freqs.new = freq_table[index].frequency;
 	freq_hz = freqs.new * 1000;
 	freqs.old = clk_get_rate(arm_clk) / 1000;
 
-	if (freqs.old == freqs.new)
-		return 0;
-
 	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
 	if (IS_ERR(opp)) {
@@ -159,7 +146,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target = imx6q_set_target,
+	.target_index = imx6q_set_target,
 	.get = imx6q_get_speed,
 	.init = imx6q_cpufreq_init,
 	.exit = cpufreq_generic_exit,
diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index fff8653..0ae4dd7 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -55,8 +55,8 @@ static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
 	return kirkwood_freq_table[0].frequency;
 }
 
-static void kirkwood_cpufreq_set_cpu_state(struct cpufreq_policy *policy,
-		unsigned int index)
+static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
+			    unsigned int index)
 {
 	struct cpufreq_freqs freqs;
 	unsigned int state = kirkwood_freq_table[index].driver_data;
@@ -100,19 +100,6 @@ static void kirkwood_cpufreq_set_cpu_state(struct cpufreq_policy *policy,
 		local_irq_enable();
 	}
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-};
-
-static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
-{
-	unsigned int index = 0;
-
-	if (cpufreq_frequency_table_target(policy, kirkwood_freq_table,
-				target_freq, relation, &index))
-		return -EINVAL;
-
-	kirkwood_cpufreq_set_cpu_state(policy, index);
 
 	return 0;
 }
@@ -126,7 +113,7 @@ static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver kirkwood_cpufreq_driver = {
 	.get	= kirkwood_cpufreq_get_cpu_frequency,
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.target	= kirkwood_cpufreq_target,
+	.target_index = kirkwood_cpufreq_target,
 	.init	= kirkwood_cpufreq_cpu_init,
 	.exit	= cpufreq_generic_exit,
 	.name	= "kirkwood-cpufreq",
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 14df497..45bafdd 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -626,21 +626,12 @@ static void longhaul_setup_voltagescaling(void)
 
 
 static int longhaul_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq, unsigned int relation)
+			    unsigned int table_index)
 {
-	unsigned int table_index = 0;
 	unsigned int i;
 	unsigned int dir = 0;
 	u8 vid, current_vid;
 
-	if (cpufreq_frequency_table_target(policy, longhaul_table, target_freq,
-				relation, &table_index))
-		return -EINVAL;
-
-	/* Don't set same frequency again */
-	if (longhaul_index == table_index)
-		return 0;
-
 	if (!can_scale_voltage)
 		longhaul_setstate(policy, table_index);
 	else {
@@ -919,7 +910,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver longhaul_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.target	= longhaul_target,
+	.target_index = longhaul_target,
 	.get	= longhaul_get,
 	.init	= longhaul_cpu_init,
 	.exit	= cpufreq_generic_exit,
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 2c8ec8e..41a8e2c 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -53,11 +53,9 @@ static unsigned int loongson2_cpufreq_get(unsigned int cpu)
  * Here we notify other drivers of the proposed change and the final change.
  */
 static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
-				     unsigned int target_freq,
-				     unsigned int relation)
+				     unsigned int index)
 {
 	unsigned int cpu = policy->cpu;
-	unsigned int newstate = 0;
 	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 	unsigned int freq;
@@ -65,26 +63,17 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 	cpus_allowed = current->cpus_allowed;
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
-	if (cpufreq_frequency_table_target
-	    (policy, &loongson2_clockmod_table[0], target_freq, relation,
-	     &newstate))
-		return -EINVAL;
-
 	freq =
 	    ((cpu_clock_freq / 1000) *
-	     loongson2_clockmod_table[newstate].driver_data) / 8;
-	if (freq < policy->min || freq > policy->max)
-		return -EINVAL;
+	     loongson2_clockmod_table[index].driver_data) / 8;
 
-	pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
+	pr_debug("cpufreq: requested frequency %u Hz\n",
+			loongson2_clockmod_table[index].frequency * 1000);
 
 	freqs.old = loongson2_cpufreq_get(cpu);
 	freqs.new = freq;
 	freqs.flags = 0;
 
-	if (freqs.new == freqs.old)
-		return 0;
-
 	/* notifiers */
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
@@ -145,7 +134,7 @@ static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.name = "loongson2",
 	.init = loongson2_cpufreq_cpu_init,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target = loongson2_cpufreq_target,
+	.target_index = loongson2_cpufreq_target,
 	.get = loongson2_cpufreq_get,
 	.exit = loongson2_cpufreq_exit,
 	.attr = cpufreq_generic_attr,
diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index eb1e176..4e2da08 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -131,26 +131,18 @@ static int maple_scom_query_freq(void)
  */
 
 static int maple_cpufreq_target(struct cpufreq_policy *policy,
-	unsigned int target_freq, unsigned int relation)
+	unsigned int index)
 {
-	unsigned int newstate = 0;
 	struct cpufreq_freqs freqs;
 	int rc;
 
-	if (cpufreq_frequency_table_target(policy, maple_cpu_freqs,
-			target_freq, relation, &newstate))
-		return -EINVAL;
-
-	if (maple_pmode_cur == newstate)
-		return 0;
-
 	mutex_lock(&maple_switch_mutex);
 
 	freqs.old = maple_cpu_freqs[maple_pmode_cur].frequency;
-	freqs.new = maple_cpu_freqs[newstate].frequency;
+	freqs.new = maple_cpu_freqs[index].frequency;
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-	rc = maple_scom_switch_freq(newstate);
+	rc = maple_scom_switch_freq(index);
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	mutex_unlock(&maple_switch_mutex);
@@ -173,7 +165,7 @@ static struct cpufreq_driver maple_cpufreq_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= maple_cpufreq_cpu_init,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= maple_cpufreq_target,
+	.target_index	= maple_cpufreq_target,
 	.get		= maple_cpufreq_get_speed,
 	.attr		= cpufreq_generic_attr,
 };
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index ac552d0..b551271 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -51,40 +51,15 @@ static unsigned int omap_getspeed(unsigned int cpu)
 	return rate;
 }
 
-static int omap_target(struct cpufreq_policy *policy,
-		       unsigned int target_freq,
-		       unsigned int relation)
+static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int i;
 	int r, ret = 0;
 	struct cpufreq_freqs freqs;
 	struct dev_pm_opp *opp;
 	unsigned long freq, volt = 0, volt_old = 0, tol = 0;
 
-	if (!freq_table) {
-		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
-				policy->cpu);
-		return -EINVAL;
-	}
-
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-			relation, &i);
-	if (ret) {
-		dev_dbg(mpu_dev, "%s: cpu%d: no freq match for %d(ret=%d)\n",
-			__func__, policy->cpu, target_freq, ret);
-		return ret;
-	}
-	freqs.new = freq_table[i].frequency;
-	if (!freqs.new) {
-		dev_err(mpu_dev, "%s: cpu%d: no match for freq %d\n", __func__,
-			policy->cpu, target_freq);
-		return -EINVAL;
-	}
-
 	freqs.old = omap_getspeed(policy->cpu);
-
-	if (freqs.old == freqs.new && policy->cur == freqs.new)
-		return ret;
+	freqs.new = freq_table[index].frequency;
 
 	freq = freqs.new * 1000;
 	ret = clk_round_rate(mpu_clk, freq);
@@ -200,7 +175,7 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
 static struct cpufreq_driver omap_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= omap_target,
+	.target_index	= omap_target,
 	.get		= omap_getspeed,
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 6164c1c..3c23053 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -105,23 +105,13 @@ static struct cpufreq_frequency_table p4clockmod_table[] = {
 };
 
 
-static int cpufreq_p4_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static int cpufreq_p4_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int    newstate = DC_RESV;
 	struct cpufreq_freqs freqs;
 	int i;
 
-	if (cpufreq_frequency_table_target(policy, &p4clockmod_table[0],
-				target_freq, relation, &newstate))
-		return -EINVAL;
-
 	freqs.old = cpufreq_p4_get(policy->cpu);
-	freqs.new = stock_freq * p4clockmod_table[newstate].driver_data / 8;
-
-	if (freqs.new == freqs.old)
-		return 0;
+	freqs.new = stock_freq * p4clockmod_table[index].driver_data / 8;
 
 	/* notifiers */
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
@@ -131,7 +121,7 @@ static int cpufreq_p4_target(struct cpufreq_policy *policy,
 	 * Developer's Manual, Volume 3
 	 */
 	for_each_cpu(i, policy->cpus)
-		cpufreq_p4_setdc(i, p4clockmod_table[newstate].driver_data);
+		cpufreq_p4_setdc(i, p4clockmod_table[index].driver_data);
 
 	/* notifiers */
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
@@ -255,7 +245,7 @@ static unsigned int cpufreq_p4_get(unsigned int cpu)
 
 static struct cpufreq_driver p4clockmod_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= cpufreq_p4_target,
+	.target_index	= cpufreq_p4_target,
 	.init		= cpufreq_p4_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.get		= cpufreq_p4_get,
diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 1cca332..17424dd 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -240,19 +240,11 @@ static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 }
 
 static int pas_cpufreq_target(struct cpufreq_policy *policy,
-			      unsigned int target_freq,
-			      unsigned int relation)
+			      unsigned int pas_astate_new)
 {
 	struct cpufreq_freqs freqs;
-	int pas_astate_new;
 	int i;
 
-	cpufreq_frequency_table_target(policy,
-				       pas_freqs,
-				       target_freq,
-				       relation,
-				       &pas_astate_new);
-
 	freqs.old = policy->cur;
 	freqs.new = pas_freqs[pas_astate_new].frequency;
 
@@ -282,7 +274,7 @@ static struct cpufreq_driver pas_cpufreq_driver = {
 	.init		= pas_cpufreq_cpu_init,
 	.exit		= pas_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= pas_cpufreq_target,
+	.target_index	= pas_cpufreq_target,
 	.attr		= cpufreq_generic_attr,
 };
 
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 6eac1e2..05f705e 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -374,17 +374,11 @@ static unsigned int pmac_cpufreq_get_speed(unsigned int cpu)
 }
 
 static int pmac_cpufreq_target(	struct cpufreq_policy *policy,
-					unsigned int target_freq,
-					unsigned int relation)
+					unsigned int index)
 {
-	unsigned int    newstate = 0;
 	int		rc;
 
-	if (cpufreq_frequency_table_target(policy, pmac_cpu_freqs,
-			target_freq, relation, &newstate))
-		return -EINVAL;
-
-	rc = do_set_cpu_speed(policy, newstate, 1);
+	rc = do_set_cpu_speed(policy, index, 1);
 
 	ppc_proc_freq = cur_freq * 1000ul;
 	return rc;
@@ -453,7 +447,7 @@ static int pmac_cpufreq_resume(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver pmac_cpufreq_driver = {
 	.verify 	= cpufreq_generic_frequency_table_verify,
-	.target 	= pmac_cpufreq_target,
+	.target_index	= pmac_cpufreq_target,
 	.get		= pmac_cpufreq_get_speed,
 	.init		= pmac_cpufreq_cpu_init,
 	.suspend	= pmac_cpufreq_suspend,
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 5261b92..234b598 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -312,27 +312,18 @@ static int g5_pfunc_query_freq(void)
  * Common interface to the cpufreq core
  */
 
-static int g5_cpufreq_target(struct cpufreq_policy *policy,
-	unsigned int target_freq, unsigned int relation)
+static int g5_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int newstate = 0;
 	struct cpufreq_freqs freqs;
 	int rc;
 
-	if (cpufreq_frequency_table_target(policy, g5_cpu_freqs,
-			target_freq, relation, &newstate))
-		return -EINVAL;
-
-	if (g5_pmode_cur == newstate)
-		return 0;
-
 	mutex_lock(&g5_switch_mutex);
 
 	freqs.old = g5_cpu_freqs[g5_pmode_cur].frequency;
-	freqs.new = g5_cpu_freqs[newstate].frequency;
+	freqs.new = g5_cpu_freqs[index].frequency;
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-	rc = g5_switch_freq(newstate);
+	rc = g5_switch_freq(index);
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	mutex_unlock(&g5_switch_mutex);
@@ -355,7 +346,7 @@ static struct cpufreq_driver g5_cpufreq_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= g5_cpufreq_cpu_init,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= g5_cpufreq_target,
+	.target_index	= g5_cpufreq_target,
 	.get		= g5_cpufreq_get_speed,
 	.attr 		= cpufreq_generic_attr,
 };
diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index eda1702..643e795 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -63,12 +63,12 @@ static int powernow_k6_get_cpu_multiplier(void)
 
 
 /**
- * powernow_k6_set_state - set the PowerNow! multiplier
+ * powernow_k6_target - set the PowerNow! multiplier
  * @best_i: clock_ratio[best_i] is the target multiplier
  *
  *   Tries to change the PowerNow! multiplier
  */
-static void powernow_k6_set_state(struct cpufreq_policy *policy,
+static int powernow_k6_target(struct cpufreq_policy *policy,
 		unsigned int best_i)
 {
 	unsigned long outvalue = 0, invalue = 0;
@@ -77,7 +77,7 @@ static void powernow_k6_set_state(struct cpufreq_policy *policy,
 
 	if (clock_ratio[best_i].driver_data > max_multiplier) {
 		printk(KERN_ERR PFX "invalid target frequency\n");
-		return;
+		return -EINVAL;
 	}
 
 	freqs.old = busfreq * powernow_k6_get_cpu_multiplier();
@@ -100,31 +100,6 @@ static void powernow_k6_set_state(struct cpufreq_policy *policy,
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
-	return;
-}
-
-
-/**
- * powernow_k6_setpolicy - sets a new CPUFreq policy
- * @policy: new policy
- * @target_freq: the target frequency
- * @relation: how that frequency relates to achieved frequency
- *  (CPUFREQ_RELATION_L or CPUFREQ_RELATION_H)
- *
- * sets a new CPUFreq policy
- */
-static int powernow_k6_target(struct cpufreq_policy *policy,
-			       unsigned int target_freq,
-			       unsigned int relation)
-{
-	unsigned int newstate = 0;
-
-	if (cpufreq_frequency_table_target(policy, &clock_ratio[0],
-				target_freq, relation, &newstate))
-		return -EINVAL;
-
-	powernow_k6_set_state(policy, newstate);
-
 	return 0;
 }
 
@@ -161,7 +136,7 @@ static int powernow_k6_cpu_exit(struct cpufreq_policy *policy)
 	unsigned int i;
 	for (i = 0; i < 8; i++) {
 		if (i == max_multiplier)
-			powernow_k6_set_state(policy, i);
+			powernow_k6_target(policy, i);
 	}
 	cpufreq_frequency_table_put_attr(policy->cpu);
 	return 0;
@@ -176,7 +151,7 @@ static unsigned int powernow_k6_get(unsigned int cpu)
 
 static struct cpufreq_driver powernow_k6_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= powernow_k6_target,
+	.target_index	= powernow_k6_target,
 	.init		= powernow_k6_cpu_init,
 	.exit		= powernow_k6_cpu_exit,
 	.get		= powernow_k6_get,
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 44d345b..946708a 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -248,7 +248,7 @@ static void change_VID(int vid)
 }
 
 
-static void change_speed(struct cpufreq_policy *policy, unsigned int index)
+static int powernow_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	u8 fid, vid;
 	struct cpufreq_freqs freqs;
@@ -291,6 +291,8 @@ static void change_speed(struct cpufreq_policy *policy, unsigned int index)
 		local_irq_enable();
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
 }
 
 
@@ -533,22 +535,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
 }
 
 
-static int powernow_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
-{
-	unsigned int newstate;
-
-	if (cpufreq_frequency_table_target(policy, powernow_table, target_freq,
-				relation, &newstate))
-		return -EINVAL;
-
-	change_speed(policy, newstate);
-
-	return 0;
-}
-
-
 /*
  * We use the fact that the bus frequency is somehow
  * a multiple of 100000/3 khz, then we compute sgtc according
@@ -694,7 +680,7 @@ static int powernow_cpu_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver powernow_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= powernow_target,
+	.target_index	= powernow_target,
 	.get		= powernow_get,
 #ifdef CONFIG_X86_POWERNOW_K7_ACPI
 	.bios_limit	= acpi_processor_get_bios_limit,
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 298beb7..62a1ce4 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -977,20 +977,17 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
 
 struct powernowk8_target_arg {
 	struct cpufreq_policy		*pol;
-	unsigned			targfreq;
-	unsigned			relation;
+	unsigned			newstate;
 };
 
 static long powernowk8_target_fn(void *arg)
 {
 	struct powernowk8_target_arg *pta = arg;
 	struct cpufreq_policy *pol = pta->pol;
-	unsigned targfreq = pta->targfreq;
-	unsigned relation = pta->relation;
+	unsigned newstate = pta->newstate;
 	struct powernow_k8_data *data = per_cpu(powernow_data, pol->cpu);
 	u32 checkfid;
 	u32 checkvid;
-	unsigned int newstate;
 	int ret;
 
 	if (!data)
@@ -1004,8 +1001,9 @@ static long powernowk8_target_fn(void *arg)
 		return -EIO;
 	}
 
-	pr_debug("targ: cpu %d, %d kHz, min %d, max %d, relation %d\n",
-		pol->cpu, targfreq, pol->min, pol->max, relation);
+	pr_debug("targ: cpu %d, %d kHz, min %d, max %d\n",
+		pol->cpu, data->powernow_table[newstate].frequency, pol->min,
+		pol->max);
 
 	if (query_current_values_with_pending_wait(data))
 		return -EIO;
@@ -1021,10 +1019,6 @@ static long powernowk8_target_fn(void *arg)
 		       checkvid, data->currvid);
 	}
 
-	if (cpufreq_frequency_table_target(pol, data->powernow_table,
-				targfreq, relation, &newstate))
-		return -EIO;
-
 	mutex_lock(&fidvid_mutex);
 
 	powernow_k8_acpi_pst_values(data, newstate);
@@ -1044,11 +1038,9 @@ static long powernowk8_target_fn(void *arg)
 }
 
 /* Driver entry point to switch to the target frequency */
-static int powernowk8_target(struct cpufreq_policy *pol,
-		unsigned targfreq, unsigned relation)
+static int powernowk8_target(struct cpufreq_policy *pol, unsigned index)
 {
-	struct powernowk8_target_arg pta = { .pol = pol, .targfreq = targfreq,
-					     .relation = relation };
+	struct powernowk8_target_arg pta = { .pol = pol, .newstate = index };
 
 	return work_on_cpu(pol->cpu, powernowk8_target_fn, &pta);
 }
@@ -1213,7 +1205,7 @@ out:
 
 static struct cpufreq_driver cpufreq_amd64_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= powernowk8_target,
+	.target_index	= powernowk8_target,
 	.bios_limit	= acpi_processor_get_bios_limit,
 	.init		= powernowk8_cpu_init,
 	.exit		= powernowk8_cpu_exit,
diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index a0f562c..79d8e9c 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -251,27 +251,20 @@ static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 }
 
 static int corenet_cpufreq_target(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+		unsigned int index)
 {
 	struct cpufreq_freqs freqs;
-	unsigned int new;
 	struct clk *parent;
 	int ret;
 	struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
 
-	cpufreq_frequency_table_target(policy, data->table,
-			target_freq, relation, &new);
-
-	if (policy->cur == data->table[new].frequency)
-		return 0;
-
 	freqs.old = policy->cur;
-	freqs.new = data->table[new].frequency;
+	freqs.new = data->table[index].frequency;
 
 	mutex_lock(&cpufreq_lock);
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
-	parent = of_clk_get(data->parent, data->table[new].driver_data);
+	parent = of_clk_get(data->parent, data->table[index].driver_data);
 	ret = clk_set_parent(data->clk, parent);
 	if (ret)
 		freqs.new = freqs.old;
@@ -288,7 +281,7 @@ static struct cpufreq_driver ppc_corenet_cpufreq_driver = {
 	.init		= corenet_cpufreq_cpu_init,
 	.exit		= __exit_p(corenet_cpufreq_cpu_exit),
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= corenet_cpufreq_target,
+	.target_index	= corenet_cpufreq_target,
 	.get		= corenet_cpufreq_get_speed,
 	.attr		= cpufreq_generic_attr,
 };
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index 38540d1..52f707d 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -129,18 +129,10 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 }
 
 static int cbe_cpufreq_target(struct cpufreq_policy *policy,
-			      unsigned int target_freq,
-			      unsigned int relation)
+			      unsigned int cbe_pmode_new)
 {
 	int rc;
 	struct cpufreq_freqs freqs;
-	unsigned int cbe_pmode_new;
-
-	cpufreq_frequency_table_target(policy,
-				       cbe_freqs,
-				       target_freq,
-				       relation,
-				       &cbe_pmode_new);
 
 	freqs.old = policy->cur;
 	freqs.new = cbe_freqs[cbe_pmode_new].frequency;
@@ -164,7 +156,7 @@ static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 
 static struct cpufreq_driver cbe_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= cbe_cpufreq_target,
+	.target_index	= cbe_cpufreq_target,
 	.init		= cbe_cpufreq_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.name		= "cbe-cpufreq",
diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 29aca57..183bc13 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -267,14 +267,11 @@ static unsigned int pxa_cpufreq_get(unsigned int cpu)
 	return get_clk_frequency_khz(0);
 }
 
-static int pxa_set_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
+static int pxa_set_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct cpufreq_frequency_table *pxa_freqs_table;
 	pxa_freqs_t *pxa_freq_settings;
 	struct cpufreq_freqs freqs;
-	unsigned int idx;
 	unsigned long flags;
 	unsigned int new_freq_cpu, new_freq_mem;
 	unsigned int unused, preset_mdrefr, postset_mdrefr, cclkcfg;
@@ -283,12 +280,6 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	/* Get the current policy */
 	find_freq_tables(&pxa_freqs_table, &pxa_freq_settings);
 
-	/* Lookup the next frequency */
-	if (cpufreq_frequency_table_target(policy, pxa_freqs_table,
-					   target_freq, relation, &idx)) {
-		return -EINVAL;
-	}
-
 	new_freq_cpu = pxa_freq_settings[idx].khz;
 	new_freq_mem = pxa_freq_settings[idx].membus;
 	freqs.old = policy->cur;
@@ -448,7 +439,7 @@ static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver pxa_cpufreq_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.target	= pxa_set_target,
+	.target_index = pxa_set_target,
 	.init	= pxa_cpufreq_init,
 	.exit	= cpufreq_generic_exit,
 	.get	= pxa_cpufreq_get,
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 47fbee4..132e37d 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -155,24 +155,16 @@ static unsigned int pxa3xx_cpufreq_get(unsigned int cpu)
 	return pxa3xx_get_clk_frequency_khz(0);
 }
 
-static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
-			      unsigned int target_freq,
-			      unsigned int relation)
+static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct pxa3xx_freq_info *next;
 	struct cpufreq_freqs freqs;
 	unsigned long flags;
-	int idx;
 
 	if (policy->cpu != 0)
 		return -EINVAL;
 
-	/* Lookup the next frequency */
-	if (cpufreq_frequency_table_target(policy, pxa3xx_freqs_table,
-				target_freq, relation, &idx))
-		return -EINVAL;
-
-	next = &pxa3xx_freqs[idx];
+	next = &pxa3xx_freqs[index];
 
 	freqs.old = policy->cur;
 	freqs.new = next->cpufreq_mhz * 1000;
@@ -181,9 +173,6 @@ static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
 			freqs.old / 1000, freqs.new / 1000,
 			(freqs.old == freqs.new) ? " (skipped)" : "");
 
-	if (freqs.old == target_freq)
-		return 0;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	local_irq_save(flags);
@@ -225,7 +214,7 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver pxa3xx_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= pxa3xx_cpufreq_set,
+	.target_index	= pxa3xx_cpufreq_set,
 	.init		= pxa3xx_cpufreq_init,
 	.exit		= cpufreq_generic_exit,
 	.get		= pxa3xx_cpufreq_get,
diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 26a35d1..4188acc 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -217,24 +217,15 @@ static int s3c2416_cpufreq_leave_dvs(struct s3c2416_data *s3c_freq, int idx)
 }
 
 static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
-				      unsigned int target_freq,
-				      unsigned int relation)
+				      unsigned int index)
 {
 	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
 	struct cpufreq_freqs freqs;
 	int idx, ret, to_dvs = 0;
-	unsigned int i;
 
 	mutex_lock(&cpufreq_lock);
 
-	pr_debug("cpufreq: to %dKHz, relation %d\n", target_freq, relation);
-
-	ret = cpufreq_frequency_table_target(policy, s3c_freq->freq_table,
-					     target_freq, relation, &i);
-	if (ret != 0)
-		goto out;
-
-	idx = s3c_freq->freq_table[i].driver_data;
+	idx = s3c_freq->freq_table[index].driver_data;
 
 	if (idx == SOURCE_HCLK)
 		to_dvs = 1;
@@ -256,7 +247,7 @@ static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
 	 */
 	freqs.new = (s3c_freq->is_dvs && !to_dvs)
 				? clk_get_rate(s3c_freq->hclk) / 1000
-				: s3c_freq->freq_table[i].frequency;
+				: s3c_freq->freq_table[index].frequency;
 
 	pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
 
@@ -505,7 +496,7 @@ err_hclk:
 static struct cpufreq_driver s3c2416_cpufreq_driver = {
 	.flags          = 0,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= s3c2416_cpufreq_set_target,
+	.target_index	= s3c2416_cpufreq_set_target,
 	.get		= s3c2416_cpufreq_get_speed,
 	.init		= s3c2416_cpufreq_driver_init,
 	.name		= "s3c2416",
diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 4616173..8bdcf32 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -63,26 +63,16 @@ static unsigned int s3c64xx_cpufreq_get_speed(unsigned int cpu)
 }
 
 static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
-				      unsigned int target_freq,
-				      unsigned int relation)
+				      unsigned int index)
 {
 	int ret;
-	unsigned int i;
 	struct cpufreq_freqs freqs;
 	struct s3c64xx_dvfs *dvfs;
 
-	ret = cpufreq_frequency_table_target(policy, s3c64xx_freq_table,
-					     target_freq, relation, &i);
-	if (ret != 0)
-		return ret;
-
 	freqs.old = clk_get_rate(armclk) / 1000;
-	freqs.new = s3c64xx_freq_table[i].frequency;
+	freqs.new = s3c64xx_freq_table[index].frequency;
 	freqs.flags = 0;
-	dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[i].driver_data];
-
-	if (freqs.old == freqs.new)
-		return 0;
+	dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[index].driver_data];
 
 	pr_debug("Transition %d-%dkHz\n", freqs.old, freqs.new);
 
@@ -254,7 +244,7 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver s3c64xx_cpufreq_driver = {
 	.flags          = 0,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= s3c64xx_cpufreq_set_target,
+	.target_index	= s3c64xx_cpufreq_set_target,
 	.get		= s3c64xx_cpufreq_get_speed,
 	.init		= s3c64xx_cpufreq_driver_init,
 	.name		= "s3c",
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 600b4f4..5978b94 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -36,16 +36,7 @@ static DEFINE_MUTEX(set_freq_lock);
 /* Use 800MHz when entering sleep mode */
 #define SLEEP_FREQ	(800 * 1000)
 
-/*
- * relation has an additional symantics other than the standard of cpufreq
- * DISALBE_FURTHER_CPUFREQ: disable further access to target
- * ENABLE_FURTUER_CPUFREQ: enable access to target
- */
-enum cpufreq_access {
-	DISABLE_FURTHER_CPUFREQ = 0x10,
-	ENABLE_FURTHER_CPUFREQ = 0x20,
-};
-
+/* Tracks if cpu freqency can be updated anymore */
 static bool no_cpufreq_access;
 
 /*
@@ -182,12 +173,10 @@ static unsigned int s5pv210_getspeed(unsigned int cpu)
 	return clk_get_rate(cpu_clk) / 1000;
 }
 
-static int s5pv210_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
+static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned long reg;
-	unsigned int index, priv_index;
+	unsigned int priv_index;
 	unsigned int pll_changing = 0;
 	unsigned int bus_speed_changing = 0;
 	int arm_volt, int_volt;
@@ -195,9 +184,6 @@ static int s5pv210_target(struct cpufreq_policy *policy,
 
 	mutex_lock(&set_freq_lock);
 
-	if (relation & ENABLE_FURTHER_CPUFREQ)
-		no_cpufreq_access = false;
-
 	if (no_cpufreq_access) {
 #ifdef CONFIG_PM_VERBOSE
 		pr_err("%s:%d denied access to %s as it is disabled"
@@ -207,27 +193,13 @@ static int s5pv210_target(struct cpufreq_policy *policy,
 		goto exit;
 	}
 
-	if (relation & DISABLE_FURTHER_CPUFREQ)
-		no_cpufreq_access = true;
-
-	relation &= ~(ENABLE_FURTHER_CPUFREQ | DISABLE_FURTHER_CPUFREQ);
-
 	freqs.old = s5pv210_getspeed(0);
-
-	if (cpufreq_frequency_table_target(policy, s5pv210_freq_table,
-					   target_freq, relation, &index)) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	freqs.new = s5pv210_freq_table[index].frequency;
 
-	if (freqs.new == freqs.old)
-		goto exit;
-
 	/* Finding current running level index */
 	if (cpufreq_frequency_table_target(policy, s5pv210_freq_table,
-					   freqs.old, relation, &priv_index)) {
+					   freqs.old, CPUFREQ_RELATION_H,
+					   &priv_index)) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -559,16 +531,18 @@ static int s5pv210_cpufreq_notifier_event(struct notifier_block *this,
 
 	switch (event) {
 	case PM_SUSPEND_PREPARE:
-		ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ,
-					    DISABLE_FURTHER_CPUFREQ);
+		ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
 		if (ret < 0)
 			return NOTIFY_BAD;
 
+		/* Disable updation of cpu frequency */
+		no_cpufreq_access = true;
 		return NOTIFY_OK;
 	case PM_POST_RESTORE:
 	case PM_POST_SUSPEND:
-		cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ,
-				      ENABLE_FURTHER_CPUFREQ);
+		/* Enable updation of cpu frequency */
+		no_cpufreq_access = false;
+		cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
 
 		return NOTIFY_OK;
 	}
@@ -581,18 +555,18 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
 {
 	int ret;
 
-	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ,
-				    DISABLE_FURTHER_CPUFREQ);
+	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
 	if (ret < 0)
 		return NOTIFY_BAD;
 
+	no_cpufreq_access = true;
 	return NOTIFY_DONE;
 }
 
 static struct cpufreq_driver s5pv210_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= s5pv210_target,
+	.target_index	= s5pv210_target,
 	.get		= s5pv210_getspeed,
 	.init		= s5pv210_cpu_init,
 	.name		= "s5pv210",
diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index b282cea..b0da1fe 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -177,36 +177,20 @@ static void sa1100_update_dram_timings(int current_speed, int new_speed)
 	}
 }
 
-static int sa1100_target(struct cpufreq_policy *policy,
-			 unsigned int target_freq,
-			 unsigned int relation)
+static int sa1100_target(struct cpufreq_policy *policy, unsigned int ppcr)
 {
 	unsigned int cur = sa11x0_getspeed(0);
-	unsigned int new_ppcr;
 	struct cpufreq_freqs freqs;
 
-	new_ppcr = sa11x0_freq_to_ppcr(target_freq);
-	switch (relation) {
-	case CPUFREQ_RELATION_L:
-		if (sa11x0_ppcr_to_freq(new_ppcr) > policy->max)
-			new_ppcr--;
-		break;
-	case CPUFREQ_RELATION_H:
-		if ((sa11x0_ppcr_to_freq(new_ppcr) > target_freq) &&
-		    (sa11x0_ppcr_to_freq(new_ppcr - 1) >= policy->min))
-			new_ppcr--;
-		break;
-	}
-
 	freqs.old = cur;
-	freqs.new = sa11x0_ppcr_to_freq(new_ppcr);
+	freqs.new = sa11x0_freq_table[ppcr].frequency;
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (freqs.new > cur)
 		sa1100_update_dram_timings(cur, freqs.new);
 
-	PPCR = new_ppcr;
+	PPCR = ppcr;
 
 	if (freqs.new < cur)
 		sa1100_update_dram_timings(cur, freqs.new);
@@ -224,7 +208,7 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver sa1100_driver __refdata = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= sa1100_target,
+	.target_index	= sa1100_target,
 	.get		= sa11x0_getspeed,
 	.init		= sa1100_cpu_init,
 	.name		= "sa1100",
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index bca04c0..55b1818c 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -229,34 +229,16 @@ sdram_update_refresh(u_int cpu_khz, struct sdram_params *sdram)
 /*
  * Ok, set the CPU frequency.
  */
-static int sa1110_target(struct cpufreq_policy *policy,
-			 unsigned int target_freq,
-			 unsigned int relation)
+static int sa1110_target(struct cpufreq_policy *policy, unsigned int ppcr)
 {
 	struct sdram_params *sdram = &sdram_params;
 	struct cpufreq_freqs freqs;
 	struct sdram_info sd;
 	unsigned long flags;
-	unsigned int ppcr, unused;
-
-	switch (relation) {
-	case CPUFREQ_RELATION_L:
-		ppcr = sa11x0_freq_to_ppcr(target_freq);
-		if (sa11x0_ppcr_to_freq(ppcr) > policy->max)
-			ppcr--;
-		break;
-	case CPUFREQ_RELATION_H:
-		ppcr = sa11x0_freq_to_ppcr(target_freq);
-		if (ppcr && (sa11x0_ppcr_to_freq(ppcr) > target_freq) &&
-		    (sa11x0_ppcr_to_freq(ppcr-1) >= policy->min))
-			ppcr--;
-		break;
-	default:
-		return -EINVAL;
-	}
+	unsigned int unused;
 
 	freqs.old = sa11x0_getspeed(0);
-	freqs.new = sa11x0_ppcr_to_freq(ppcr);
+	freqs.new = sa11x0_freq_table[ppcr].frequency;
 
 	sdram_calculate_timing(&sd, freqs.new, sdram);
 
@@ -340,7 +322,7 @@ static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver sa1110_driver __refdata = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= sa1110_target,
+	.target_index	= sa1110_target,
 	.get		= sa11x0_getspeed,
 	.init		= sa1110_cpu_init,
 	.name		= "sa1110",
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index 9047ab1..6c86452 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -53,8 +53,7 @@ static unsigned int sc520_freq_get_cpu_frequency(unsigned int cpu)
 	}
 }
 
-static void sc520_freq_set_cpu_state(struct cpufreq_policy *policy,
-		unsigned int state)
+static int sc520_freq_target(struct cpufreq_policy *policy, unsigned int state)
 {
 
 	struct cpufreq_freqs	freqs;
@@ -76,24 +75,10 @@ static void sc520_freq_set_cpu_state(struct cpufreq_policy *policy,
 	local_irq_enable();
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-};
-
-static int sc520_freq_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
-{
-	unsigned int newstate = 0;
-
-	if (cpufreq_frequency_table_target(policy, sc520_freq_table,
-				target_freq, relation, &newstate))
-		return -EINVAL;
-
-	sc520_freq_set_cpu_state(policy, newstate);
 
 	return 0;
 }
 
-
 /*
  *	Module init and exit code
  */
@@ -117,7 +102,7 @@ static int sc520_freq_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver sc520_freq_driver = {
 	.get	= sc520_freq_get_cpu_frequency,
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.target	= sc520_freq_target,
+	.target_index = sc520_freq_target,
 	.init	= sc520_freq_cpu_init,
 	.exit	= cpufreq_generic_exit,
 	.name	= "sc520_freq",
diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index 291688c..3bf5b8f 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -245,8 +245,7 @@ static unsigned int us2e_freq_get(unsigned int cpu)
 	return clock_tick / estar_to_divisor(estar);
 }
 
-static void us2e_set_cpu_divider_index(struct cpufreq_policy *policy,
-		unsigned int index)
+static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned int cpu = policy->cpu;
 	unsigned long new_bits, new_freq;
@@ -277,20 +276,6 @@ static void us2e_set_cpu_divider_index(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	set_cpus_allowed_ptr(current, &cpus_allowed);
-}
-
-static int us2e_freq_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
-{
-	unsigned int new_index = 0;
-
-	if (cpufreq_frequency_table_target(policy,
-					   &us2e_freq_table[policy->cpu].table[0],
-					   target_freq, relation, &new_index))
-		return -EINVAL;
-
-	us2e_set_cpu_divider_index(policy, new_index);
 
 	return 0;
 }
@@ -325,7 +310,7 @@ static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
 {
 	if (cpufreq_us2e_driver) {
 		cpufreq_frequency_table_put_attr(policy->cpu);
-		us2e_set_cpu_divider_index(policy, 0);
+		us2e_freq_target(policy, 0);
 	}
 
 	return 0;
@@ -358,7 +343,7 @@ static int __init us2e_freq_init(void)
 
 		driver->init = us2e_freq_cpu_init;
 		driver->verify = cpufreq_generic_frequency_table_verify;
-		driver->target = us2e_freq_target;
+		driver->target_index = us2e_freq_target;
 		driver->get = us2e_freq_get;
 		driver->exit = us2e_freq_cpu_exit;
 		strcpy(driver->name, "UltraSPARC-IIe");
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 9b3dbd3..2e54d55 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -93,8 +93,7 @@ static unsigned int us3_freq_get(unsigned int cpu)
 	return ret;
 }
 
-static void us3_set_cpu_divider_index(struct cpufreq_policy *policy,
-		unsigned int index)
+static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned int cpu = policy->cpu;
 	unsigned long new_bits, new_freq, reg;
@@ -136,22 +135,6 @@ static void us3_set_cpu_divider_index(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	set_cpus_allowed_ptr(current, &cpus_allowed);
-}
-
-static int us3_freq_target(struct cpufreq_policy *policy,
-			  unsigned int target_freq,
-			  unsigned int relation)
-{
-	unsigned int new_index = 0;
-
-	if (cpufreq_frequency_table_target(policy,
-					   &us3_freq_table[policy->cpu].table[0],
-					   target_freq,
-					   relation,
-					   &new_index))
-		return -EINVAL;
-
-	us3_set_cpu_divider_index(policy, new_index);
 
 	return 0;
 }
@@ -182,7 +165,7 @@ static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
 {
 	if (cpufreq_us3_driver) {
 		cpufreq_frequency_table_put_attr(policy->cpu);
-		us3_set_cpu_divider_index(policy, 0);
+		us3_freq_target(policy, 0);
 	}
 
 	return 0;
@@ -219,7 +202,7 @@ static int __init us3_freq_init(void)
 
 		driver->init = us3_freq_cpu_init;
 		driver->verify = cpufreq_generic_frequency_table_verify;
-		driver->target = us3_freq_target;
+		driver->target_index = us3_freq_target;
 		driver->get = us3_freq_get;
 		driver->exit = us3_freq_cpu_exit;
 		strcpy(driver->name, "UltraSPARC-III");
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 8841366..11a65be 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -105,20 +105,16 @@ static int spear1340_set_cpu_rate(struct clk *sys_pclk, unsigned long newfreq)
 }
 
 static int spear_cpufreq_target(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+		unsigned int index)
 {
 	struct cpufreq_freqs freqs;
 	long newfreq;
 	struct clk *srcclk;
-	int index, ret, mult = 1;
-
-	if (cpufreq_frequency_table_target(policy, spear_cpufreq.freq_tbl,
-				target_freq, relation, &index))
-		return -EINVAL;
+	int ret, mult = 1;
 
 	freqs.old = spear_cpufreq_get(0);
-
 	newfreq = spear_cpufreq.freq_tbl[index].frequency * 1000;
+
 	if (of_machine_is_compatible("st,spear1340")) {
 		/*
 		 * SPEAr1340 is special in the sense that due to the possibility
@@ -179,7 +175,7 @@ static struct cpufreq_driver spear_cpufreq_driver = {
 	.name		= "cpufreq-spear",
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= spear_cpufreq_target,
+	.target_index	= spear_cpufreq_target,
 	.get		= spear_cpufreq_get,
 	.init		= spear_cpufreq_init,
 	.exit		= cpufreq_generic_exit,
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 25e45f8..c51ec8c 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -416,21 +416,17 @@ static int centrino_cpu_exit(struct cpufreq_policy *policy)
 /**
  * centrino_setpolicy - set a new CPUFreq policy
  * @policy: new policy
- * @target_freq: the target frequency
- * @relation: how that frequency relates to achieved frequency
- *	(CPUFREQ_RELATION_L or CPUFREQ_RELATION_H)
+ * @index: index of target frequency
  *
  * Sets a new CPUFreq policy.
  */
-static int centrino_target (struct cpufreq_policy *policy,
-			    unsigned int target_freq,
-			    unsigned int relation)
+static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int    newstate = 0;
 	unsigned int	msr, oldmsr = 0, h = 0, cpu = policy->cpu;
 	struct cpufreq_freqs	freqs;
 	int			retval = 0;
 	unsigned int		j, first_cpu, tmp;
+	struct cpufreq_frequency_table *op_points;
 	cpumask_var_t covered_cpus;
 
 	if (unlikely(!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL)))
@@ -441,16 +437,8 @@ static int centrino_target (struct cpufreq_policy *policy,
 		goto out;
 	}
 
-	if (unlikely(cpufreq_frequency_table_target(policy,
-			per_cpu(centrino_model, cpu)->op_points,
-			target_freq,
-			relation,
-			&newstate))) {
-		retval = -EINVAL;
-		goto out;
-	}
-
 	first_cpu = 1;
+	op_points = &per_cpu(centrino_model, cpu)->op_points[index];
 	for_each_cpu(j, policy->cpus) {
 		int good_cpu;
 
@@ -474,7 +462,7 @@ static int centrino_target (struct cpufreq_policy *policy,
 			break;
 		}
 
-		msr = per_cpu(centrino_model, cpu)->op_points[newstate].driver_data;
+		msr = op_points->driver_data;
 
 		if (first_cpu) {
 			rdmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, &oldmsr, &h);
@@ -489,7 +477,8 @@ static int centrino_target (struct cpufreq_policy *policy,
 			freqs.new = extract_clock(msr, cpu, 0);
 
 			pr_debug("target=%dkHz old=%d new=%d msr=%04x\n",
-				target_freq, freqs.old, freqs.new, msr);
+				op_points->frequency, freqs.old, freqs.new,
+				msr);
 
 			cpufreq_notify_transition(policy, &freqs,
 					CPUFREQ_PRECHANGE);
@@ -540,7 +529,7 @@ static struct cpufreq_driver centrino_driver = {
 	.init		= centrino_cpu_init,
 	.exit		= centrino_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= centrino_target,
+	.target_index	= centrino_target,
 	.get		= get_cur_freq,
 	.attr		= cpufreq_generic_attr,
 };
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index 1a8b01b..707721e 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -251,36 +251,24 @@ static unsigned int speedstep_get(unsigned int cpu)
 /**
  * speedstep_target - set a new CPUFreq policy
  * @policy: new policy
- * @target_freq: the target frequency
- * @relation: how that frequency relates to achieved frequency
- *	(CPUFREQ_RELATION_L or CPUFREQ_RELATION_H)
+ * @index: index of target frequency
  *
  * Sets a new CPUFreq policy.
  */
-static int speedstep_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static int speedstep_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int newstate = 0, policy_cpu;
+	unsigned int policy_cpu;
 	struct cpufreq_freqs freqs;
 
-	if (cpufreq_frequency_table_target(policy, &speedstep_freqs[0],
-				target_freq, relation, &newstate))
-		return -EINVAL;
-
 	policy_cpu = cpumask_any_and(policy->cpus, cpu_online_mask);
 	freqs.old = speedstep_get(policy_cpu);
-	freqs.new = speedstep_freqs[newstate].frequency;
+	freqs.new = speedstep_freqs[index].frequency;
 
 	pr_debug("transiting from %u to %u kHz\n", freqs.old, freqs.new);
 
-	/* no transition necessary */
-	if (freqs.old == freqs.new)
-		return 0;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
-	smp_call_function_single(policy_cpu, _speedstep_set_state, &newstate,
+	smp_call_function_single(policy_cpu, _speedstep_set_state, &index,
 				 true);
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
@@ -330,7 +318,7 @@ static int speedstep_cpu_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver speedstep_driver = {
 	.name	= "speedstep-ich",
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.target	= speedstep_target,
+	.target_index = speedstep_target,
 	.init	= speedstep_cpu_init,
 	.exit	= cpufreq_generic_exit,
 	.get	= speedstep_get,
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index a02b649..19446e4 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -235,29 +235,19 @@ static void speedstep_set_state(unsigned int state)
 /**
  * speedstep_target - set a new CPUFreq policy
  * @policy: new policy
- * @target_freq: new freq
- * @relation:
+ * @index: index of new freq
  *
  * Sets a new CPUFreq policy/freq.
  */
-static int speedstep_target(struct cpufreq_policy *policy,
-			unsigned int target_freq, unsigned int relation)
+static int speedstep_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int newstate = 0;
 	struct cpufreq_freqs freqs;
 
-	if (cpufreq_frequency_table_target(policy, &speedstep_freqs[0],
-				target_freq, relation, &newstate))
-		return -EINVAL;
-
 	freqs.old = speedstep_freqs[speedstep_get_state()].frequency;
-	freqs.new = speedstep_freqs[newstate].frequency;
-
-	if (freqs.old == freqs.new)
-		return 0;
+	freqs.new = speedstep_freqs[index].frequency;
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-	speedstep_set_state(newstate);
+	speedstep_set_state(index);
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
 	return 0;
@@ -327,7 +317,7 @@ static int speedstep_resume(struct cpufreq_policy *policy)
 static struct cpufreq_driver speedstep_driver = {
 	.name		= "speedstep-smi",
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= speedstep_target,
+	.target_index	= speedstep_target,
 	.init		= speedstep_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.get		= speedstep_get,
diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index 32483ef..bd7d89c 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -150,11 +150,8 @@ static unsigned long tegra_cpu_highest_speed(void)
 	return rate;
 }
 
-static int tegra_target(struct cpufreq_policy *policy,
-		       unsigned int target_freq,
-		       unsigned int relation)
+static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int idx;
 	unsigned int freq;
 	int ret = 0;
 
@@ -165,10 +162,7 @@ static int tegra_target(struct cpufreq_policy *policy,
 		goto out;
 	}
 
-	cpufreq_frequency_table_target(policy, freq_table, target_freq,
-		relation, &idx);
-
-	freq = freq_table[idx].frequency;
+	freq = freq_table[index].frequency;
 
 	target_cpu_speed[policy->cpu] = freq;
 
@@ -238,7 +232,7 @@ static int tegra_cpu_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver tegra_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= tegra_target,
+	.target_index	= tegra_target,
 	.get		= tegra_getspeed,
 	.init		= tegra_cpu_init,
 	.exit		= tegra_cpu_exit,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6b457d0..93a8c34 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -201,9 +201,11 @@ struct cpufreq_driver {
 
 	/* define one out of two */
 	int	(*setpolicy)	(struct cpufreq_policy *policy);
-	int	(*target)	(struct cpufreq_policy *policy,
+	int	(*target)	(struct cpufreq_policy *policy,	/* Deprecated */
 				 unsigned int target_freq,
 				 unsigned int relation);
+	int	(*target_index)	(struct cpufreq_policy *policy,
+				 unsigned int index);
 
 	/* should be defined, if possible */
 	unsigned int	(*get)	(unsigned int cpu);
-- 
1.7.12.rc2.18.g61b472e

