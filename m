From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Fri, 31 Jul 2015 16:14:33 +0530
Message-ID: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36145 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbGaKor (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 06:44:47 -0400
Received: by pdjr16 with SMTP id r16so41810582pdj.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2015 03:44:47 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

CPUFreq drivers today support ->get(cpu) callback, which returns current
clock rate of the CPU. The problem with ->get() is that it takes cpu
number as parameter and this unnecessarily makes things complex.

Firstly the core gets the cpu number by doing operation 'policy->cpu' on
the policy and then many drivers need to get the policy back and so do
cpufreq_cpu_get(cpu) on the cpu passed as argument to ->get().

It would be better if we pass them 'policy' directly and drivers can use
policy->cpu if that's all they need.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c         | 15 ++++-----------
 drivers/cpufreq/arm_big_little.c       |  9 +++++++--
 drivers/cpufreq/blackfin-cpufreq.c     |  4 ++--
 drivers/cpufreq/cpufreq-nforce2.c      |  8 ++++----
 drivers/cpufreq/cpufreq.c              | 32 ++++++++++++++++----------------
 drivers/cpufreq/cris-artpec3-cpufreq.c |  2 +-
 drivers/cpufreq/cris-etraxfs-cpufreq.c |  2 +-
 drivers/cpufreq/e_powersaver.c         |  3 ++-
 drivers/cpufreq/elanfreq.c             |  4 ++--
 drivers/cpufreq/gx-suspmod.c           |  4 ++--
 drivers/cpufreq/ia64-acpi-cpufreq.c    |  3 ++-
 drivers/cpufreq/integrator-cpufreq.c   |  3 ++-
 drivers/cpufreq/intel_pstate.c         |  4 ++--
 drivers/cpufreq/kirkwood-cpufreq.c     |  3 ++-
 drivers/cpufreq/longhaul.c             |  4 ++--
 drivers/cpufreq/longrun.c              |  4 ++--
 drivers/cpufreq/maple-cpufreq.c        |  2 +-
 drivers/cpufreq/p4-clockmod.c          |  5 ++---
 drivers/cpufreq/pcc-cpufreq.c          |  3 ++-
 drivers/cpufreq/pmac32-cpufreq.c       |  2 +-
 drivers/cpufreq/pmac64-cpufreq.c       |  2 +-
 drivers/cpufreq/powernow-k6.c          |  2 +-
 drivers/cpufreq/powernow-k7.c          |  4 ++--
 drivers/cpufreq/powernow-k8.c          |  3 ++-
 drivers/cpufreq/powernv-cpufreq.c      |  6 +++---
 drivers/cpufreq/pxa2xx-cpufreq.c       |  2 +-
 drivers/cpufreq/pxa3xx-cpufreq.c       |  2 +-
 drivers/cpufreq/s3c2416-cpufreq.c      |  4 ++--
 drivers/cpufreq/sa1100-cpufreq.c       |  7 ++++++-
 drivers/cpufreq/sa1110-cpufreq.c       |  7 ++++++-
 drivers/cpufreq/sc520_freq.c           |  2 +-
 drivers/cpufreq/sh-cpufreq.c           |  6 +++---
 drivers/cpufreq/sparc-us2e-cpufreq.c   |  3 ++-
 drivers/cpufreq/sparc-us3-cpufreq.c    |  3 ++-
 drivers/cpufreq/speedstep-centrino.c   |  3 ++-
 drivers/cpufreq/speedstep-ich.c        |  5 +++--
 drivers/cpufreq/speedstep-smi.c        |  4 ++--
 include/linux/cpufreq.h                |  4 ++--
 38 files changed, 101 insertions(+), 84 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 15b921a9248c..651a8c7e27ef 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -366,26 +366,19 @@ get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *data)
 	return cmd.val;
 }
 
