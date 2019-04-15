From: Mohan Kumar <mohankumar718@gmail.com>
Subject: [RESEND] drivers/cpufreq/acpi-cpufreq.c: This fixes the following  checkpatch warning
Date: Mon, 15 Apr 2019 14:03:58 +0300
Message-ID: <1555326238-3612-1-git-send-email-mohankumar718@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

WARNING: Prefer using '"%s...", __func__' to using function's name, in a
string

Switch hardcoded function name with a reference to __func__ making the
code more maintainable

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c72258a..73bb2aa 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -366,7 +366,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
 
 	val = drv_read(data, mask);
 
-	pr_debug("get_cur_val = %u\n", val);
+	pr_debug("%s = %u\n", __func__, val);
 
 	return val;
 }
@@ -378,7 +378,7 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	unsigned int freq;
 	unsigned int cached_freq;
 
-	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
+	pr_debug("%s (%d)\n", __func__, cpu);
 
 	policy = cpufreq_cpu_get_raw(cpu);
 	if (unlikely(!policy))
@@ -458,8 +458,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	if (acpi_pstate_strict) {
 		if (!check_freqs(policy, mask,
 				 policy->freq_table[index].frequency)) {
-			pr_debug("acpi_cpufreq_target failed (%d)\n",
-				policy->cpu);
+			pr_debug("%s (%d)\n", __func__, policy->cpu);
 			result = -EAGAIN;
 		}
 	}
@@ -573,7 +572,7 @@ static int cpufreq_boost_down_prep(unsigned int cpu)
 static int __init acpi_cpufreq_early_init(void)
 {
 	unsigned int i;
-	pr_debug("acpi_cpufreq_early_init\n");
+	pr_debug("%s\n", __func__);
 
 	acpi_perf_data = alloc_percpu(struct acpi_processor_performance);
 	if (!acpi_perf_data) {
@@ -657,7 +656,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	static int blacklisted;
 #endif
 
-	pr_debug("acpi_cpufreq_cpu_init\n");
+	pr_debug("%s\n", __func__);
 
 #ifdef CONFIG_SMP
 	if (blacklisted)
@@ -856,7 +855,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 
-	pr_debug("acpi_cpufreq_cpu_exit\n");
+	pr_debug("%s\n", __func__);
 
 	policy->fast_switch_possible = false;
 	policy->driver_data = NULL;
@@ -881,7 +880,7 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 
-	pr_debug("acpi_cpufreq_resume\n");
+	pr_debug("%s\n", __func__);
 
 	data->resume = 1;
 
@@ -954,7 +953,7 @@ static int __init acpi_cpufreq_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
-	pr_debug("acpi_cpufreq_init\n");
+	pr_debug("%s\n", __func__);
 
 	ret = acpi_cpufreq_early_init();
 	if (ret)
@@ -991,7 +990,7 @@ static int __init acpi_cpufreq_init(void)
 
 static void __exit acpi_cpufreq_exit(void)
 {
-	pr_debug("acpi_cpufreq_exit\n");
+	pr_debug("%s\n", __func__);
 
 	acpi_cpufreq_boost_exit();
 
-- 
2.7.4
