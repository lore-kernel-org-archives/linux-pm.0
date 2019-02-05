From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] tools/power/cpupower: Display boost frequency separately
Date: Tue,  5 Feb 2019 04:51:28 -0600
Message-ID: <20190205105128.9484-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: akshay.adiga@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

cpufreq driver creates sysfs file "scaling_boost_frequency" for platforms
which support boost frequency. Cpupower now prints boost frequencies
separately. For few x86 vendors who already have different way to get boost
frequency, will continue to use the existing logic. Rest of the platforms
will rely on "scaling_boost_frequency" file to display boost frequency.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 tools/power/cpupower/lib/cpufreq.c        | 19 +++++-----
 tools/power/cpupower/lib/cpufreq.h        | 16 ++++-----
 tools/power/cpupower/utils/cpufreq-info.c | 42 +++++++++++++++++------
 3 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 0c0f3e3f0..80650497f 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -333,17 +333,20 @@ void cpufreq_put_available_governors(struct cpufreq_available_governors *any)
 }
 
 
-struct cpufreq_available_frequencies
-*cpufreq_get_available_frequencies(unsigned int cpu)
+struct cpufreq_frequencies
+*cpufreq_get_frequencies(const char *type, unsigned int cpu)
 {
-	struct cpufreq_available_frequencies *first = NULL;
-	struct cpufreq_available_frequencies *current = NULL;
+	struct cpufreq_frequencies *first = NULL;
+	struct cpufreq_frequencies *current = NULL;
 	char one_value[SYSFS_PATH_MAX];
 	char linebuf[MAX_LINE_LEN];
+	char fname[MAX_LINE_LEN];
 	unsigned int pos, i;
 	unsigned int len;
 
-	len = sysfs_cpufreq_read_file(cpu, "scaling_available_frequencies",
+	snprintf(fname, MAX_LINE_LEN, "scaling_%s_frequencies", type);
+
+	len = sysfs_cpufreq_read_file(cpu, fname,
 				linebuf, sizeof(linebuf));
 	if (len == 0)
 		return NULL;
@@ -389,9 +392,9 @@ struct cpufreq_available_frequencies
 	return NULL;
 }
 
-void cpufreq_put_available_frequencies(struct cpufreq_available_frequencies
-				*any) {
-	struct cpufreq_available_frequencies *tmp, *next;
+void cpufreq_put_frequencies(struct cpufreq_frequencies *any)
+{
+	struct cpufreq_frequencies *tmp, *next;
 
 	if (!any)
 		return;
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 60beaf5ed..775738269 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -28,10 +28,10 @@ struct cpufreq_available_governors {
 	struct cpufreq_available_governors *first;
 };
 
-struct cpufreq_available_frequencies {
+struct cpufreq_frequencies {
 	unsigned long frequency;
-	struct cpufreq_available_frequencies *next;
-	struct cpufreq_available_frequencies *first;
+	struct cpufreq_frequencies *next;
+	struct cpufreq_frequencies *first;
 };
 
 
@@ -129,14 +129,14 @@ void cpufreq_put_available_governors(
  *
  * Only present on _some_ ->target() cpufreq drivers. For information purposes
  * only. Please free allocated memory by calling
- * cpufreq_put_available_frequencies after use.
+ * cpufreq_put_frequencies after use.
  */
 
-struct cpufreq_available_frequencies
-*cpufreq_get_available_frequencies(unsigned int cpu);
+struct cpufreq_frequencies
+*cpufreq_get_frequencies(const char *type, unsigned int cpu);
 
-void cpufreq_put_available_frequencies(
-		struct cpufreq_available_frequencies *first);
+void cpufreq_put_frequencies(
+		struct cpufreq_frequencies *first);
 
 
 /* determine affected CPUs
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index c3f39d512..10290b308 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -161,19 +161,12 @@ static void print_duration(unsigned long duration)
 	return;
 }
 
-/* --boost / -b */
-
-static int get_boost_mode(unsigned int cpu)
+static int get_boost_mode_x86(unsigned int cpu)
 {
 	int support, active, b_states = 0, ret, pstate_no, i;
 	/* ToDo: Make this more global */
 	unsigned long pstates[MAX_HW_PSTATES] = {0,};
 
-	if (cpupower_cpu_info.vendor != X86_VENDOR_AMD &&
-	    cpupower_cpu_info.vendor != X86_VENDOR_HYGON &&
-	    cpupower_cpu_info.vendor != X86_VENDOR_INTEL)
-		return 0;
-
 	ret = cpufreq_has_boost_support(cpu, &support, &active, &b_states);
 	if (ret) {
 		printf(_("Error while evaluating Boost Capabilities"
@@ -248,6 +241,33 @@ static int get_boost_mode(unsigned int cpu)
 	return 0;
 }
 
+/* --boost / -b */
+
+static int get_boost_mode(unsigned int cpu)
+{
+	struct cpufreq_frequencies *freqs;
+
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD ||
+	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON ||
+	    cpupower_cpu_info.vendor == X86_VENDOR_INTEL)
+		return get_boost_mode_x86(cpu);
+
+	freqs = cpufreq_get_frequencies("boost", cpu);
+	if (freqs) {
+		printf(_("  boost frequency steps: "));
+		while (freqs->next) {
+			print_speed(freqs->frequency);
+			printf(", ");
+			freqs = freqs->next;
+		}
+		print_speed(freqs->frequency);
+		printf("\n");
+		cpufreq_put_frequencies(freqs);
+	}
+
+	return 0;
+}
+
 /* --freq / -f */
 
 static int get_freq_kernel(unsigned int cpu, unsigned int human)
@@ -456,7 +476,7 @@ static int get_latency(unsigned int cpu, unsigned int human)
 
 static void debug_output_one(unsigned int cpu)
 {
-	struct cpufreq_available_frequencies *freqs;
+	struct cpufreq_frequencies *freqs;
 
 	get_driver(cpu);
 	get_related_cpus(cpu);
@@ -464,7 +484,7 @@ static void debug_output_one(unsigned int cpu)
 	get_latency(cpu, 1);
 	get_hardware_limits(cpu, 1);
 
-	freqs = cpufreq_get_available_frequencies(cpu);
+	freqs = cpufreq_get_frequencies("available", cpu);
 	if (freqs) {
 		printf(_("  available frequency steps:  "));
 		while (freqs->next) {
@@ -474,7 +494,7 @@ static void debug_output_one(unsigned int cpu)
 		}
 		print_speed(freqs->frequency);
 		printf("\n");
-		cpufreq_put_available_frequencies(freqs);
+		cpufreq_put_frequencies(freqs);
 	}
 
 	get_available_governors(cpu);
-- 
2.17.1
