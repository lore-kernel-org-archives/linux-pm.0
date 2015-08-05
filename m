From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 2/9] ACPI: Split out ACPI PSS from ACPI Processor driver
Date: Wed,  5 Aug 2015 09:40:25 -0400
Message-ID: <08d1cd753556918b702fa4f97246071d6aebdd3a.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

The ACPI processor driver is currently tied too closely
to the ACPI P-states (PSS) and other related constructs
for controlling CPU performance.

The newer ACPI specification (v5.1 onwards) introduces
alternative methods to PSS. These new mechanisms are
described within each ACPI Processor object and so they
need to be scanned whenever a new Processor object is detected.
This patch introduces a new Kconfig symbol to allow for
finer configurability among the two options for controlling
performance states. There is no change in functionality and
the option is auto-selected by the architectures which support it.

The following patchwork introduces CPPC: A newer method of
controlling CPU performance. The OS is not expected to support
CPPC and PSS at runtime. So the kconfig option lets us make
these two mutually exclusive at compile time.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Kconfig            | 15 ++++---
 drivers/acpi/Makefile           |  5 ++-
 drivers/acpi/processor_driver.c | 86 +++++++++++++++++++++++++++--------------
 include/acpi/processor.h        | 28 +++++++++++++-
 4 files changed, 96 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 114cf48..d6e2a86 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -189,17 +189,20 @@ config ACPI_DOCK
 	  This driver supports ACPI-controlled docking stations and removable
 	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
 
+config ACPI_CPU_FREQ_PSS
+	bool
+	select THERMAL
+
 config ACPI_PROCESSOR
 	tristate "Processor"
-	select THERMAL
-	select CPU_IDLE
 	depends on X86 || IA64
+	select CPU_IDLE
+	select ACPI_CPU_FREQ_PSS
 	default y
 	help
-	  This driver installs ACPI as the idle handler for Linux and uses
-	  ACPI C2 and C3 processor states to save power on systems that
-	  support it.  It is required by several flavors of cpufreq
-	  performance-state drivers.
+	  This driver adds support for the ACPI Processor package. It is required
+	  by several flavors of cpufreq performance-state, thermal, throttling and
+	  idle drivers.
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called processor.
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8321430..7e97aef 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -80,8 +80,9 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 
 # processor has its own "processor." module_param namespace
-processor-y			:= processor_driver.o processor_throttling.o
-processor-y			+= processor_idle.o processor_thermal.o
+processor-y			:= processor_driver.o processor_idle.o
+processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_throttling.o	\
+	processor_thermal.o
 processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
 
 obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index d9f7158..16d44ad 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -163,34 +163,24 @@ static struct notifier_block __refdata acpi_cpu_notifier = {
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
-static int __acpi_processor_start(struct acpi_device *device)
+#ifdef CONFIG_ACPI_CPU_FREQ_PSS
+static int acpi_pss_perf_init(struct acpi_processor *pr,
+		struct acpi_device *device)
 {
-	struct acpi_processor *pr = acpi_driver_data(device);
-	acpi_status status;
 	int result = 0;
 
-	if (!pr)
-		return -ENODEV;
-
-	if (pr->flags.need_hotplug_init)
-		return 0;
-
-#ifdef CONFIG_CPU_FREQ
 	acpi_processor_ppc_has_changed(pr, 0);
-#endif
+
 	acpi_processor_get_throttling_info(pr);
 
 	if (pr->flags.throttling)
 		pr->flags.limit = 1;
 
-	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
-		acpi_processor_power_init(pr);
-
 	pr->cdev = thermal_cooling_device_register("Processor", device,
 						   &processor_cooling_ops);
 	if (IS_ERR(pr->cdev)) {
 		result = PTR_ERR(pr->cdev);
-		goto err_power_exit;
+		return result;
 	}
 
 	dev_dbg(&device->dev, "registered as cooling_device%d\n",
@@ -204,6 +194,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 			"Failed to create sysfs link 'thermal_cooling'\n");
 		goto err_thermal_unregister;
 	}
+
 	result = sysfs_create_link(&pr->cdev->device.kobj,
 				   &device->dev.kobj,
 				   "device");
@@ -213,17 +204,61 @@ static int __acpi_processor_start(struct acpi_device *device)
 		goto err_remove_sysfs_thermal;
 	}
 
