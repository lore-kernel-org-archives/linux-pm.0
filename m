From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 02 Jan 2008 14:59:22 +0800
Message-ID: <1199257162.14632.4.camel__3711.9768946015$1199257335$gmane$org@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

ACPI defines a hardware signature. BIOS calculates the signature
according to hardware configure, if hardware changes, the signature will
change, in this case, S4 resume should fail.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/sleep/main.c |   13 +++++++++++++
 include/linux/suspend.h   |    5 +++++
 kernel/power/disk.c       |   21 ++++++++++++++++++---
 kernel/power/power.h      |    6 +++---
 kernel/power/swap.c       |   24 +++++++++++++++---------
 5 files changed, 54 insertions(+), 15 deletions(-)

Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2008-01-02 14:04:41.000000000 +0800
+++ linux/drivers/acpi/sleep/main.c	2008-01-02 14:44:06.000000000 +0800
@@ -295,6 +295,18 @@ static void acpi_hibernation_restore_cle
 	acpi_hw_enable_all_runtime_gpes();
 }
 
+static unsigned long acpi_hibernation_hardware_signature(void)
+{
+	acpi_status status;
+	struct acpi_table_facs *facs;
+
+	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+		(struct acpi_table_header **)&facs);
+	if (ACPI_FAILURE(status))
+		return 0;
+	return facs->hardware_signature;
+}
+
 static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.start = acpi_hibernation_start,
 	.pre_snapshot = acpi_hibernation_prepare,
@@ -304,6 +316,7 @@ static struct platform_hibernation_ops a
 	.leave = acpi_hibernation_leave,
 	.pre_restore = acpi_hibernation_pre_restore,
 	.restore_cleanup = acpi_hibernation_restore_cleanup,
+	.hardware_signature = acpi_hibernation_hardware_signature,
 };
 #endif				/* CONFIG_HIBERNATION */
 
Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2008-01-02 14:04:41.000000000 +0800
+++ linux/include/linux/suspend.h	2008-01-02 14:33:34.000000000 +0800
@@ -169,6 +169,10 @@ extern void mark_free_pages(struct zone 
  * @restore_cleanup: Clean up after a failing image restoration.
  *	Called right after the nonboot CPUs have been enabled and before
  *	thawing devices (runs with IRQs on).
+ *
+ * @hardware_signature: Hardware signature in the platform.
+ *	If platform hardware changes, the signature will change. Hibernation
+ *	will check if the signature before/after a suspend matches.
  */
 struct platform_hibernation_ops {
 	int (*start)(void);
@@ -179,6 +183,7 @@ struct platform_hibernation_ops {
 	void (*leave)(void);
 	int (*pre_restore)(void);
 	void (*restore_cleanup)(void);
+	unsigned long (*hardware_signature)(void);
 };
 
 #ifdef CONFIG_HIBERNATION
Index: linux/kernel/power/disk.c
===================================================================
--- linux.orig/kernel/power/disk.c	2008-01-02 14:04:41.000000000 +0800
+++ linux/kernel/power/disk.c	2008-01-02 14:43:10.000000000 +0800
@@ -139,6 +139,14 @@ static void platform_restore_cleanup(int
 		hibernation_ops->restore_cleanup();
 }
 
+static unsigned long platform_hardware_signature(int platform_mode)
+{
+	if (platform_mode && hibernation_ops &&
+	    hibernation_ops->hardware_signature)
+		return hibernation_ops->hardware_signature();
+	return 0;
+}
+
 /**
  *	create_image - freeze devices that need to be frozen with interrupts
  *	off, create the hibernation image and thaw those devices.  Control
@@ -381,6 +389,7 @@ static int prepare_processes(void)
 int hibernate(void)
 {
 	int error;
+	unsigned long hd_sig;
 
 	mutex_lock(&pm_mutex);
 	/* The snapshot device should not be opened while we're running */
@@ -389,6 +398,7 @@ int hibernate(void)
 		goto Unlock;
 	}
 
+	hd_sig = platform_hardware_signature(hibernation_mode == HIBERNATION_PLATFORM);
 	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
 	if (error)
 		goto Exit;
@@ -418,7 +428,7 @@ int hibernate(void)
 		if (hibernation_mode == HIBERNATION_PLATFORM)
 			flags |= SF_PLATFORM_MODE;
 		pr_debug("PM: writing image.\n");
-		error = swsusp_write(flags);
+		error = swsusp_write(flags, hd_sig);
 		swsusp_free();
 		if (!error)
 			power_down();
@@ -455,6 +465,7 @@ static int software_resume(void)
 {
 	int error;
 	unsigned int flags;
+	unsigned long hd_sig;
 
 	/*
 	 * name_to_dev_t() below takes a sysfs buffer mutex when sysfs
@@ -489,9 +500,13 @@ static int software_resume(void)
 	}
 
 	pr_debug("PM: Checking swsusp image.\n");
-	error = swsusp_check();
+	error = swsusp_check(&flags, &hd_sig);
 	if (error)
 		goto Unlock;
+	if (hd_sig != platform_hardware_signature(flags & SF_PLATFORM_MODE)) {
+		printk(KERN_ERR"PM: Hardware changed, can't resume.\n");
+		goto Unlock;
+	}
 
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
@@ -512,7 +527,7 @@ static int software_resume(void)
 
 	pr_debug("PM: Reading swsusp image.\n");
 
-	error = swsusp_read(&flags);
+	error = swsusp_read();
 	if (!error)
 		hibernation_restore(flags & SF_PLATFORM_MODE);
 
Index: linux/kernel/power/power.h
===================================================================
--- linux.orig/kernel/power/power.h	2008-01-02 14:04:41.000000000 +0800
+++ linux/kernel/power/power.h	2008-01-02 14:06:05.000000000 +0800
@@ -180,12 +180,12 @@ extern int swsusp_swap_in_use(void);
 #define SF_PLATFORM_MODE	1
 
 /* kernel/power/disk.c */
-extern int swsusp_check(void);
+extern int swsusp_check(unsigned int *flags_p, unsigned long *hd_sig);
 extern int swsusp_shrink_memory(void);
 extern void swsusp_free(void);
 extern int swsusp_resume(void);
-extern int swsusp_read(unsigned int *flags_p);
-extern int swsusp_write(unsigned int flags);
+extern int swsusp_read(void);
+extern int swsusp_write(unsigned int flags, unsigned long hd_sig);
 extern void swsusp_close(void);
 
 struct timeval;
Index: linux/kernel/power/swap.c
===================================================================
--- linux.orig/kernel/power/swap.c	2008-01-02 14:04:41.000000000 +0800
+++ linux/kernel/power/swap.c	2008-01-02 14:34:49.000000000 +0800
@@ -33,9 +33,10 @@ extern char resume_file[];
 #define SWSUSP_SIG	"S1SUSPEND"
 
 struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int)];
