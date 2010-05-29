From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
	driver for select intel processors
Date: Sat, 29 May 2010 06:17:19 +0200
Message-ID: <201005290617.20771.trenn__18730.512870434$1275106670$gmane$org@suse.de>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<201005271053.31087.trenn@suse.de>
	<alpine.LFD.2.00.1005272131400.24823@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005272131400.24823@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: sfr@canb.auug.org.au, linux-pm@lists.linux-foundation.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 28 May 2010 03:44:16 am Len Brown wrote:
> On Thu, 27 May 2010, Thomas Renninger wrote:
> > On Thursday 27 May 2010 04:42:31 Len Brown wrote:
...
> > If this is known broken, should this already be spread through
> > linux-next?
>
> If you know somebody with a system that supports CPU hot-add
> on one of the processors supported by intel_idle, and they
> are willing to test linux-next, please have them contact me.
This was my attempt to fix it.
There still is an issue, eventually someone sees it,
but it may give a picture what is missing.

        Thomas

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index b5658cd..62cd8a3 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -445,7 +445,28 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
 			return -ENODEV;
 		}
+		/*
+		 * CPU not initialized yet, the rest of .add must not touch
+		 * (struct cpuinfo_x86) cpu_data(cpu)!
+		 * If it does, move it from .add to init_components to
+		 * get it done, once the cpu got online and set up the
+		 * first time. Also look into the CPU_ONLINE notify code.
+		 */
+		pr->flags.hotplugged_uninitialized = 1;
+	} else {
+		struct cpuinfo_x86 *c;
+		c = &cpu_data(pr->id);
+		/*
+		 * Same as above, but the driver could have been unloaded
+		 * before the cpu got onlined the first time.
+		 */
+		if (c->x86 == 0 && c->x86_model == 0 && c->x86_mask == 0) {
+			printk(KERN_INFO "CPU %d not initialized yet!\n",
+			       pr->id);
+			pr->flags.hotplugged_uninitialized = 1;
+		}
 	}
+
 	/*
 	 * On some boxes several processors use the same processor bus id.
 	 * But they are located in different scope. For example:
@@ -535,16 +556,94 @@ static void acpi_processor_notify(struct acpi_device *device, u32 event)
 	return;
 }
 
+/*
+ * Add everything that must be run on the CPU that gets initialized
+ * or that depends on cpu_data(cpu) here.
+ * Otherwise things will break in cpu hotadd case as this info is not
+ * yet available in acpi_processor_add or acpi_processor_get_info()
+ */
+
+static int __cpuinit acpi_processor_init_components(struct acpi_processor *pr)
+{
+	int result = 0;
+	struct acpi_device *device;
+
+	acpi_bus_get_device(pr->handle, &device);
+
+	printk(KERN_INFO "%s - cpu: %d\n", __func__, pr->id);
+
+#ifdef CONFIG_CPU_FREQ
+	acpi_processor_ppc_has_changed(pr, 0);
+#endif
+	acpi_processor_get_throttling_info(pr);
+	acpi_processor_get_limit_info(pr);
+
+
+	acpi_processor_power_init(pr, device);
+
+	pr->cdev = thermal_cooling_device_register("Processor", device,
+						&processor_cooling_ops);
+	if (IS_ERR(pr->cdev)) {
+		result = PTR_ERR(pr->cdev);
+		goto err_power_exit;
+	}
+
+	dev_dbg(&device->dev, "registered as cooling_device%d\n",
+		 pr->cdev->id);
+
+	result = sysfs_create_link(&device->dev.kobj,
+				   &pr->cdev->device.kobj,
+				   "thermal_cooling");
+	if (result) {
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		goto err_thermal_unregister;
+	}
+	result = sysfs_create_link(&pr->cdev->device.kobj,
+				   &device->dev.kobj,
+				   "device");
+	if (result) {
+		printk(KERN_ERR PREFIX "Create sysfs link\n");
+		goto err_remove_sysfs;
+	}
+
+	return 0;
+
+err_remove_sysfs:
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+err_thermal_unregister:
+	thermal_cooling_device_unregister(pr->cdev);
+err_power_exit:
+	acpi_processor_power_exit(pr, device);
+
+	return result;
+}
+
+
 static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 		unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
+	int ret;
 
 	if (action == CPU_ONLINE && pr) {
-		acpi_processor_ppc_has_changed(pr, 0);
-		acpi_processor_cst_has_changed(pr);
-		acpi_processor_tstate_has_changed(pr);
+		if (pr->flags.hotplugged_uninitialized) {
+			/* We only run into this if a CPU got hotplugged
+			 * and not fully initialized yet in .add
+			 * We have to do it here and only once,
+			 * because in .add cpu_data(cpu) is not set up yet
+			 */
+			acpi_processor_set_pdc(pr);
+			ret = acpi_processor_init_components(pr);
+			printk(KERN_INFO "Do initialize: %d - CPU: %d\n",
+			       ret, pr->id);
+			pr->flags.hotplugged_uninitialized = 0;
+		} else {
+			printk(KERN_INFO "already initialized: %d\n", pr->id);
+			acpi_processor_ppc_has_changed(pr, 0);
+			acpi_processor_cst_has_changed(pr);
+			acpi_processor_tstate_has_changed(pr);
+		}
 	}
 	return NOTIFY_OK;
 }
@@ -608,48 +707,14 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		goto err_remove_fs;
 	}
 
-#ifdef CONFIG_CPU_FREQ
-	acpi_processor_ppc_has_changed(pr, 0);
-#endif
-	acpi_processor_get_throttling_info(pr);
-	acpi_processor_get_limit_info(pr);
-
-
-	acpi_processor_power_init(pr, device);
-
-	pr->cdev = thermal_cooling_device_register("Processor", device,
-						&processor_cooling_ops);
-	if (IS_ERR(pr->cdev)) {
-		result = PTR_ERR(pr->cdev);
-		goto err_power_exit;
-	}
-
-	dev_dbg(&device->dev, "registered as cooling_device%d\n",
-		 pr->cdev->id);
-
-	result = sysfs_create_link(&device->dev.kobj,
-				   &pr->cdev->device.kobj,
-				   "thermal_cooling");
-	if (result) {
-		printk(KERN_ERR PREFIX "Create sysfs link\n");
-		goto err_thermal_unregister;
-	}
-	result = sysfs_create_link(&pr->cdev->device.kobj,
-				   &device->dev.kobj,
-				   "device");
-	if (result) {
-		printk(KERN_ERR PREFIX "Create sysfs link\n");
-		goto err_remove_sysfs;
+	if (!pr->flags.hotplugged_uninitialized) {
+		result = acpi_processor_init_components(pr);
+		if (result)
+			goto err_remove_fs;
 	}
 
 	return 0;
 
-err_remove_sysfs:
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-err_thermal_unregister:
-	thermal_cooling_device_unregister(pr->cdev);
-err_power_exit:
-	acpi_processor_power_exit(pr, device);
 err_remove_fs:
 	acpi_processor_remove_fs(device);
 err_free_cpumask:
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 86825dd..e7716ec 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -207,6 +207,7 @@ struct acpi_processor_flags {
 	u8 has_cst:1;
 	u8 power_setup_done:1;
 	u8 bm_rld_set:1;
+	u8 hotplugged_uninitialized:1;
 };
 
 struct acpi_processor {
