From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v6 7/7] ACPI: Add weak routines for ACPI CPU Hotplug
Date: Mon, 15 Jun 2015 16:09:11 -0400
Message-ID: <70c8307fa894a2733d289a50d67da022afae69e1.1434398373.git.ashwin.chaugule@linaro.org>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1434398373.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1434398373.git.ashwin.chaugule@linaro.org>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

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