-	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-					     acpi_processor_notify, device);
-	if (ACPI_SUCCESS(status))
-		return 0;
-
 	sysfs_remove_link(&pr->cdev->device.kobj, "device");
  err_remove_sysfs_thermal:
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
  err_thermal_unregister:
 	thermal_cooling_device_unregister(pr->cdev);
- err_power_exit:
+
+	return result;
+}
+
+static void acpi_pss_perf_exit(struct acpi_processor *pr,
+		struct acpi_device *device)
+{
+	if (pr->cdev) {
+		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+		thermal_cooling_device_unregister(pr->cdev);
+		pr->cdev = NULL;
+	}
+}
+#else
+static inline int acpi_pss_perf_init(struct acpi_processor *pr,
+		struct acpi_device *device)
+{
+	return 0;
+}
+
+static inline void acpi_pss_perf_exit(struct acpi_processor *pr,
+		struct acpi_device *device) {}
+#endif /* CONFIG_ACPI_CPU_FREQ_PSS */
+
+static int __acpi_processor_start(struct acpi_device *device)
+{
+	struct acpi_processor *pr = acpi_driver_data(device);
+	acpi_status status;
+	int result = 0;
+
+	if (!pr)
+		return -ENODEV;
+
+	if (pr->flags.need_hotplug_init)
+		return 0;
+
+	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
+		acpi_processor_power_init(pr);
+
+	result = acpi_pss_perf_init(pr, device);
+	if (result)
+		goto err_power_exit;
+
+	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					     acpi_processor_notify, device);
+	if (ACPI_SUCCESS(status))
+		return 0;
+
+err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;
 }
@@ -252,15 +287,10 @@ static int acpi_processor_stop(struct device *dev)
 	pr = acpi_driver_data(device);
 	if (!pr)
 		return 0;
-
 	acpi_processor_power_exit(pr);
 
-	if (pr->cdev) {
-		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-		sysfs_remove_link(&pr->cdev->device.kobj, "device");
-		thermal_cooling_device_unregister(pr->cdev);
-		pr->cdev = NULL;
-	}
+	acpi_pss_perf_exit(pr, device);
+
 	return 0;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 4188a4d..b6c9178 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -318,6 +318,7 @@ int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 void acpi_processor_set_pdc(acpi_handle handle);
 
 /* in processor_throttling.c */
+#ifdef CONFIG_ACPI_CPU_FREQ_PSS
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr,
@@ -330,6 +331,29 @@ extern void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
 			unsigned long action);
 extern const struct file_operations acpi_processor_throttling_fops;
 extern void acpi_processor_throttling_init(void);
+#else
+static inline int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
+{
+	return 0;
+}
+
+static inline int acpi_processor_get_throttling_info(struct acpi_processor *pr)
+{
+	return -ENODEV;
+}
+
+static inline int acpi_processor_set_throttling(struct acpi_processor *pr,
+					 int state, bool force)
+{
+	return -ENODEV;
+}
+
+static inline void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
+			unsigned long action) {}
+
+static inline void acpi_processor_throttling_init(void) {}
+#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
+
 /* in processor_idle.c */
 int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
@@ -348,7 +372,7 @@ static inline void acpi_processor_syscore_exit(void) {}
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
-#ifdef CONFIG_CPU_FREQ
+#if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
 void acpi_thermal_cpufreq_init(void);
 void acpi_thermal_cpufreq_exit(void);
 #else
@@ -360,6 +384,6 @@ static inline void acpi_thermal_cpufreq_exit(void)
 {
 	return;
 }
-#endif
+#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 #endif
-- 
1.9.1

