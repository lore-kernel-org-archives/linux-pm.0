From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v5 5/6] CPPC: Probe for CPPC tables for each ACPI Processor object
Date: Mon, 25 May 2015 17:51:51 -0400
Message-ID: <1432590711-9149-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34048 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbbEYVv7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 17:51:59 -0400
Received: by ykfl8 with SMTP id l8so12591756ykf.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 14:51:58 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

For each detected ACPI Processor object (ACPI0007), search its
device handle for CPPC specific tables (i.e. _CPC) and extract
CPU specific performance capabilites.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/processor_driver.c | 4 ++++
 include/acpi/processor.h        | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index f61c09b..8554496 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -245,6 +245,10 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (pr->flags.need_hotplug_init)
 		return 0;
 
+	result = acpi_cppc_processor_probe(pr);
+	if (result)
+		return -ENODEV;
+
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 659edd6..0b51117 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -339,6 +339,15 @@ phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
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

