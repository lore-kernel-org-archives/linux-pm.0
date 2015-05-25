From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v5 2/6] ACPI: Make ACPI processor driver more extensible
Date: Mon, 25 May 2015 17:50:59 -0400
Message-ID: <1432590659-9016-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:32949 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbEYVvF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 17:51:05 -0400
Received: by ykfr66 with SMTP id r66so22903297ykf.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 14:51:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

The ACPI processor driver is currently tied too closely
to the ACPI C-states (CST), P-states (PSS) and other related
constructs for controlling CPU idle and CPU performance.

The newer ACPI specification (v5.1 onwards) introduces
alternative methods to CST and PSS. These new mechanisms
are described within each ACPI Processor object and so they
need to be scanned whenever a new Processor object is detected.
This patch introduces two new Kconfig symbols to allow for
finer configurability among the various options for controlling
CPU idle and performance states. There is no change in functionality
and these options are defaulted to enabled to maintain previous
behaviour.

The following patchwork introduces CPPC: A newer method of
controlling CPU performance. The OS is not expected to support CPPC
and PSS at runtime. So the kconfig option lets us make these two
mutually exclusive at compile time.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Kconfig            |  41 +++++++++++----
 drivers/acpi/Makefile           |   7 +--
 drivers/acpi/processor_driver.c |  85 ++++++++++++++++++++-----------
 drivers/cpufreq/Kconfig         |   2 +-
 drivers/cpufreq/Kconfig.x86     |   2 +
 include/acpi/processor.h        | 109 ++++++++++++++++++++++++++++++++++------
 6 files changed, 187 insertions(+), 59 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab2cbb5..d98d304 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -163,23 +163,42 @@ config ACPI_FAN
 config ACPI_DOCK
 	bool "Dock"
 	help
-	  This driver supports ACPI-controlled docking stations and removable
-	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
+	This driver supports ACPI-controlled docking stations and removable
+	drive bays such as the IBM Ultrabay and the Dell Module Bay.
+
+config ACPI_CST
+	bool "ACPI C states (CST) driver"
+	depends on ACPI_PROCESSOR
+	select CPU_IDLE
+	default y
+	help
+		This driver installs ACPI as the idle handler for Linux and uses
+		ACPI C2 and C3 processor states to save power on systems that
+		support it.
+
+config ACPI_PSS
+	bool "ACPI P States (PSS) driver"
+	depends on ACPI_PROCESSOR
+	select THERMAL
+	default y
+	help
+		This driver implements ACPI methods for controlling CPU performance
+		using PSS methods as described in the ACPI spec. It also enables support
+		for ACPI based performance throttling (TSS) and ACPI based thermal
+		monitoring. It is required by several flavors of cpufreq
+		performance-state drivers.
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	select THERMAL
-	select CPU_IDLE
-	depends on X86 || IA64
+	depends on X86 || IA64 || ARM64
 	default y
 	help
-	  This driver installs ACPI as the idle handler for Linux and uses
-	  ACPI C2 and C3 processor states to save power on systems that
-	  support it.  It is required by several flavors of cpufreq
-	  performance-state drivers.
+		This driver adds support for the ACPI Processor package. It is required
+		by several flavors of cpufreq performance-state, thermal, throttling and
+		idle drivers.
 
-	  To compile this driver as a module, choose M here:
-	  the module will be called processor.
+		To compile this driver as a module, choose M here:
+		the module will be called processor.
 
 config ACPI_IPMI
 	tristate "IPMI"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8a063e2..30b2bfc 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -82,9 +82,10 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 
 # processor has its own "processor." module_param namespace
-processor-y			:= processor_driver.o processor_throttling.o
-processor-y			+= processor_idle.o processor_thermal.o
-processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
+processor-y			:= processor_driver.o
+processor-$(CONFIG_ACPI_CST)	+= processor_idle.o
+processor-$(CONFIG_ACPI_PSS)	+= processor_perflib.o	\
+	processor_throttling.o processor_thermal.o
 
 obj-$(CONFIG_ACPI_PROCESSOR_AGGREGATOR) += acpi_pad.o
 
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index d9f7158..f61c09b 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -163,34 +163,23 @@ static struct notifier_block __refdata acpi_cpu_notifier = {
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
-static int __acpi_processor_start(struct acpi_device *device)
+#ifdef CONFIG_ACPI_PSS
+static int acpi_pss_init(struct acpi_processor *pr, struct acpi_device *device)
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
@@ -204,6 +193,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 			"Failed to create sysfs link 'thermal_cooling'\n");
 		goto err_thermal_unregister;
 	}
+
 	result = sysfs_create_link(&pr->cdev->device.kobj,
 				   &device->dev.kobj,
 				   "device");
