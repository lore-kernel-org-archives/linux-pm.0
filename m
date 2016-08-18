From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 08/11] acpi: cppc: Add prefix cppc to cpudata structure name
Date: Thu, 18 Aug 2016 15:36:49 -0700
Message-ID: <1471559812-19967-9-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50678 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754942AbcHSBQu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Aug 2016 21:16:50 -0400
In-Reply-To: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org
Cc: x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, srinivas.pandruvada@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com

Since struct cpudata is defined in a header file, add prefix cppc_ to
make it not a generic name. Otherwise it causes compile issue in locally
define structure with the same name.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/cppc_acpi.c       |  4 ++--
 drivers/cpufreq/cppc_cpufreq.c | 14 +++++++-------
 include/acpi/cppc_acpi.h       |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 939fb5c..5ca517d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -276,13 +276,13 @@ end:
  *
  *	Return: 0 for success or negative value for err.
  */
-int acpi_get_psd_map(struct cpudata **all_cpu_data)
+int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
 {
 	int count_target;
 	int retval = 0;
 	unsigned int i, j;
 	cpumask_var_t covered_cpus;
-	struct cpudata *pr, *match_pr;
+	struct cppc_cpudata *pr, *match_pr;
 	struct acpi_psd_package *pdomain;
 	struct acpi_psd_package *match_pdomain;
 	struct cpc_desc *cpc_ptr, *match_cpc_ptr;
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8882b8e..b1b3549 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -30,13 +30,13 @@
  * performance capabilities, desired performance level
  * requested etc.
  */
-static struct cpudata **all_cpu_data;
+static struct cppc_cpudata **all_cpu_data;
 
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 		unsigned int target_freq,
 		unsigned int relation)
 {
-	struct cpudata *cpu;
+	struct cppc_cpudata *cpu;
 	struct cpufreq_freqs freqs;
 	int ret = 0;
 
@@ -66,7 +66,7 @@ static int cppc_verify_policy(struct cpufreq_policy *policy)
 static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
 	int cpu_num = policy->cpu;
-	struct cpudata *cpu = all_cpu_data[cpu_num];
+	struct cppc_cpudata *cpu = all_cpu_data[cpu_num];
 	int ret;
 
 	cpu->perf_ctrls.desired_perf = cpu->perf_caps.lowest_perf;
@@ -79,7 +79,7 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cpudata *cpu;
+	struct cppc_cpudata *cpu;
 	unsigned int cpu_num = policy->cpu;
 	int ret = 0;
 
@@ -134,7 +134,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 static int __init cppc_cpufreq_init(void)
 {
 	int i, ret = 0;
-	struct cpudata *cpu;
+	struct cppc_cpudata *cpu;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -144,7 +144,7 @@ static int __init cppc_cpufreq_init(void)
 		return -ENOMEM;
 
 	for_each_possible_cpu(i) {
-		all_cpu_data[i] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
+		all_cpu_data[i] = kzalloc(sizeof(struct cppc_cpudata), GFP_KERNEL);
 		if (!all_cpu_data[i])
 			goto out;
 
@@ -175,7 +175,7 @@ out:
 
 static void __exit cppc_cpufreq_exit(void)
 {
-	struct cpudata *cpu;
+	struct cppc_cpudata *cpu;
 	int i;
 
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 284965c..b7816c2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -114,7 +114,7 @@ struct cppc_perf_fb_ctrs {
 };
 
 /* Per CPU container for runtime CPPC management. */
-struct cpudata {
+struct cppc_cpudata {
 	int cpu;
 	struct cppc_perf_caps perf_caps;
 	struct cppc_perf_ctrls perf_ctrls;
@@ -127,6 +127,6 @@ struct cpudata {
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
-extern int acpi_get_psd_map(struct cpudata **);
+extern int acpi_get_psd_map(struct cppc_cpudata **);
 
 #endif /* _CPPC_ACPI_H*/
-- 
2.7.4