-static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
+static unsigned int get_cur_freq_on_cpu(struct cpufreq_policy *policy)
 {
-	struct acpi_cpufreq_data *data;
-	struct cpufreq_policy *policy;
+	struct acpi_cpufreq_data *data = policy->driver_data;
 	unsigned int freq;
 	unsigned int cached_freq;
 
-	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
-
-	policy = cpufreq_cpu_get(cpu);
-	if (unlikely(!policy))
-		return 0;
+	pr_debug("get_cur_freq_on_cpu (%d)\n", policy->cpu);
 
-	data = policy->driver_data;
-	cpufreq_cpu_put(policy);
 	if (unlikely(!data || !data->freq_table))
 		return 0;
 
 	cached_freq = data->freq_table[to_perf_data(data)->state].frequency;
-	freq = extract_freq(get_cur_val(cpumask_of(cpu), data), data);
+	freq = extract_freq(get_cur_val(cpumask_of(policy->cpu), data), data);
 	if (freq != cached_freq) {
 		/*
 		 * The dreaded BIOS frequency change behind our back.
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index f1e42f8ce0fc..a9bd87f77d53 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -113,7 +113,7 @@ static unsigned int clk_get_cpu_rate(unsigned int cpu)
 	return rate;
 }
 
-static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
+static inline unsigned int __bL_cpufreq_get_rate(unsigned int cpu)
 {
 	if (is_bL_switching_enabled()) {
 		pr_debug("%s: freq: %d\n", __func__, per_cpu(cpu_last_req_freq,
@@ -125,6 +125,11 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
 	}
 }
 
+static unsigned int bL_cpufreq_get_rate(struct cpufreq_policy *policy)
+{
+	return __bL_cpufreq_get_rate(policy->cpu);
+}
+
 static unsigned int
 bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 {
@@ -196,7 +201,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 	 * be reading only the cached value anyway. This needs to  be removed
 	 * once clk core is fixed.
 	 */
-	if (bL_cpufreq_get_rate(cpu) != new_rate)
+	if (__bL_cpufreq_get_rate(cpu) != new_rate)
 		return -EIO;
 	return 0;
 }
diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index a9f8e5bd0716..83dae4d990b5 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -105,7 +105,7 @@ static void bfin_adjust_core_timer(void *info)
 	return;
 }
 
-static unsigned int bfin_getfreq_khz(unsigned int cpu)
+static unsigned int bfin_getfreq_khz(struct cpufreq_policy *policy)
 {
 	/* Both CoreA/B have the same core clock */
 	return get_cclk() / 1000;
@@ -141,7 +141,7 @@ static int bfin_target(struct cpufreq_policy *policy, unsigned int index)
 	cycles_t cycles;
 #endif
 
-	old_freq = bfin_getfreq_khz(0);
+	old_freq = bfin_getfreq_khz(policy);
 	new_freq = bfin_freq_table[index].frequency;
 
 #ifndef CONFIG_BF60x
diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index db69eeb501a7..fce033787bf4 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -229,13 +229,13 @@ static int nforce2_set_fsb(unsigned int fsb)
 
 /**
  * nforce2_get - get the CPU frequency
- * @cpu: CPU number
+ * @policy: CPUFreq policy
  *
  * Returns the CPU frequency
  */
-static unsigned int nforce2_get(unsigned int cpu)
+static unsigned int nforce2_get(struct cpufreq_policy *policy)
 {
-	if (cpu)
+	if (policy->cpu)
 		return 0;
 	return nforce2_fsb_read(0) * fid * 100;
 }
@@ -261,7 +261,7 @@ static int nforce2_target(struct cpufreq_policy *policy,
 
 	target_fsb = target_freq / (fid * 100);
 
-	freqs.old = nforce2_get(policy->cpu);
+	freqs.old = nforce2_get(policy);
 	freqs.new = target_fsb * fid * 100;
 
 	if (freqs.old == freqs.new)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0618522d4863..485171d5c455 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -246,13 +246,11 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
 }
 
-unsigned int cpufreq_generic_get(unsigned int cpu)
+unsigned int cpufreq_generic_get(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-
-	if (!policy || IS_ERR(policy->clk)) {
+	if (IS_ERR(policy->clk)) {
 		pr_err("%s: No %s associated to cpu: %d\n",
-		       __func__, policy ? "clk" : "policy", cpu);
+		       __func__, policy ? "clk" : "policy", policy->cpu);
 		return 0;
 	}
 
@@ -587,7 +585,7 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 	ssize_t ret;
 
 	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
-		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
+		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy));
 	else
 		ret = sprintf(buf, "%u\n", policy->cur);
 	return ret;