@@ -213,17 +203,61 @@ static int __acpi_processor_start(struct acpi_device *device)
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
+static void acpi_pss_exit(struct acpi_processor *pr,
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
+static inline int acpi_pss_init(struct acpi_processor *pr,
+		struct acpi_device *device)
+{
+	return 0;
+}
+
+static inline void acpi_pss_exit(struct acpi_processor *pr,
+		struct acpi_device *device) {}
+#endif /* CONFIG_ACPI_PSS */
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
+	result = acpi_pss_init(pr, device);
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
@@ -252,15 +286,10 @@ static int acpi_processor_stop(struct device *dev)
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
+	acpi_pss_exit(pr, device);
+
 	return 0;
 }
 
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 659879a..2f36e2a 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -223,7 +223,7 @@ endif
 if IA64
 config IA64_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
-	depends on ACPI_PROCESSOR
+	depends on ACPI_PROCESSOR && ACPI_PSS && ACPI_CST
 	help
 	This driver adds a CPUFreq driver which utilizes the ACPI
 	Processor Performance States.
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index c59bdcb..ee285a8 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -18,6 +18,7 @@ config X86_INTEL_PSTATE
 config X86_PCC_CPUFREQ
 	tristate "Processor Clocking Control interface driver"
 	depends on ACPI && ACPI_PROCESSOR
+	depends on ACPI_PSS && ACPI_CST
 	help
 	  This driver adds support for the PCC interface.
 
@@ -32,6 +33,7 @@ config X86_PCC_CPUFREQ
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
+	depends on ACPI_PSS && ACPI_CST
 	help
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 4188a4d..659edd6 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -222,16 +222,6 @@ struct acpi_processor_errata {
 	} piix4;
 };
 
-extern int acpi_processor_preregister_performance(struct
-						  acpi_processor_performance
-						  __percpu *performance);
-
-extern int acpi_processor_register_performance(struct acpi_processor_performance
-					       *performance, unsigned int cpu);
-extern void acpi_processor_unregister_performance(struct
-						  acpi_processor_performance
-						  *performance,
-						  unsigned int cpu);
 
 /* note: this locks both the calling module and the processor module
          if a _PPC object exists, rmmod is disallowed then */
@@ -275,20 +265,55 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 
 /* in processor_perflib.c */
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ACPI_PSS
+extern int acpi_processor_preregister_performance(struct
+						  acpi_processor_performance
+						  __percpu *performance);
+
+extern int acpi_processor_register_performance(struct acpi_processor_performance
+					       *performance, unsigned int cpu);
+extern void acpi_processor_unregister_performance(struct
+						  acpi_processor_performance
+						  *performance,
+						  unsigned int cpu);
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 extern int acpi_processor_get_bios_limit(int cpu, unsigned int *limit);
 #else
+static inline int acpi_processor_preregister_performance(struct
+		acpi_processor_performance
+		__percpu *performance)
+{
+	return -ENODEV;
+
+}
+
+static inline int acpi_processor_register_performance(struct acpi_processor_performance
+		*performance, unsigned int cpu)
+{
+	return -ENODEV;
+
+}
+
+static inline void acpi_processor_unregister_performance(struct
+		acpi_processor_performance
+		*performance,
+		unsigned int cpu)
+{
+	return;
+}
+
 static inline void acpi_processor_ppc_init(void)
 {
 	return;
 }
+
 static inline void acpi_processor_ppc_exit(void)
 {
 	return;
 }
+
 static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
 								int event_flag)
 {
@@ -302,12 +327,12 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
 	}
 	return 0;
 }
+
 static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 {
 	return -ENODEV;
 }
-
-#endif				/* CONFIG_CPU_FREQ */
+#endif				/* CONFIG_ACPI_PSS */
 
 /* in processor_core.c */
 phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
@@ -318,6 +343,7 @@ int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 void acpi_processor_set_pdc(acpi_handle handle);
 
 /* in processor_throttling.c */
+#ifdef CONFIG_ACPI_PSS
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr,
@@ -330,12 +356,63 @@ extern void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
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
+			unsigned long action)
+{
+	return;
+}
+
+static inline void acpi_processor_throttling_init(void)
+{
+	return;
+}
+#endif	/* CONFIG_ACPI_PSS */
+
 /* in processor_idle.c */
+extern struct cpuidle_driver acpi_idle_driver;
+#ifdef CONFIG_ACPI_CST
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
+#endif	/* CONFIG_ACPI_CST */
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_processor_syscore_init(void);
@@ -347,8 +424,8 @@ static inline void acpi_processor_syscore_exit(void) {}
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
+#ifdef CONFIG_ACPI_PSS
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
-#ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(void);
 void acpi_thermal_cpufreq_exit(void);
 #else
@@ -360,6 +437,6 @@ static inline void acpi_thermal_cpufreq_exit(void)
 {
 	return;
 }
-#endif
+#endif	/* CONFIG_ACPI_PSS */
 
 #endif
-- 
1.9.1

