From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v7 6/8] ACPI: Add weak routines for ACPI CPU Hotplug
Date: Thu,  9 Jul 2015 14:04:22 -0400
Message-ID: <bdc0952326d5d8319d3e03c28e7418b6635b3fde.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33965 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbGISEh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 14:04:37 -0400
Received: by qkcl188 with SMTP id l188so7924573qkc.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2015 11:04:37 -0700 (PDT)
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Add weak functions for architectures which do not support
hot-adding and removing CPUs which aren't detected at
bootup. (e.g. via MADT).

This helps preserve the Kconfig dependency from:

commit cbfc1bae55bb ("[ACPI] ACPI_HOTPLUG_CPU Kconfig dependency
update")

    prevent:

    HOTPLUG_CPU=y
    ACPI_PROCESSOR=y
    ACPI_HOTPLUG_CPU=n

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/acpi_processor.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 58f335c..1fbf252 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -164,6 +164,24 @@ static int acpi_processor_errata(void)
    -------------------------------------------------------------------------- */
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
+int __weak acpi_map_cpu(acpi_handle handle,
+		phys_cpuid_t physid, int *pcpu)
+{
+	return -ENODEV;
+}
+
+int __weak acpi_unmap_cpu(int cpu)
+{
+	return -ENODEV;
+}
+
+int __weak arch_register_cpu(int cpu)
+{
+	return -ENODEV;
+}
+
+void __weak arch_unregister_cpu(int cpu) {}
+
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	unsigned long long sta;
-- 
1.9.1

