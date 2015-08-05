From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 7/9] CPPC: Probe for CPPC tables for each ACPI Processor object
Date: Wed,  5 Aug 2015 09:40:30 -0400
Message-ID: <59f5258b52b485aedba4d6b2f4dc2954ce767ce0.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35735 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbHENlD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 09:41:03 -0400
Received: by ykcq64 with SMTP id q64so30376761ykc.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 06:41:03 -0700 (PDT)
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

For each detected ACPI Processor object (ACPI0007), search its
device handle for CPPC specific tables (i.e. _CPC) and extract
CPU specific performance capabilities.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_driver.c | 4 ++++
 include/acpi/processor.h        | 9 +++++++++
 2 files changed, 13 insertions(+)

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
index 2c4e7a9..9b3977f 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -314,6 +314,15 @@ phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
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

