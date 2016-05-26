From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH v2 2/3] cpufreq: acpi-cpufreq: add resolve_freq callback
Date: Wed, 25 May 2016 19:53:00 -0700
Message-ID: <1464231181-30741-3-git-send-email-smuckle@linaro.org>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Support the new resolve_freq cpufreq callback which resolves a target
frequency to a driver-supported frequency without actually setting it.

The target frequency and resolved frequency table entry are cached so
that a subsequent fast_switch operation may avoid the frequency table
walk assuming the requested target frequency is the same.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 56 ++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7f38fb55f223..d87962eda1ed 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -66,6 +66,8 @@ enum {
 
 struct acpi_cpufreq_data {
 	struct cpufreq_frequency_table *freq_table;
+	unsigned int cached_lookup_freq;
+	struct cpufreq_frequency_table *cached_lookup_entry;
 	unsigned int resume;
 	unsigned int cpu_feature;
 	unsigned int acpi_perf_cpu;
@@ -458,26 +460,53 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	return result;
 }
 
-unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
-				      unsigned int target_freq)
+/*
+ * Find the closest frequency above target_freq.
+ *
+ * The table is sorted in the reverse order with respect to the
+ * frequency and all of the entries are valid (see the initialization).
+ */
+static inline struct cpufreq_frequency_table
+*lookup_freq(struct cpufreq_frequency_table *table, unsigned int target_freq)
 {
-	struct acpi_cpufreq_data *data = policy->driver_data;
-	struct acpi_processor_performance *perf;
-	struct cpufreq_frequency_table *entry;
-	unsigned int next_perf_state, next_freq, freq;
+	struct cpufreq_frequency_table *entry = table;
+	unsigned int freq;
 
-	/*
-	 * Find the closest frequency above target_freq.
-	 *
-	 * The table is sorted in the reverse order with respect to the
-	 * frequency and all of the entries are valid (see the initialization).
-	 */
-	entry = data->freq_table;
 	do {
 		entry++;
 		freq = entry->frequency;
 	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
 	entry--;
+
+	return entry;
+}
+
+unsigned int acpi_cpufreq_resolve_freq(struct cpufreq_policy *policy,
+				       unsigned int target_freq)
+{
+	struct acpi_cpufreq_data *data = policy->driver_data;
+	struct cpufreq_frequency_table *entry;
+
+	data->cached_lookup_freq = target_freq;
+	entry = lookup_freq(data->freq_table, target_freq);
+	data->cached_lookup_entry = entry;
+
+	return entry->frequency;
+}
+
+unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+				      unsigned int target_freq)
+{
+	struct acpi_cpufreq_data *data = policy->driver_data;
+	struct acpi_processor_performance *perf;
+	struct cpufreq_frequency_table *entry;
+	unsigned int next_perf_state, next_freq;
+
+	if (data->cached_lookup_entry &&
+	    data->cached_lookup_freq == target_freq)
+		entry = data->cached_lookup_entry;
+	else
+		entry = lookup_freq(data->freq_table, target_freq);
 	next_freq = entry->frequency;
 	next_perf_state = entry->driver_data;
 
@@ -918,6 +947,7 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= acpi_cpufreq_target,
 	.fast_switch	= acpi_cpufreq_fast_switch,
+	.resolve_freq	= acpi_cpufreq_resolve_freq,
 	.bios_limit	= acpi_processor_get_bios_limit,
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
-- 
2.4.10
