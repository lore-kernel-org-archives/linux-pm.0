From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] cpufreq: Use IS_ENABLED() instead of checking for built-in or module
Date: Tue, 26 Apr 2016 20:14:13 -0400
Message-ID: <1461716053-17722-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/cpufreq/e_powersaver.c    | 14 +++++++-------
 drivers/cpufreq/ppc_cbe_cpufreq.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 5ec87e3a97bd..cdf097b29862 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -22,7 +22,7 @@
 #include <asm/msr.h>
 #include <asm/tsc.h>
 
-#if defined CONFIG_ACPI_PROCESSOR || defined CONFIG_ACPI_PROCESSOR_MODULE
+#if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 #endif
@@ -35,7 +35,7 @@
 
 struct eps_cpu_data {
 	u32 fsb;
-#if defined CONFIG_ACPI_PROCESSOR || defined CONFIG_ACPI_PROCESSOR_MODULE
+#if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 	u32 bios_limit;
 #endif
 	struct cpufreq_frequency_table freq_table[];
@@ -48,7 +48,7 @@ static int freq_failsafe_off;
 static int voltage_failsafe_off;
 static int set_max_voltage;
 
-#if defined CONFIG_ACPI_PROCESSOR || defined CONFIG_ACPI_PROCESSOR_MODULE
+#if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 static int ignore_acpi_limit;
 
 static struct acpi_processor_performance *eps_acpi_cpu_perf;
@@ -186,7 +186,7 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	int k, step, voltage;
 	int ret;
 	int states;
-#if defined CONFIG_ACPI_PROCESSOR || defined CONFIG_ACPI_PROCESSOR_MODULE
+#if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 	unsigned int limit;
 #endif
 
@@ -286,7 +286,7 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	/* Calc FSB speed */
 	fsb = cpu_khz / current_multiplier;
 
-#if defined CONFIG_ACPI_PROCESSOR || defined CONFIG_ACPI_PROCESSOR_MODULE
+#if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 	/* Check for ACPI processor speed limit */
 	if (!ignore_acpi_limit && !eps_acpi_init()) {
 		if (!acpi_processor_get_bios_limit(policy->cpu, &limit)) {
@@ -333,7 +333,7 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 
 	/* Copy basic values */
 	centaur->fsb = fsb;
-#if defined CONFIG_ACPI_PROCESSOR || defined CONFIG_ACPI_PROCESSOR_MODULE
+#if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 	centaur->bios_limit = limit;
 #endif
 
@@ -418,7 +418,7 @@ module_param(freq_failsafe_off, int, 0644);
 MODULE_PARM_DESC(freq_failsafe_off, "Disable current vs max frequency check");
 module_param(voltage_failsafe_off, int, 0644);
 MODULE_PARM_DESC(voltage_failsafe_off, "Disable current vs max voltage check");
-#if defined CONFIG_ACPI_PROCESSOR || defined CONFIG_ACPI_PROCESSOR_MODULE
+#if IS_ENABLED(CONFIG_ACPI_PROCESSOR)
 module_param(ignore_acpi_limit, int, 0644);
 MODULE_PARM_DESC(ignore_acpi_limit, "Don't check ACPI's processor speed limit");
 #endif
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.h b/drivers/cpufreq/ppc_cbe_cpufreq.h
index b4c00a5a6a59..3eace725ccd6 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.h
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.h
@@ -17,7 +17,7 @@ int cbe_cpufreq_get_pmode(int cpu);
 
 int cbe_cpufreq_set_pmode_pmi(int cpu, unsigned int pmode);
 
-#if defined(CONFIG_CPU_FREQ_CBE_PMI) || defined(CONFIG_CPU_FREQ_CBE_PMI_MODULE)
+#if IS_ENABLED(CONFIG_CPU_FREQ_CBE_PMI)
 extern bool cbe_cpufreq_has_pmi;
 #else
 #define cbe_cpufreq_has_pmi (0)
-- 
2.5.5
