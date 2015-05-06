From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH RFC 2/5] ACPI / processor: always compile perflib if CONFIG_ACPI_PROCESSOR
Date: Wed,  6 May 2015 15:31:27 +0100
Message-ID: <1430922690-6966-3-git-send-email-sudeep.holla@arm.com>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

Similar to the  idle, thermal and throttling libraries, always compile
the perflib if CONFIG_ACPI_PROCESSOR is enabled. This not only makes
perflib alligned with other libraries but also helps in some sanity
testing of these ACPI methods even when a particular feature is not
enabled in the kernel configuration.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Makefile    |  2 +-
 include/acpi/processor.h | 29 -----------------------------
 include/linux/cpufreq.h  |  4 ++++
 3 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8a063e276530..33aef9d8b260 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -84,7 +84,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
 processor-y			+= processor_idle.o processor_thermal.o
-processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
+processor-y			+= processor_perflib.o
 
 obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 4188a4d3b597..42a7ca744ff1 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -275,39 +275,10 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 
 /* in processor_perflib.c */
 
-#ifdef CONFIG_CPU_FREQ
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 extern int acpi_processor_get_bios_limit(int cpu, unsigned int *limit);
-#else
-static inline void acpi_processor_ppc_init(void)
-{
-	return;
-}
-static inline void acpi_processor_ppc_exit(void)
-{
-	return;
-}
-static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
-								int event_flag)
-{
-	static unsigned int printout = 1;
-	if (printout) {
-		printk(KERN_WARNING
-		       "Warning: Processor Platform Limit event detected, but not handled.\n");
-		printk(KERN_WARNING
-		       "Consider compiling CPUfreq support into your kernel.\n");
-		printout = 0;
-	}
-	return 0;
-}
-static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
-{
-	return -ENODEV;
-}
-
-#endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_core.c */
 phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ee4888c1f47..ee91b295350b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -171,6 +171,10 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
 {
 	return 0;
 }
+static inline int cpufreq_update_policy(unsigned int cpu)
+{
+	return -ENODEV;
+}
 static inline void disable_cpufreq(void) { }
 #endif
 
-- 
1.9.1
