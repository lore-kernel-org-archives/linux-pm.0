From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v7 7/8] CPPC: Probe for CPPC tables for each ACPI Processor object
Date: Thu,  9 Jul 2015 14:04:23 -0400
Message-ID: <f9947988ad2e8787da4bec32b71a59a65ce45074.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35230 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbbGISEi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 14:04:38 -0400
Received: by qget71 with SMTP id t71so118787172qge.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2015 11:04:38 -0700 (PDT)
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

For each detected ACPI Processor object (ACPI0007), search its
device handle for CPPC specific tables (i.e. _CPC) and extract
CPU specific performance capabilities.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 arch/arm64/Kconfig              | 1 +
 drivers/acpi/Kconfig            | 2 +-
 drivers/acpi/processor_driver.c | 4 ++++
 include/acpi/processor.h        | 9 +++++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7796af4..feff114 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -83,6 +83,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select ACPI_CPPC_LIB if ACPI
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 54d73bb..097c02a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -198,7 +198,7 @@ config ACPI_CPPC_LIB
 config ACPI_PROCESSOR
 	tristate "Processor"
 	select CPU_IDLE if ACPI_PROCESSOR_IDLE
-	depends on X86 || IA64
+	depends on X86 || IA64 || ARM64
 	default y
 	help
 	  This driver adds support for the ACPI Processor package. It is required
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 16d44ad..ac3dd51 100644
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
index c071a92..6e53b5e 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -328,6 +328,15 @@ phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
+#else
+static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
+{
+	return 0;
+}
+#endif	/* CONFIG_ACPI_CPPC_LIB */
+
 /* in processor_pdc.c */
 void acpi_processor_set_pdc(acpi_handle handle);
 
-- 
1.9.1

