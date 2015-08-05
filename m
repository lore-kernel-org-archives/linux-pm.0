From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 3/9] ACPI: Decouple ACPI idle and ACPI processor drivers
Date: Wed,  5 Aug 2015 09:40:26 -0400
Message-ID: <c8c4eb78a6c4ac3a3cc0039d18f04d56920320e7.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch introduces a new Kconfig symbol, ACPI_PROCESSOR_IDLE,
which is auto selected by architectures which support the ACPI
based C states for CPU Idle management.

The processor_idle driver in its present form contains declarations
specific to X86 and IA64. Since there are no reasonable defaults
for other architectures e.g. ARM64, the driver is selected only for
X86 or IA64.

This helps in decoupling the ACPI processor_driver from the ACPI
processor_idle driver which is useful for the upcoming alternative
patchwork for controlling CPU Performance (CPPC) and CPU Idle (LPI).

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Kconfig     |  6 +++++-
 drivers/acpi/Makefile    |  3 ++-
 include/acpi/processor.h | 26 ++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d6e2a86..54e9729 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -193,10 +193,14 @@ config ACPI_CPU_FREQ_PSS
 	bool
 	select THERMAL
 
+config ACPI_PROCESSOR_IDLE
+	bool
+	select CPU_IDLE
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || IA64
-	select CPU_IDLE
+	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS
 	default y
 	help
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 7e97aef..3ea59ae 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -80,7 +80,8 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 
 # processor has its own "processor." module_param namespace
-processor-y			:= processor_driver.o processor_idle.o
+processor-y			:= processor_driver.o
+processor-$(CONFIG_ACPI_PROCESSOR_IDLE) += processor_idle.o
 processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_throttling.o	\
 	processor_thermal.o
 processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b6c9178..2c4e7a9 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -355,13 +355,35 @@ static inline void acpi_processor_throttling_init(void) {}
 #endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 /* in processor_idle.c */
+extern struct cpuidle_driver acpi_idle_driver;
+#ifdef CONFIG_ACPI_PROCESSOR_IDLE
 int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_cst_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
-extern struct cpuidle_driver acpi_idle_driver;
+#else
+static inline int acpi_processor_power_init(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_processor_power_exit(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_processor_cst_has_changed(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_processor_hotplug(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
-#ifdef CONFIG_PM_SLEEP
+#if defined(CONFIG_PM_SLEEP) & defined(CONFIG_ACPI_PROCESSOR_IDLE)
 void acpi_processor_syscore_init(void);
 void acpi_processor_syscore_exit(void);
 #else
-- 
1.9.1

