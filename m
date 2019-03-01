From: shuah <shuah@kernel.org>
Subject: [GIT PULL] cpupower update for Linux 5.1-rc1
Date: Fri, 1 Mar 2019 09:47:47 -0700
Message-ID: <cc753578-75ba-2030-553d-f7d7d16955ef@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------39D89896C1EFD2AB028F8C2B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, shuah <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------39D89896C1EFD2AB028F8C2B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.1-rc1.

This cpupower update for Linux 5.1-rc1 consists of a patch to add
support to display boost frequency separately from Abhishek Goel.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

   Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.1-rc1

for you to fetch changes up to ae2917093fb60bdc1ed3e5757b74801420569a9a:

   tools/power/cpupower: Display boost frequency separately (2019-02-13 
09:26:17 -0700)

----------------------------------------------------------------
linux-cpupower-5.1-rc1

This cpupower update for Linux 5.1-rc1 consists of a patch to add
support to display boost frequency separately from Abhishek Goel.

----------------------------------------------------------------
Abhishek Goel (1):
       tools/power/cpupower: Display boost frequency separately

  tools/power/cpupower/lib/cpufreq.c        | 19 ++++++++------
  tools/power/cpupower/lib/cpufreq.h        | 16 ++++++------
  tools/power/cpupower/utils/cpufreq-info.c | 42 
+++++++++++++++++++++++--------
  3 files changed, 50 insertions(+), 27 deletions(-)
----------------------------------------------------------------

--------------39D89896C1EFD2AB028F8C2B
Content-Type: text/x-patch;
 name="linux-cpupower-5.1-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.1-rc1.diff"

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 0c0f3e3f0d80..80650497fb80 100644
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
index 60beaf5ed2ea..775738269cbf 100644
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
index c3f39d5128ee..10290b308797 100644
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

--------------39D89896C1EFD2AB028F8C2B--
