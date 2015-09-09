From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v9 4/5] CPPC: Probe for CPPC tables for each ACPI Processor object
Date: Wed,  9 Sep 2015 16:27:07 -0400
Message-ID: <69ca1142f09949fbbdaf27fe120941f93706fb9b.1441830300.git.ashwin.chaugule@linaro.org>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34802 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbbIIU10 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 16:27:26 -0400
Received: by padhy16 with SMTP id hy16so19991141pad.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 13:27:26 -0700 (PDT)
In-Reply-To: <cover.1441830300.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1441830300.git.ashwin.chaugule@linaro.org>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

For each detected ACPI Processor object (ACPI0007), search its
device handle for CPPC specific tables (i.e. _CPC) and extract
CPU specific performance capabilities.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_driver.c |  6 ++++++
 include/acpi/processor.h        | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 16d44ad..6519c22 100644
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
 
@@ -291,6 +295,8 @@ static int acpi_processor_stop(struct device *dev)
 
 	acpi_pss_perf_exit(pr, device);
 
+	acpi_cppc_processor_exit(pr);
+
 	return 0;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 2c4e7a9..43ee1bf 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -314,6 +314,20 @@ phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
+extern void acpi_cppc_processor_exit(struct acpi_processor *pr);
+#else
+static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
+{
+	return 0;
+}
+static inline void acpi_cppc_processor_exit(struct acpi_processor *pr)
+{
+	return;
+}
+#endif	/* CONFIG_ACPI_CPPC_LIB */
+
 /* in processor_pdc.c */
 void acpi_processor_set_pdc(acpi_handle handle);
 
-- 
1.9.1