+	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) - sizeof(unsigned long)];
 	sector_t image;
 	unsigned int flags;	/* Flags to pass to the "boot" kernel */
+	unsigned long hardware_signature;
 	char	orig_sig[10];
 	char	sig[10];
 } __attribute__((packed));
@@ -139,7 +140,7 @@ static int wait_on_bio_chain(struct bio 
  * Saving part
  */
 
-static int mark_swapfiles(sector_t start, unsigned int flags)
+static int mark_swapfiles(sector_t start, unsigned int flags, unsigned long hd_sig)
 {
 	int error;
 
@@ -150,6 +151,7 @@ static int mark_swapfiles(sector_t start
 		memcpy(swsusp_header->sig,SWSUSP_SIG, 10);
 		swsusp_header->image = start;
 		swsusp_header->flags = flags;
+		swsusp_header->hardware_signature = hd_sig;
 		error = bio_write_page(swsusp_resume_block,
 					swsusp_header, NULL);
 	} else {
@@ -379,7 +381,7 @@ static int enough_swap(unsigned int nr_p
  *	correctly, we'll mark system clean, anyway.)
  */
 
-int swsusp_write(unsigned int flags)
+int swsusp_write(unsigned int flags, unsigned long hd_sig)
 {
 	struct swap_map_handle handle;
 	struct snapshot_handle snapshot;
@@ -418,7 +420,7 @@ int swsusp_write(unsigned int flags)
 		if (!error) {
 			flush_swap_writer(&handle);
 			printk("S");
-			error = mark_swapfiles(start, flags);
+			error = mark_swapfiles(start, flags, hd_sig);
 			printk("|\n");
 		}
 	}
@@ -545,18 +547,15 @@ static int load_image(struct swap_map_ha
 
 /**
  *	swsusp_read - read the hibernation image.
- *	@flags_p: flags passed by the "frozen" kernel in the image header should
- *		  be written into this memeory location
  */
 
-int swsusp_read(unsigned int *flags_p)
+int swsusp_read()
 {
 	int error;
 	struct swap_map_handle handle;
 	struct snapshot_handle snapshot;
 	struct swsusp_info *header;
 
-	*flags_p = swsusp_header->flags;
 	if (IS_ERR(resume_bdev)) {
 		pr_debug("swsusp: block device not initialised\n");
 		return PTR_ERR(resume_bdev);
@@ -585,9 +584,13 @@ int swsusp_read(unsigned int *flags_p)
 
 /**
  *      swsusp_check - Check for swsusp signature in the resume device
+ *	@flags_p: flags passed by the "frozen" kernel in the image header should
+ *		  be written into this memeory location
+ *	@hd_sig: hardware signature passed by the "frozen" kernel in the image
+ * 		 header should be written into this memeory location
  */
 
-int swsusp_check(void)
+int swsusp_check(unsigned int *flags_p, unsigned long *hd_sig)
 {
 	int error;
 
@@ -605,6 +608,9 @@ int swsusp_check(void)
 			/* Reset swap signature now */
 			error = bio_write_page(swsusp_resume_block,
 						swsusp_header, NULL);
+
+			*flags_p = swsusp_header->flags;
+			*hd_sig = swsusp_header->hardware_signature;
 		} else {
 			return -EINVAL;
 		}
