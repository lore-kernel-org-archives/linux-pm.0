From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v6 5/7] CPPC: Probe for CPPC tables for each ACPI Processor object
Date: Mon, 15 Jun 2015 16:09:09 -0400
Message-ID: <8e45cf0167dadb81e10e4136e33b578b0f6090a6.1434398373.git.ashwin.chaugule@linaro.org>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1434398373.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1434398373.git.ashwin.chaugule@linaro.org>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

For each detected ACPI Processor object (ACPI0007), search its
device handle for CPPC specific tables (i.e. _CPC) and extract
CPU specific performance capabilities.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/Kconfig            | 2 +-
 drivers/acpi/processor_driver.c | 4 ++++
 include/acpi/processor.h        | 9 +++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 937c7f0..a600192 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -209,7 +209,7 @@ config ACPI_CPPC
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || IA64
+	depends on X86 || IA64 || ARM64
 	default y
 	help
 	  This driver adds support for the ACPI Processor package. It is required
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 64aa638..ea9c93b 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -246,6 +246,10 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (pr->flags.need_hotplug_init)
 		return 0;
 
+	result = acpi_cppc_processor_probe(pr);
+	if (result)
+		return -ENODEV;
+
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b76d05b..c48684b 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -328,6 +328,15 @@ phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
+#ifdef CONFIG_ACPI_CPPC
+extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
+#else
+static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
+{
+	return 0;
+}
+#endif	/* CONFIG_ACPI_CPPC */
+
 /* in processor_pdc.c */
 void acpi_processor_set_pdc(acpi_handle handle);
 
-- 
1.9.1

