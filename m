From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 6/9] ACPI: Add weak routines for ACPI CPU Hotplug
Date: Wed,  5 Aug 2015 09:40:29 -0400
Message-ID: <61551c17311eff68368a5a8b3115cf5e4017fc06.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36359 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbbHENlB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 09:41:01 -0400
Received: by ykeo23 with SMTP id o23so35160527yke.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 06:41:01 -0700 (PDT)
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

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
index 92a5f73..e1e0285 100644
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

