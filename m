From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: acpi-cpufreq: Drop acpi_data from struct acpi_cpufreq_data
Date: Sat, 18 Jul 2015 03:16:23 +0200
Message-ID: <6540595.sJ2Fvrp64t@vostro.rjw.lan>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58348 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753287AbbGRAtx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 20:49:53 -0400
In-Reply-To: <10273534.kyzK8rhvUz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pan Xinhui <xinhuix.pan@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 8cfcfd39000d (acpi-cpufreq: Fix an ACPI perf unregister
issue) we store both a pointer to per-CPU data of the first policy
CPU and the number of that CPU which are redundant.

Since the CPU number has to be stored anyway for the unregistration,
the pointer to the CPU's per-CPU data may be dropped and we can
access the data in question via per_cpu_ptr().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -65,7 +65,6 @@ enum {
 #define MSR_K7_HWCR_CPB_DIS	(1ULL << 25)
 
 struct acpi_cpufreq_data {
-	struct acpi_processor_performance *acpi_data;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int resume;
 	unsigned int cpu_feature;
@@ -201,7 +200,7 @@ static unsigned extract_io(u32 value, st
 	struct acpi_processor_performance *perf;
 	int i;
 
-	perf = data->acpi_data;
+	perf = per_cpu_ptr(acpi_perf_data, data->acpi_perf_cpu);
 
 	for (i = 0; i < perf->state_count; i++) {
 		if (value == perf->states[i].status)
@@ -220,7 +219,7 @@ static unsigned extract_msr(u32 msr, str
 	else
 		msr &= INTEL_MSR_RANGE;
 
-	perf = data->acpi_data;
+	perf = per_cpu_ptr(acpi_perf_data, data->acpi_perf_cpu);
 
 	cpufreq_for_each_entry(pos, data->freq_table)
 		if (msr == perf->states[pos->driver_data].status)
@@ -346,7 +345,7 @@ get_cur_val(const struct cpumask *mask,
 		break;
 	case SYSTEM_IO_CAPABLE:
 		cmd.type = SYSTEM_IO_CAPABLE;
-		perf = data->acpi_data;
+		perf = per_cpu_ptr(acpi_perf_data, data->acpi_perf_cpu);
 		cmd.addr.io.port = perf->control_register.address;
 		cmd.addr.io.bit_width = perf->control_register.bit_width;
 		break;
@@ -364,6 +363,7 @@ get_cur_val(const struct cpumask *mask,
 
 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 {
+	struct acpi_processor_performance *perf;
 	struct acpi_cpufreq_data *data;
 	struct cpufreq_policy *policy;
 	unsigned int freq;
@@ -377,10 +377,11 @@ static unsigned int get_cur_freq_on_cpu(
 
 	data = policy->driver_data;
 	cpufreq_cpu_put(policy);
-	if (unlikely(!data || !data->acpi_data || !data->freq_table))
+	if (unlikely(!data || !data->freq_table))
 		return 0;
 
-	cached_freq = data->freq_table[data->acpi_data->state].frequency;
+	perf = per_cpu_ptr(acpi_perf_data, data->acpi_perf_cpu);
+	cached_freq = data->freq_table[perf->state].frequency;
 	freq = extract_freq(get_cur_val(cpumask_of(cpu), data), data);
 	if (freq != cached_freq) {
 		/*
@@ -419,12 +420,11 @@ static int acpi_cpufreq_target(struct cp
 	unsigned int next_perf_state = 0; /* Index into perf table */
 	int result = 0;
 
-	if (unlikely(data == NULL ||
-	     data->acpi_data == NULL || data->freq_table == NULL)) {
+	if (unlikely(data == NULL || data->freq_table == NULL)) {
 		return -ENODEV;
 	}
 
-	perf = data->acpi_data;
+	perf = per_cpu_ptr(acpi_perf_data, data->acpi_perf_cpu);
 	next_perf_state = data->freq_table[index].driver_data;
 	if (perf->state == next_perf_state) {
 		if (unlikely(data->resume)) {
@@ -487,8 +487,9 @@ out:
 static unsigned long
 acpi_cpufreq_guess_freq(struct acpi_cpufreq_data *data, unsigned int cpu)
 {
-	struct acpi_processor_performance *perf = data->acpi_data;
+	struct acpi_processor_performance *perf;
 
+	perf = per_cpu_ptr(acpi_perf_data, data->acpi_perf_cpu);
 	if (cpu_khz) {
 		/* search the closest match to cpu_khz */
 		unsigned int i;
@@ -677,18 +678,17 @@ static int acpi_cpufreq_cpu_init(struct
 		goto err_free;
 	}
 
-	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
+	perf = per_cpu_ptr(acpi_perf_data, cpu);
 	data->acpi_perf_cpu = cpu;
 	policy->driver_data = data;
 
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
 		acpi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
 
-	result = acpi_processor_register_performance(data->acpi_data, cpu);
+	result = acpi_processor_register_performance(perf, cpu);
 	if (result)
 		goto err_free_mask;
 
-	perf = data->acpi_data;
 	policy->shared_type = perf->shared_type;
 
 	/*