@@ -1279,7 +1277,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
-		policy->cur = cpufreq_driver->get(policy->cpu);
+		policy->cur = cpufreq_driver->get(policy);
 		if (!policy->cur) {
 			pr_err("%s: ->get() failed\n", __func__);
 			goto out_exit_policy;
@@ -1540,16 +1538,18 @@ static void cpufreq_out_of_sync(struct cpufreq_policy *policy,
 unsigned int cpufreq_quick_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
-	unsigned int ret_freq = 0;
-
-	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
-		return cpufreq_driver->get(cpu);
+	unsigned int ret_freq;
 
 	policy = cpufreq_cpu_get(cpu);
-	if (policy) {
+	if (!policy)
+		return 0;
+
+	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get)
+		ret_freq = cpufreq_driver->get(policy);
+	else
 		ret_freq = policy->cur;
-		cpufreq_cpu_put(policy);
-	}
+
+	cpufreq_cpu_put(policy);
 
 	return ret_freq;
 }
@@ -1582,7 +1582,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 	if (!cpufreq_driver->get)
 		return ret_freq;
 
-	ret_freq = cpufreq_driver->get(policy->cpu);
+	ret_freq = cpufreq_driver->get(policy);
 
 	/* Updating inactive policies is invalid, so avoid doing that. */
 	if (unlikely(policy_is_inactive(policy)))
