From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [RFC PATCH 1/1] ACPI: Add weak routines for ACPI CPU Hotplug
Date: Thu,  4 Jun 2015 12:32:51 -0400
Message-ID: <1433435571-6763-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33162 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbFDQdC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 12:33:02 -0400
Received: by ykfr66 with SMTP id r66so15808700ykf.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 09:33:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

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

