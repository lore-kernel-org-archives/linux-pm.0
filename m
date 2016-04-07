From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 1/2] cpufreq: acpi: Remove freq_table from acpi_cpufreq_data
Date: Thu,  7 Apr 2016 14:06:57 +0530
Message-ID: <31560235fc686a26bb5d975059d480fd9e645b17.1460018171.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36603 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380AbcDGIhG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 04:37:06 -0400
Received: by mail-pa0-f47.google.com with SMTP id bx7so34640811pad.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 01:37:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The freq-table is stored in struct cpufreq_policy also and there is
absolutely no need of keeping a copy of its reference in struct
acpi_cpufreq_data. Drop it.

Also policy->freq_table can't be NULL in the target() callback, remove
the useless check as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rebased over latest changes.

 drivers/cpufreq/acpi-cpufreq.c | 63 +++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7f38fb55f223..4fe67775555a 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -65,7 +65,6 @@ enum {
 #define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
 
 struct acpi_cpufreq_data {
-	struct cpufreq_frequency_table *freq_table;
 	unsigned int resume;
 	unsigned int cpu_feature;
 	unsigned int acpi_perf_cpu;
@@ -200,8 +199,9 @@ static int check_amd_hwpstate_cpu(unsigned int cpuid)
 	return cpu_has(cpu, X86_FEATURE_HW_PSTATE);
 }
 
-static unsigned extract_io(u32 value, struct acpi_cpufreq_data *data)
+static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
 {
+	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
 	int i;
 
@@ -209,13 +209,14 @@ static unsigned extract_io(u32 value, struct acpi_cpufreq_data *data)
 
 	for (i = 0; i < perf->state_count; i++) {
 		if (value == perf->states[i].status)
-			return data->freq_table[i].frequency;
+			return policy->freq_table[i].frequency;
 	}
 	return 0;
 }
 
-static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
+static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 {
+	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct cpufreq_frequency_table *pos;
 	struct acpi_processor_performance *perf;
 
@@ -226,20 +227,22 @@ static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
 
 	perf = to_perf_data(data);
 
-	cpufreq_for_each_entry(pos, data->freq_table)
+	cpufreq_for_each_entry(pos, policy->freq_table)
 		if (msr == perf->states[pos->driver_data].status)
 			return pos->frequency;
-	return data->freq_table[0].frequency;
+	return policy->freq_table[0].frequency;
 }
 
-static unsigned extract_freq(u32 val, struct acpi_cpufreq_data *data)
+static unsigned extract_freq(struct cpufreq_policy *policy, u32 val)
 {
+	struct acpi_cpufreq_data *data = policy->driver_data;
+
 	switch (data->cpu_feature) {
 	case SYSTEM_INTEL_MSR_CAPABLE:
 	case SYSTEM_AMD_MSR_CAPABLE:
-		return extract_msr(val, data);
+		return extract_msr(policy, val);
 	case SYSTEM_IO_CAPABLE:
-		return extract_io(val, data);
+		return extract_io(policy, val);
 	default:
 		return 0;
 	}
@@ -374,11 +377,11 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 		return 0;
 
 	data = policy->driver_data;
-	if (unlikely(!data || !data->freq_table))
+	if (unlikely(!data || !policy->freq_table))
 		return 0;
 
-	cached_freq = data->freq_table[to_perf_data(data)->state].frequency;
-	freq = extract_freq(get_cur_val(cpumask_of(cpu), data), data);
+	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;
+	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
 	if (freq != cached_freq) {
 		/*
 		 * The dreaded BIOS frequency change behind our back.
@@ -392,14 +395,15 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	return freq;
 }
 
-static unsigned int check_freqs(const struct cpumask *mask, unsigned int freq,
-				struct acpi_cpufreq_data *data)
+static unsigned int check_freqs(struct cpufreq_policy *policy,
+				const struct cpumask *mask, unsigned int freq)
 {
+	struct acpi_cpufreq_data *data = policy->driver_data;
 	unsigned int cur_freq;
 	unsigned int i;
 
 	for (i = 0; i < 100; i++) {
-		cur_freq = extract_freq(get_cur_val(mask, data), data);
+		cur_freq = extract_freq(policy, get_cur_val(mask, data));
 		if (cur_freq == freq)
 			return 1;
 		udelay(10);
@@ -416,12 +420,12 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int next_perf_state = 0; /* Index into perf table */
 	int result = 0;
 
-	if (unlikely(data == NULL || data->freq_table == NULL)) {
+	if (unlikely(!data)) {
 		return -ENODEV;
 	}
 
 	perf = to_perf_data(data);
-	next_perf_state = data->freq_table[index].driver_data;
+	next_perf_state = policy->freq_table[index].driver_data;
 	if (perf->state == next_perf_state) {
 		if (unlikely(data->resume)) {
 			pr_debug("Called after resume, resetting to P%d\n",
@@ -444,8 +448,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	drv_write(data, mask, perf->states[next_perf_state].control);
 
 	if (acpi_pstate_strict) {
-		if (!check_freqs(mask, data->freq_table[index].frequency,
-					data)) {
+		if (!check_freqs(policy, mask,
+				 policy->freq_table[index].frequency)) {
 			pr_debug("acpi_cpufreq_target failed (%d)\n",
 				policy->cpu);
 			result = -EAGAIN;
@@ -472,7 +476,7 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	 * The table is sorted in the reverse order with respect to the
 	 * frequency and all of the entries are valid (see the initialization).
 	 */
-	entry = data->freq_table;
+	entry = policy->freq_table;
 	do {
 		entry++;
 		freq = entry->frequency;
@@ -668,6 +672,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int result = 0;
 	struct cpuinfo_x86 *c = &cpu_data(policy->cpu);
 	struct acpi_processor_performance *perf;
+	struct cpufreq_frequency_table *freq_table;
 #ifdef CONFIG_SMP
 	static int blacklisted;
 #endif
@@ -779,9 +784,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto err_unreg;
 	}
 
-	data->freq_table = kzalloc(sizeof(*data->freq_table) *
+	freq_table = kzalloc(sizeof(*freq_table) *
 		    (perf->state_count+1), GFP_KERNEL);
-	if (!data->freq_table) {
+	if (!freq_table) {
 		result = -ENOMEM;
 		goto err_unreg;
 	}
@@ -806,18 +811,18 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	/* table init */
 	for (i = 0; i < perf->state_count; i++) {
 		if (i > 0 && perf->states[i].core_frequency >=
-		    data->freq_table[valid_states-1].frequency / 1000)
+		    freq_table[valid_states-1].frequency / 1000)
 			continue;
 
-		data->freq_table[valid_states].driver_data = i;
-		data->freq_table[valid_states].frequency =
+		freq_table[valid_states].driver_data = i;
+		freq_table[valid_states].frequency =
 		    perf->states[i].core_frequency * 1000;
 		valid_states++;
 	}
-	data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
+	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
 	perf->state = 0;
 
-	result = cpufreq_table_validate_and_show(policy, data->freq_table);
+	result = cpufreq_table_validate_and_show(policy, freq_table);
 	if (result)
 		goto err_freqfree;
 
@@ -864,7 +869,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return result;
 
 err_freqfree:
-	kfree(data->freq_table);
+	kfree(freq_table);
 err_unreg:
 	acpi_processor_unregister_performance(cpu);
 err_free_mask:
@@ -887,7 +892,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		policy->driver_data = NULL;
 		acpi_processor_unregister_performance(data->acpi_perf_cpu);
 		free_cpumask_var(data->freqdomain_cpus);
-		kfree(data->freq_table);
+		kfree(policy->freq_table);
 		kfree(data);
 	}
 
-- 
2.7.1.410.g6faf27b

