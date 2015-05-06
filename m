From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH RFC 5/5] ACPI / processor_idle : introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
Date: Wed,  6 May 2015 15:31:30 +0100
Message-ID: <1430922690-6966-6-git-send-email-sudeep.holla@arm.com>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

ACPI 6.0 adds a new method to specify the CPU idle states(c-states)
called Low Power Idle(LPI) states. Since new architectures like ARM64
use only LPIs, introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE to
encapsulate all the code supporting the traditional C-states.

This patch will help to extend the processor_idle module to support
LPI.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/ia64/Kconfig             |  1 +
 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/acpi.h   |  2 --
 drivers/acpi/Kconfig          |  3 +++
 drivers/acpi/processor_idle.c | 57 +++++++++++++++++++++++++++++++------------
 include/acpi/processor.h      |  2 +-
 6 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 76d25b2cfbbe..6d7567efeecc 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -16,6 +16,7 @@ config IA64
 	select PCI if (!IA64_HP_SIM)
 	select ACPI if (!IA64_HP_SIM)
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
+	select ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE if ACPI
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_IDE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 226d5696e1d1..b5d58c488409 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -23,6 +23,7 @@ config X86_64
 config X86
 	def_bool y
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
+	select ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE if ACPI
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_FAST_MULTIPLIER
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 3a45668f6dc3..0077b318e3fa 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -138,8 +138,6 @@ static inline void disable_acpi(void) { }
 
 #endif /* !CONFIG_ACPI */
 
-#define ARCH_HAS_POWER_INIT	1
-
 #ifdef CONFIG_ACPI_NUMA
 extern int acpi_numa;
 extern int x86_acpi_numa_init(void);
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab2cbb51c6aa..9d6885e07040 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -48,6 +48,9 @@ config ACPI_LEGACY_TABLES_LOOKUP
 config ARCH_MIGHT_HAVE_ACPI_PDC
 	bool
 
+config ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
+	bool
+
 config ACPI_GENERIC_GSI
 	bool
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 866179651dd9..55bd1fd21a6d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -63,6 +63,12 @@ module_param(latency_factor, uint, 0644);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
+struct cpuidle_driver acpi_idle_driver = {
+	.name =		"acpi_idle",
+	.owner =	THIS_MODULE,
+};
+
+#ifdef CONFIG_ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
 static DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX],
 								acpi_cstate);
 
@@ -808,11 +814,6 @@ static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
 	acpi_idle_do_entry(cx);
 }
 
-struct cpuidle_driver acpi_idle_driver = {
-	.name =		"acpi_idle",
-	.owner =	THIS_MODULE,
-};
-
 /**
  * acpi_processor_setup_cpuidle_cx - prepares and configures CPUIDLE
  * device i.e. per-cpu data
@@ -929,6 +930,41 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 	return 0;
 }
 
+static inline void acpi_processor_cstate_first_run_checks(void)
+{
+	static int first_run;
+
+	if (first_run)
+		return;
+	dmi_check_system(processor_power_dmi_table);
+	max_cstate = acpi_processor_cstate_check(max_cstate);
+	if (max_cstate < ACPI_C_STATES_MAX)
+		pr_notice("ACPI: processor limited to max C-state %d\n",
+			  max_cstate);
+	first_run++;
+}
+#else
+
+static inline int disabled_by_idle_boot_param(void) { return 0; }
+static inline void acpi_processor_cstate_first_run_checks(void) { }
+static int acpi_processor_get_power_info(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
+					   struct cpuidle_device *dev)
+{
+	return -EINVAL;
+}
+
+static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
+{
+	return -EINVAL;
+}
+
+#endif
+
 int acpi_processor_hotplug(struct acpi_processor *pr)
 {
 	int ret = 0;
@@ -1022,20 +1058,11 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 	acpi_status status;
 	int retval;
 	struct cpuidle_device *dev;
-	static int first_run;
 
 	if (disabled_by_idle_boot_param())
 		return 0;
 
-	if (!first_run) {
-		dmi_check_system(processor_power_dmi_table);
-		max_cstate = acpi_processor_cstate_check(max_cstate);
-		if (max_cstate < ACPI_C_STATES_MAX)
-			printk(KERN_NOTICE
-			       "ACPI: processor limited to max C-state %d\n",
-			       max_cstate);
-		first_run++;
-	}
+	acpi_processor_cstate_first_run_checks();
 
 	if (acpi_gbl_FADT.cst_control && !nocst) {
 		status =
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ffe675caa766..32d417d3df04 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -244,7 +244,7 @@ extern int acpi_processor_get_performance_info(struct acpi_processor *pr);
 DECLARE_PER_CPU(struct acpi_processor *, processors);
 extern struct acpi_processor_errata errata;
 
-#ifdef ARCH_HAS_POWER_INIT
+#ifdef CONFIG_ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
 void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 					unsigned int cpu);
 int acpi_processor_ffh_cstate_probe(unsigned int cpu,
-- 
1.9.1