@@ -2311,7 +2311,7 @@ int cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
-		new_policy.cur = cpufreq_driver->get(cpu);
+		new_policy.cur = cpufreq_driver->get(policy);
 		if (WARN_ON(!new_policy.cur)) {
 			ret = -EIO;
 			goto unlock;
diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 601b88c490cf..958722346df9 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -20,7 +20,7 @@ static struct cpufreq_frequency_table cris_freq_table[] = {
 	{0, 0, CPUFREQ_TABLE_END},
 };
 
-static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
+static unsigned int cris_freq_get_cpu_frequency(struct cpufreq_policy *policy)
 {
 	reg_clkgen_rw_clk_ctrl clk_ctrl;
 	clk_ctrl = REG_RD(clkgen, regi_clkgen, rw_clk_ctrl);
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index 22b2cdde74d9..c934e64dd0e6 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -20,7 +20,7 @@ static struct cpufreq_frequency_table cris_freq_table[] = {
 	{0, 0, CPUFREQ_TABLE_END},
 };
 
-static unsigned int cris_freq_get_cpu_frequency(unsigned int cpu)
+static unsigned int cris_freq_get_cpu_frequency(struct cpufreq_policy *policy)
 {
 	reg_config_rw_clk_ctrl clk_ctrl;
 	clk_ctrl = REG_RD(config, regi_config, rw_clk_ctrl);
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 4085244c8a67..12fcc6000a9d 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -87,8 +87,9 @@ static int eps_acpi_exit(struct cpufreq_policy *policy)
 }
 #endif
 
-static unsigned int eps_get(unsigned int cpu)
+static unsigned int eps_get(struct cpufreq_policy *policy)
 {
+	unsigned int cpu = policy->cpu;
 	struct eps_cpu_data *centaur;
 	u32 lo, hi;
 
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 1c06e786c9ba..6a7e7123369a 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -77,7 +77,7 @@ static struct cpufreq_frequency_table elanfreq_table[] = {
  *	and have the rest of the chip running with 33 MHz.
  */
 
-static unsigned int elanfreq_get_cpu_frequency(unsigned int cpu)
+static unsigned int elanfreq_get_cpu_frequency(struct cpufreq_policy *policy)
 {
 	u8 clockspeed_reg;    /* Clock Speed Register */
 
@@ -156,7 +156,7 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 
 	/* max freq */
 	if (!max_freq)
-		max_freq = elanfreq_get_cpu_frequency(0);
+		max_freq = elanfreq_get_cpu_frequency(policy);
 
 	/* table init */
 	cpufreq_for_each_entry(pos, elanfreq_table)
diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
index 3488c9c175eb..b964f36e3891 100644
--- a/drivers/cpufreq/gx-suspmod.c
+++ b/drivers/cpufreq/gx-suspmod.c
@@ -203,7 +203,7 @@ static struct pci_dev * __init gx_detect_chipset(void)
  * Finds out at which efficient frequency the Cyrix MediaGX/NatSemi
  * Geode CPU runs.
  */
-static unsigned int gx_get_cpuspeed(unsigned int cpu)
+static unsigned int gx_get_cpuspeed(struct cpufreq_policy *policy)
 {
 	if ((gx_params->pci_suscfg & SUSMOD) == 0)
 		return stock_freq;
@@ -258,7 +258,7 @@ static void gx_set_cpuspeed(struct cpufreq_policy *policy, unsigned int khz)
 	unsigned long flags;
 	struct cpufreq_freqs freqs;
 
-	freqs.old = gx_get_cpuspeed(0);
+	freqs.old = gx_get_cpuspeed(policy);
 
 	new_khz = gx_validate_speed(khz, &gx_params->on_duration,
 			&gx_params->off_duration);
diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 0202429f1c5b..839ca045d5be 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -194,8 +194,9 @@ processor_set_freq (
 
 static unsigned int
 acpi_cpufreq_get (
-	unsigned int		cpu)
+	struct cpufreq_policy	*policy)
 {
+	int cpu = policy->cpu;
 	struct cpufreq_acpi_io *data = acpi_io_data[cpu];
 
 	pr_debug("acpi_cpufreq_get\n");
diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index 2faa4216bf2a..72b7598867a3 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -147,8 +147,9 @@ static int integrator_set_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
-static unsigned int integrator_get(unsigned int cpu)
+static unsigned int integrator_get(struct cpufreq_policy *policy)
 {
+	unsigned int cpu = policy->cpu;
 	cpumask_t cpus_allowed;
 	unsigned int current_freq;
 	u_int cm_osc;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 7b2721fb861f..db091976f114 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -957,12 +957,12 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 	return 0;
 }
 
-static unsigned int intel_pstate_get(unsigned int cpu_num)
+static unsigned int intel_pstate_get(struct cpufreq_policy *policy)
 {
 	struct sample *sample;
 	struct cpudata *cpu;
 
-	cpu = all_cpu_data[cpu_num];
+	cpu = all_cpu_data[policy->cpu];
 	if (!cpu)
 		return 0;
 	sample = &cpu->sample;
diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index be42f103db60..c6ed1dcb5aad 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -46,7 +46,8 @@ static struct cpufreq_frequency_table kirkwood_freq_table[] = {
 	{0, 0,			CPUFREQ_TABLE_END},
 };
 
-static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
+static unsigned int
+kirkwood_cpufreq_get_cpu_frequency(struct cpufreq_policy *policy)
 {
 	return clk_get_rate(priv.powersave_clk) / 1000;
 }
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 0f6b229afcb9..550ce82acda3 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -667,9 +667,9 @@ static int longhaul_target(struct cpufreq_policy *policy,
 }
 
 
-static unsigned int longhaul_get(unsigned int cpu)
+static unsigned int longhaul_get(struct cpufreq_policy *policy)
 {
-	if (cpu)
+	if (!policy->cpu)
 		return 0;
 	return calc_speed(longhaul_get_cpu_mult());
 }
diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 074971b12635..e991a2ef5c54 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -138,11 +138,11 @@ static int longrun_verify_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static unsigned int longrun_get(unsigned int cpu)
+static unsigned int longrun_get(struct cpufreq_policy *policy)
 {
 	u32 eax, ebx, ecx, edx;
 
-	if (cpu)
+	if (policy->cpu)
 		return 0;
 
 	cpuid(0x80860007, &eax, &ebx, &ecx, &edx);
diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index cc3408fc073f..695bcf73a99f 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -134,7 +134,7 @@ static int maple_cpufreq_target(struct cpufreq_policy *policy,
 	return maple_scom_switch_freq(index);
 }
 
-static unsigned int maple_cpufreq_get_speed(unsigned int cpu)
+static unsigned int maple_cpufreq_get_speed(struct cpufreq_policy *policy)
 {
 	return maple_cpu_freqs[maple_pmode_cur].frequency;
 }
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 5dd95dab580d..63ef660f5f52 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -52,7 +52,6 @@ enum {
 static int has_N44_O17_errata[NR_CPUS];
 static unsigned int stock_freq;
 static struct cpufreq_driver p4clockmod_driver;
-static unsigned int cpufreq_p4_get(unsigned int cpu);
 
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 {
@@ -215,11 +214,11 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 }
 
 
-static unsigned int cpufreq_p4_get(unsigned int cpu)
+static unsigned int cpufreq_p4_get(struct cpufreq_policy *policy)
 {
 	u32 l, h;
 
-	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
+	rdmsr_on_cpu(policy->cpu, MSR_IA32_THERM_CONTROL, &l, &h);
 
 	if (l & 0x10) {
 		l = l >> 1;
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 2a0d58959acf..f04a042d167d 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -137,8 +137,9 @@ static inline void pcc_clear_mapping(void)
 	pcch_virt_addr = NULL;
 }
 
-static unsigned int pcc_get_freq(unsigned int cpu)
+static unsigned int pcc_get_freq(struct cpufreq_policy *policy)
 {
+	unsigned int cpu = policy->cpu;
 	struct pcc_cpu *pcc_cpu_data;
 	unsigned int curr_freq;
 	unsigned int freq_limit;
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 1f49d97a70ea..a862b4347b4e 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -356,7 +356,7 @@ static int do_set_cpu_speed(struct cpufreq_policy *policy, int speed_mode)
 	return 0;
 }
 
-static unsigned int pmac_cpufreq_get_speed(unsigned int cpu)
+static unsigned int pmac_cpufreq_get_speed(struct cpufreq_policy *policy)
 {
 	return cur_freq;
 }
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 4ff86878727f..90d8dbf304dd 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -315,7 +315,7 @@ static int g5_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
 	return g5_switch_freq(index);
 }
 
-static unsigned int g5_cpufreq_get_speed(unsigned int cpu)
+static unsigned int g5_cpufreq_get_speed(struct cpufreq_policy *policy)
 {
 	return g5_cpu_freqs[g5_pmode_cur].frequency;
 }
diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index e6f24b281e3e..911ab1338b48 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -238,7 +238,7 @@ static int powernow_k6_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static unsigned int powernow_k6_get(unsigned int cpu)
+static unsigned int powernow_k6_get(struct cpufreq_policy *policy)
 {
 	unsigned int ret;
 	ret = (busfreq * powernow_k6_get_cpu_multiplier());
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index c1ae1999770a..dcf13c8a41ee 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -558,12 +558,12 @@ static int fixup_sgtc(void)
 	return sgtc;
 }
 
-static unsigned int powernow_get(unsigned int cpu)
+static unsigned int powernow_get(struct cpufreq_policy *policy)
 {
 	union msr_fidvidstatus fidvidstatus;
 	unsigned int cfid;
 
-	if (cpu)
+	if (policy->cpu)
 		return 0;
 	rdmsrl(MSR_K7_FID_VID_STATUS, fidvidstatus.val);
 	cfid = fidvidstatus.bits.CFID;
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 0b5bf135b090..6db4c14f8e21 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1137,8 +1137,9 @@ static void query_values_on_cpu(void *_err)
 	*err = query_current_values_with_pending_wait(data);
 }
 
-static unsigned int powernowk8_get(unsigned int cpu)
+static unsigned int powernowk8_get(struct cpufreq_policy *policy)
 {
+	unsigned int cpu = policy->cpu;
 	struct powernow_k8_data *data = per_cpu(powernow_data, cpu);
 	unsigned int khz = 0;
 	int err;
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 546e056e416d..d62166d83199 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -262,12 +262,12 @@ static void powernv_read_cpu_freq(void *arg)
  * firmware for CPU 'cpu'. This value is reported through the sysfs
  * file cpuinfo_cur_freq.
  */
-static unsigned int powernv_cpufreq_get(unsigned int cpu)
+static unsigned int powernv_cpufreq_get(struct cpufreq_policy *policy)
 {
 	struct powernv_smp_call_data freq_data;
 
-	smp_call_function_any(cpu_sibling_mask(cpu), powernv_read_cpu_freq,
-			&freq_data, 1);
+	smp_call_function_any(cpu_sibling_mask(policy->cpu),
+			      powernv_read_cpu_freq, &freq_data, 1);
 
 	return freq_data.freq;
 }
diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index 1d99c97defa9..76019cb855cb 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -262,7 +262,7 @@ static u32 mdrefr_dri(unsigned int freq)
 	return (interval - (cpu_is_pxa27x() ? 31 : 0)) / 32;
 }
 
-static unsigned int pxa_cpufreq_get(unsigned int cpu)
+static unsigned int pxa_cpufreq_get(struct cpufreq_policy *policy)
 {
 	return get_clk_frequency_khz(0);
 }
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index a01275900389..8a9c6f831611 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -150,7 +150,7 @@ static void __update_bus_freq(struct pxa3xx_freq_info *info)
 		cpu_relax();
 }
 
-static unsigned int pxa3xx_cpufreq_get(unsigned int cpu)
+static unsigned int pxa3xx_cpufreq_get(struct cpufreq_policy *policy)
 {
 	return pxa3xx_get_clk_frequency_khz(0);
 }
diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index d6d425773fa4..5b208536e1e9 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -87,11 +87,11 @@ static struct cpufreq_frequency_table s3c2450_freq_table[] = {
 	{ 0, 0, CPUFREQ_TABLE_END },
 };
 
-static unsigned int s3c2416_cpufreq_get_speed(unsigned int cpu)
+static unsigned int s3c2416_cpufreq_get_speed(struct cpufreq_policy *policy)
 {
 	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
 
-	if (cpu != 0)
+	if (policy->cpu != 0)
 		return 0;
 
 	/* return our pseudo-frequency when in dvs mode */
diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index 728eab77e8e0..c02a8a736866 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -200,11 +200,16 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_generic_init(policy, sa11x0_freq_table, CPUFREQ_ETERNAL);
 }
 
+static unsigned int sa1100_get_rate(struct cpufreq_policy *policy)
+{
+	return sa11x0_getspeed(0);
+}
+
 static struct cpufreq_driver sa1100_driver __refdata = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= sa1100_target,
-	.get		= sa11x0_getspeed,
+	.get		= sa1100_get_rate,
 	.init		= sa1100_cpu_init,
 	.name		= "sa1100",
 };
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index b5befc211172..aa3415a4a0ac 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -309,13 +309,18 @@ static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_generic_init(policy, sa11x0_freq_table, CPUFREQ_ETERNAL);
 }
 
+static unsigned int sa1110_get_rate(struct cpufreq_policy *policy)
+{
+	return sa11x0_getspeed(0);
+}
+
 /* sa1110_driver needs __refdata because it must remain after init registers
  * it with cpufreq_register_driver() */
 static struct cpufreq_driver sa1110_driver __refdata = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= sa1110_target,
-	.get		= sa11x0_getspeed,
+	.get		= sa1110_get_rate,
 	.init		= sa1110_cpu_init,
 	.name		= "sa1110",
 };
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index ac84e4818014..560c2aff8e03 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -38,7 +38,7 @@ static struct cpufreq_frequency_table sc520_freq_table[] = {
 	{0, 0,	CPUFREQ_TABLE_END},
 };
 
-static unsigned int sc520_freq_get_cpu_frequency(unsigned int cpu)
+static unsigned int sc520_freq_get_cpu_frequency(struct cpufreq_policy *policy)
 {
 	u8 clockspeed_reg = *cpuctl;
 
diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 86628e22b2a3..72a5d5faefc4 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -30,9 +30,9 @@
 
 static DEFINE_PER_CPU(struct clk, sh_cpuclk);
 
-static unsigned int sh_cpufreq_get(unsigned int cpu)
+static unsigned int sh_cpufreq_get(struct cpufreq_policy *policy)
 {
-	return (clk_get_rate(&per_cpu(sh_cpuclk, cpu)) + 500) / 1000;
+	return (clk_get_rate(&per_cpu(sh_cpuclk, policy->cpu)) + 500) / 1000;
 }
 
 /*
@@ -64,7 +64,7 @@ static int sh_cpufreq_target(struct cpufreq_policy *policy,
 
 	dev_dbg(dev, "requested frequency %u Hz\n", target_freq * 1000);
 
-	freqs.old	= sh_cpufreq_get(cpu);
+	freqs.old	= sh_cpufreq_get(policy);
 	freqs.new	= (freq + 500) / 1000;
 	freqs.flags	= 0;
 
diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index b73feeb666f9..4f76453fbc11 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -229,8 +229,9 @@ static unsigned long estar_to_divisor(unsigned long estar)
 	return ret;
 }
 
-static unsigned int us2e_freq_get(unsigned int cpu)
+static unsigned int us2e_freq_get(struct cpufreq_policy *policy)
 {
+	unsigned int cpu = policy->cpu;
 	cpumask_t cpus_allowed;
 	unsigned long clock_tick, estar;
 
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index 9bb42ba50efa..c619cfb5ab9e 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -76,8 +76,9 @@ static unsigned long get_current_freq(unsigned int cpu, unsigned long safari_cfg
 	return ret;
 }
 
-static unsigned int us3_freq_get(unsigned int cpu)
+static unsigned int us3_freq_get(struct cpufreq_policy *policy)
 {
+	unsigned int cpu = policy->cpu;
 	cpumask_t cpus_allowed;
 	unsigned long reg;
 	unsigned int ret;
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 7d4a31571608..eddb7fff3daf 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -318,8 +318,9 @@ static unsigned extract_clock(unsigned msr, unsigned int cpu, int failsafe)
 }
 
 /* Return the current CPU frequency in kHz */
-static unsigned int get_cur_freq(unsigned int cpu)
+static unsigned int get_cur_freq(struct cpufreq_policy *policy)
 {
+	unsigned int cpu = policy->cpu;
 	unsigned l, h;
 	unsigned clock_freq;
 
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index 37555c6b86a7..4f5dc1fad4d9 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -236,12 +236,13 @@ static void get_freq_data(void *_speed)
 	*speed = speedstep_get_frequency(speedstep_processor);
 }
 
-static unsigned int speedstep_get(unsigned int cpu)
+static unsigned int speedstep_get(struct cpufreq_policy *policy)
 {
 	unsigned int speed;
 
 	/* You're supposed to ensure CPU is online. */
-	if (smp_call_function_single(cpu, get_freq_data, &speed, 1) != 0)
+	if (smp_call_function_single(policy->cpu, get_freq_data, &speed, 1) !=
+				     0)
 		BUG();
 
 	pr_debug("detected %u kHz as current frequency\n", speed);
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 819229e824fb..bb2c963c0ddc 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -269,9 +269,9 @@ static int speedstep_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, speedstep_freqs);
 }
 
-static unsigned int speedstep_get(unsigned int cpu)
+static unsigned int speedstep_get(struct cpufreq_policy *policy)
 {
-	if (cpu)
+	if (policy->cpu)
 		return -ENODEV;
 	return speedstep_get_frequency(speedstep_processor);
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bde1e567b3a9..89b9e21c7640 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -263,7 +263,7 @@ struct cpufreq_driver {
 					       unsigned int index);
 
 	/* should be defined, if possible */
-	unsigned int	(*get)(unsigned int cpu);
+	unsigned int	(*get)(struct cpufreq_policy *policy);
 
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
@@ -601,7 +601,7 @@ extern struct freq_attr *cpufreq_generic_attr[];
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
 
-unsigned int cpufreq_generic_get(unsigned int cpu);
+unsigned int cpufreq_generic_get(struct cpufreq_policy *policy);
 int cpufreq_generic_init(struct cpufreq_policy *policy,
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
-- 
2.4.0

