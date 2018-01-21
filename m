From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] cpufreq: add and use cpufreq_for_each_{valid_,}entry_idx
Date: Sun, 21 Jan 2018 17:11:17 +0100
Message-ID: <20180121161117.GA7073@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:51778 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeAUQMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jan 2018 11:12:09 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk

Pointer subtraction is slow and tedious. Therefore, replace all instances
where cpufreq_for_each_{valid_,}entry loops contained such substractions
with a macro which provides an index to the element currently being
iterated over.

Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Link: http://lkml.kernel.org/r/20180120020237.GM13338@ZenIV.linux.org.uk
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
index 434c49cc7330..61546ac578d6 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.txt
@@ -291,3 +291,7 @@ For example:
 		/* Do something with pos */
 		pos->frequency = ...
 	}
+
+If you need to work with the position of pos within driver_freq_table,
+do not subtract the pointers, as it is quite costly. Instead, use the
+macros cpufreq_for_each_entry_idx() and cpufreq_for_each_valid_entry_idx().
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index b6b369c22272..daf5d39e7529 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -115,10 +115,10 @@ static struct cpufreq_freqs freqs;
 static int init_div_table(void)
 {
 	struct cpufreq_frequency_table *pos, *freq_tbl = dvfs_info->freq_table;
-	unsigned int tmp, clk_div, ema_div, freq, volt_id;
+	unsigned int tmp, clk_div, ema_div, freq, volt_id, idx;
 	struct dev_pm_opp *opp;
 
-	cpufreq_for_each_entry(pos, freq_tbl) {
+	cpufreq_for_each_entry_idx(pos, freq_tbl, idx) {
 		opp = dev_pm_opp_find_freq_exact(dvfs_info->dev,
 					pos->frequency * 1000, true);
 		if (IS_ERR(opp)) {
@@ -154,8 +154,7 @@ static int init_div_table(void)
 		tmp = (clk_div | ema_div | (volt_id << P0_7_VDD_SHIFT)
 			| ((freq / FREQ_UNIT) << P0_7_FREQ_SHIFT));
 
-		__raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
-						(pos - freq_tbl));
+		__raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 * idx));
 		dev_pm_opp_put(opp);
 	}
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 3bbbf9e6960c..6d007f824ca7 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -143,10 +143,9 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
 		break;
 	}
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq = pos->frequency;
 
-		i = pos - table;
 		if ((freq < policy->min) || (freq > policy->max))
 			continue;
 		if (freq == target_freq) {
@@ -211,15 +210,16 @@ int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq)
 {
 	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+	int idx;
 
 	if (unlikely(!table)) {
 		pr_debug("%s: Unable to find frequency table\n", __func__);
 		return -ENOENT;
 	}
 
-	cpufreq_for_each_valid_entry(pos, table)
+	cpufreq_for_each_valid_entry_idx(pos, table, idx)
 		if (pos->frequency == freq)
-			return pos - table;
+			return idx;
 
 	return -EINVAL;
 }
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index c46a12df40dd..3177fa7ecb2c 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -600,7 +600,7 @@ static void longhaul_setup_voltagescaling(void)
 	/* Calculate kHz for one voltage step */
 	kHz_step = (highest_speed - min_vid_speed) / numvscales;
 
-	cpufreq_for_each_entry(freq_pos, longhaul_table) {
+	cpufreq_for_each_entry_idx(freq_pos, longhaul_table, j) {
 		speed = freq_pos->frequency;
 		if (speed > min_vid_speed)
 			pos = (speed - min_vid_speed) / kHz_step + minvid.pos;
@@ -609,7 +609,7 @@ static void longhaul_setup_voltagescaling(void)
 		freq_pos->driver_data |= mV_vrm_table[pos] << 8;
 		vid = vrm_mV_table[mV_vrm_table[pos]];
 		pr_info("f: %d kHz, index: %d, vid: %d mV\n",
-			speed, (int)(freq_pos - longhaul_table), vid.mV);
+			speed, j, vid.mV);
 	}
 
 	can_scale_voltage = 1;
diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index b257fc7d5204..75dfbd2a58ea 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -139,7 +139,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *pos;
 	const u32 *max_freqp;
 	u32 max_freq;
-	int cur_astate;
+	int cur_astate, idx;
 	struct resource res;
 	struct device_node *cpu, *dn;
 	int err = -ENODEV;
@@ -198,9 +198,9 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	pr_debug("initializing frequency table\n");
 
 	/* initialize frequency table */
-	cpufreq_for_each_entry(pos, pas_freqs) {
+	cpufreq_for_each_entry_idx(pos, pas_freqs, idx) {
 		pos->frequency = get_astate_freq(pos->driver_data) * 100000;
-		pr_debug("%d: %d\n", (int)(pos - pas_freqs), pos->frequency);
+		pr_debug("%d: %d\n", idx, pos->frequency);
 	}
 
 	cur_astate = get_cur_astate(policy->cpu);
diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index 92863e3818e5..3ea3785ddae5 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -197,10 +197,11 @@ int clk_rate_table_find(struct clk *clk,
 			unsigned long rate)
 {
 	struct cpufreq_frequency_table *pos;
+	int idx;
 
-	cpufreq_for_each_valid_entry(pos, freq_table)
+	cpufreq_for_each_valid_entry(pos, freq_table, idx)
 		if (pos->frequency == rate)
-			return pos - freq_table;
+			return idx;
 
 	return -ENOENT;
 }
diff --git a/drivers/staging/irda/drivers/sh_sir.c b/drivers/staging/irda/drivers/sh_sir.c
index fede6864c737..0d0687cc454a 100644
--- a/drivers/staging/irda/drivers/sh_sir.c
+++ b/drivers/staging/irda/drivers/sh_sir.c
@@ -226,7 +226,7 @@ static u32 sh_sir_find_sclk(struct clk *irda_clk)
 	clk_put(pclk);
 
 	/* IrDA can not set over peripheral_clk */
-	cpufreq_for_each_valid_entry(pos, freq_table) {
+	cpufreq_for_each_valid_entry_idx(pos, freq_table, index) {
 		u32 freq = pos->frequency;
 
 		/* IrDA should not over peripheral_clk */
@@ -236,7 +236,7 @@ static u32 sh_sir_find_sclk(struct clk *irda_clk)
 		tmp = freq % SCLK_BASE;
 		if (tmp < min) {
 			min = tmp;
-			index = pos - freq_table;
+			break;
 		}
 	}
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 065f3a8eb486..6ed58ca20db9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -628,6 +628,18 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 #define cpufreq_for_each_entry(pos, table)	\
 	for (pos = table; pos->frequency != CPUFREQ_TABLE_END; pos++)
 
+/*
+ * cpufreq_for_each_entry_idx -	iterate over a cpufreq_frequency_table
+ *	with index
+ * @pos:	the cpufreq_frequency_table * to use as a loop cursor.
+ * @table:	the cpufreq_frequency_table * to iterate over.
+ * @idx:	the table entry currently being processed
+ */
+
+#define cpufreq_for_each_entry_idx(pos, table, idx)	\
+	for (pos = table, idx = 0; pos->frequency != CPUFREQ_TABLE_END; \
+		pos++, idx++)
+
 /*
  * cpufreq_for_each_valid_entry -     iterate over a cpufreq_frequency_table
  *	excluding CPUFREQ_ENTRY_INVALID frequencies.
@@ -641,6 +653,21 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 			continue;					\
 		else
 
+/*
+ * cpufreq_for_each_valid_entry_idx -     iterate with index over a cpufreq
+ *	frequency_table excluding CPUFREQ_ENTRY_INVALID frequencies.
+ * @pos:	the cpufreq_frequency_table * to use as a loop cursor.
+ * @table:	the cpufreq_frequency_table * to iterate over.
+ * @idx:	the table entry currently being processed
+ */
+
+#define cpufreq_for_each_valid_entry_idx(pos, table, idx)		\
+	cpufreq_for_each_entry_idx(pos, table, idx)			\
+		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
+			continue;					\
+		else
+
+
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);
 
@@ -667,19 +694,20 @@ static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
-	struct cpufreq_frequency_table *pos, *best = table - 1;
+	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
+	int idx, best = 0;
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
 		freq = pos->frequency;
 
 		if (freq >= target_freq)
-			return pos - table;
+			return idx;
 
-		best = pos;
+		best = idx;
 	}
 
