From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / processor: Do not request ACPI cpufreq module directly
Date: Mon, 28 Oct 2013 02:21 +0100
Message-ID: <2252332.6pcuA4s7xa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Function acpi_processor_load_module() used by the ACPI processor
driver can only really work if the acpi-cpufreq module is available
when acpi_processor_start() is executed which usually is not the case
for systems loading the processor driver module from an initramfs.

Moreover, that used to be a hackish workaround for module autoloading
issues, but udev loads acpi-cpufreq just fine nowadays, so that
function isn't really necessary any more.  For this reason, drop
acpi_processor_load_module() entirely.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_driver.c  |    1 -
 drivers/acpi/processor_perflib.c |   22 ----------------------
 include/acpi/processor.h         |    1 -
 3 files changed, 24 deletions(-)

Index: linux-pm/drivers/acpi/processor_driver.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_driver.c
+++ linux-pm/drivers/acpi/processor_driver.c
@@ -171,7 +171,6 @@ static int __acpi_processor_start(struct
 
 #ifdef CONFIG_CPU_FREQ
 	acpi_processor_ppc_has_changed(pr, 0);
-	acpi_processor_load_module(pr);
 #endif
 	acpi_processor_get_throttling_info(pr);
 
Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -235,28 +235,6 @@ void acpi_processor_ppc_exit(void)
 	acpi_processor_ppc_status &= ~PPC_REGISTERED;
 }
 
-/*
- * Do a quick check if the systems looks like it should use ACPI
- * cpufreq. We look at a _PCT method being available, but don't
- * do a whole lot of sanity checks.
- */
-void acpi_processor_load_module(struct acpi_processor *pr)
-{
-	static int requested;
-	acpi_status status = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
-	if (!arch_has_acpi_pdc() || requested)
-		return;
-	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
-	if (!ACPI_FAILURE(status)) {
-		printk(KERN_INFO PREFIX "Requesting acpi_cpufreq\n");
-		request_module_nowait("acpi_cpufreq");
-		requested = 1;
-	}
-	kfree(buffer.pointer);
-}
-
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 {
 	int result = 0;
Index: linux-pm/include/acpi/processor.h
===================================================================
--- linux-pm.orig/include/acpi/processor.h
+++ linux-pm/include/acpi/processor.h
@@ -225,7 +225,6 @@ struct acpi_processor_errata {
 	} piix4;
 };
 
-extern void acpi_processor_load_module(struct acpi_processor *pr);
 extern int acpi_processor_preregister_performance(struct
 						  acpi_processor_performance
 						  __percpu *performance);

