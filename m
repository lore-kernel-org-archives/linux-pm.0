From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v7 2/8] ACPI: Split out ACPI PSS from ACPI Processor driver
Date: Thu,  9 Jul 2015 14:04:18 -0400
Message-ID: <09d1b5cf25ed3117b9e1b8feeb40ddf801557039.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>
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
the option is auto-selected by the architecture Kconfig files.

The following patchwork introduces CPPC: A newer method of
controlling CPU performance. The OS is not expected to support
CPPC and PSS at runtime. So the kconfig option lets us make
these two mutually exclusive at compile time.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 arch/x86/Kconfig                |  1 +
 drivers/acpi/Kconfig            | 19 ++++++---
 drivers/acpi/Makefile           |  6 +--
 drivers/acpi/processor_driver.c | 86 +++++++++++++++++++++++++------------
 drivers/cpufreq/Kconfig         |  2 +-
 drivers/cpufreq/Kconfig.x86     |  2 +
 include/acpi/processor.h        | 94 +++++++++++++++++++++++++++--------------
 7 files changed, 142 insertions(+), 68 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 226d569..93d150d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -143,6 +143,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
 	select X86_FEATURE_NAMES if PROC_FS
 	select SRCU
+	select ACPI_CPU_FREQ_PSS if ACPI
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab2cbb5..00748dc 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -166,17 +166,26 @@ config ACPI_DOCK
 	  This driver supports ACPI-controlled docking stations and removable
 	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
 
+config ACPI_CPU_FREQ_PSS
+	bool
+	depends on ACPI_PROCESSOR && CPU_FREQ
+	select THERMAL
+	help
+	  This driver implements ACPI methods for controlling CPU performance
+	  using PSS methods as described in the ACPI spec. It also enables support
+	  for ACPI based performance throttling (TSS) and ACPI based thermal
+	  monitoring. It is required by several flavors of cpufreq
+	  performance-state drivers.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
-	select THERMAL
 	select CPU_IDLE
 	depends on X86 || IA64
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
index 8a063e2..62e32bd 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -82,9 +82,9 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 
 # processor has its own "processor." module_param namespace
-processor-y			:= processor_driver.o processor_throttling.o
-processor-y			+= processor_idle.o processor_thermal.o
-processor-$(CONFIG_CPU_FREQ)	+= processor_perflib.o
+processor-y			:= processor_driver.o processor_idle.o
+processor-$(CONFIG_ACPI_CPU_FREQ_PSS)	+= processor_perflib.o	\
+	processor_throttling.o processor_thermal.o
 
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
 
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 659879a..0aba0e6 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -223,7 +223,7 @@ endif
 if IA64
 config IA64_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
-	depends on ACPI_PROCESSOR
+	depends on ACPI_PROCESSOR && ACPI_CPU_FREQ_PSS
 	help
 	This driver adds a CPUFreq driver which utilizes the ACPI
 	Processor Performance States.
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index c59bdcb..e24388a 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -18,6 +18,7 @@ config X86_INTEL_PSTATE
 config X86_PCC_CPUFREQ
 	tristate "Processor Clocking Control interface driver"
 	depends on ACPI && ACPI_PROCESSOR
+	depends on ACPI_CPU_FREQ_PSS
 	help
 	  This driver adds support for the PCC interface.
 
@@ -32,6 +33,7 @@ config X86_PCC_CPUFREQ
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
+	depends on ACPI_CPU_FREQ_PSS
 	help
 	  This driver adds a CPUFreq driver which utilizes the ACPI
 	  Processor Performance States.
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 4188a4d..bedcab3 100644
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
@@ -267,28 +257,52 @@ static inline int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 	return -1;
 }
 static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
-						   *cstate)
-{
-	return;
-}
+						   *cstate) {}
 #endif
 
 /* in processor_perflib.c */
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ACPI_CPU_FREQ_PSS
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
-static inline void acpi_processor_ppc_init(void)
+static inline int acpi_processor_preregister_performance(struct
+		acpi_processor_performance
+		__percpu *performance)
 {
-	return;
+	return -ENODEV;
+
 }
-static inline void acpi_processor_ppc_exit(void)
+
+static inline int acpi_processor_register_performance(struct
+		acpi_processor_performance
+		*performance, unsigned int cpu)
 {
-	return;
+	return -ENODEV;
+
 }
+
+static inline void acpi_processor_unregister_performance(struct
+		acpi_processor_performance
+		*performance,
+		unsigned int cpu) {}
+
+static inline void acpi_processor_ppc_init(void) {}
+
+static inline void acpi_processor_ppc_exit(void) {}
+
 static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
 								int event_flag)
 {
@@ -302,12 +316,12 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
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
+#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 /* in processor_core.c */
 phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
@@ -318,6 +332,7 @@ int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 void acpi_processor_set_pdc(acpi_handle handle);
 
 /* in processor_throttling.c */
+#ifdef CONFIG_ACPI_CPU_FREQ_PSS
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr,
@@ -330,6 +345,29 @@ extern void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
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
@@ -347,19 +385,13 @@ static inline void acpi_processor_syscore_exit(void) {}
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
+#ifdef CONFIG_ACPI_CPU_FREQ_PSS
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
-#ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(void);
 void acpi_thermal_cpufreq_exit(void);
 #else
-static inline void acpi_thermal_cpufreq_init(void)
-{
-	return;
-}
-static inline void acpi_thermal_cpufreq_exit(void)
-{
-	return;
-}
-#endif
+static inline void acpi_thermal_cpufreq_init(void) {}
+static inline void acpi_thermal_cpufreq_exit(void) {}
+#endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 #endif
-- 
1.9.1