-	return best - table;
+	return best;
 }
 
 /* Find lowest freq at or above target in a table in descending order */
@@ -687,28 +715,29 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
-	struct cpufreq_frequency_table *pos, *best = table - 1;
+	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
+	int idx, best = 0;
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
-			return pos - table;
+			return idx;
 
 		if (freq > target_freq) {
-			best = pos;
+			best = idx;
 			continue;
 		}
 
 		/* No freq found above target_freq */
-		if (best == table - 1)
-			return pos - table;
+		if (best == 0)
+			return idx;
 
-		return best - table;
+		return best;
 	}
 
-	return best - table;
+	return best;
 }
 
 /* Works only on sorted freq-tables */
@@ -728,28 +757,29 @@ static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
-	struct cpufreq_frequency_table *pos, *best = table - 1;
+	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
+	int idx, best = 0;
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
-			return pos - table;
+			return idx;
 
 		if (freq < target_freq) {
-			best = pos;
+			best = idx;
 			continue;
 		}
 
 		/* No freq found below target_freq */
-		if (best == table - 1)
-			return pos - table;
+		if (best == 0)
+			return idx;
 
-		return best - table;
+		return best;
 	}
 
-	return best - table;
+	return best;
 }
 
 /* Find highest freq at or below target in a table in descending order */
@@ -757,19 +787,20 @@ static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
-	struct cpufreq_frequency_table *pos, *best = table - 1;
+	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
+	int idx, best = 0;
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
 		freq = pos->frequency;
 
 		if (freq <= target_freq)
-			return pos - table;
+			return idx;
 
-		best = pos;
+		best = idx;
 	}
 
-	return best - table;
+	return best;
 }
 
 /* Works only on sorted freq-tables */
@@ -789,32 +820,33 @@ static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
-	struct cpufreq_frequency_table *pos, *best = table - 1;
+	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
+	int idx, best = 0;
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
-			return pos - table;
+			return idx;
 
 		if (freq < target_freq) {
-			best = pos;
+			best = idx;
 			continue;
 		}
 
 		/* No freq found below target_freq */
-		if (best == table - 1)
-			return pos - table;
+		if (best == 0)
+			return idx;
 
 		/* Choose the closest freq */
-		if (target_freq - best->frequency > freq - target_freq)
-			return pos - table;
+		if (target_freq - table[best].frequency > freq - target_freq)
+			return idx;
 
-		return best - table;
+		return best;
 	}
 
-	return best - table;
+	return best;
 }
 
 /* Find closest freq to target in a table in descending order */
@@ -822,32 +854,33 @@ static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpufreq_frequency_table *table = policy->freq_table;
-	struct cpufreq_frequency_table *pos, *best = table - 1;
+	struct cpufreq_frequency_table *pos;
 	unsigned int freq;
+	int idx, best = 0;
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
 		freq = pos->frequency;
 
 		if (freq == target_freq)
-			return pos - table;
+			return idx;
 
 		if (freq > target_freq) {
-			best = pos;
+			best = idx;
 			continue;
 		}
 
 		/* No freq found above target_freq */
-		if (best == table - 1)
-			return pos - table;
+		if (best == 0)
+			return idx;
 
 		/* Choose the closest freq */
-		if (best->frequency - target_freq > target_freq - freq)
-			return pos - table;
+		if (table[best].frequency - target_freq > target_freq - freq)
+			return idx;
 
-		return best - table;
+		return best;
 	}
 
-	return best - table;
+	return best;
 }
 
 /* Works only on sorted freq-tables */
