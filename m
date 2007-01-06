From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/6] [-mm]: ACPI: Mark ACPI procfs interface as deprecated
Date: Sat, 06 Jan 2007 19:35:30 +0800
Message-ID: <1168083330.5619.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Mark ACPI sleep procfs interface as deprecated.
Remove two Kconfig options CONFIG_ACPI_SLEEP_PROC_SLEEP and CONFIG_ACPI_SLEEP_PROC_FS, as all the
ACPI sleep procfs interface is controlled by CONFIG_ACPI_PROCFS.

/proc/acpi/sleep is deprecated by /sys/power/state
/proc/acpi/alarm is deprecated by /sys/power/alarm
/proc/acpi/wakeup is deprecated by /sys/devices/acpi_system/.../device/sleep_state && wakeup

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig        |   19 ++++------------
 drivers/acpi/sleep/Makefile |    3 --
 drivers/acpi/sleep/proc.c   |   51 ++++++++++++++++++++++++++------------------
 3 files changed, 37 insertions(+), 36 deletions(-)

Index: linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/sleep/proc.c	2007-01-06 18:18:01.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c	2007-01-06 18:18:08.000000000 +0800
@@ -386,7 +386,7 @@ EXPORT_SYMBOL(acpi_remove_wakeup_sysfs);
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
-#ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
+#ifdef	CONFIG_ACPI_PROCFS
 static int acpi_system_sleep_seq_show(struct seq_file *seq, void *offset)
 {
 	int i;
@@ -439,7 +439,6 @@ acpi_system_write_sleep(struct file *fil
       Done:
 	return error ? error : count;
 }
-#endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
 
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 {
@@ -784,7 +783,6 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 
-#ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
 static const struct file_operations acpi_system_sleep_fops = {
 	.open = acpi_system_sleep_open_fs,
 	.read = seq_read,
@@ -792,7 +790,6 @@ static const struct file_operations acpi
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-#endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
 
 static const struct file_operations acpi_system_alarm_fops = {
 	.open = acpi_system_alarm_open_fs,
@@ -802,29 +799,16 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 
-static u32 rtc_handler(void *context)
-{
-	acpi_clear_event(ACPI_EVENT_RTC);
-	acpi_disable_event(ACPI_EVENT_RTC, 0);
-
-	return ACPI_INTERRUPT_HANDLED;
-}
-
 static int acpi_sleep_proc_init(void)
 {
 	struct proc_dir_entry *entry = NULL;
 
-	if (acpi_disabled)
-		return 0;
-
-#ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
 	/* 'sleep' [R/W] */
 	entry =
 	    create_proc_entry("sleep", S_IFREG | S_IRUGO | S_IWUSR,
 			      acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_sleep_fops;
-#endif
 
 	/* 'alarm' [R/W] */
 	entry =
@@ -840,11 +824,38 @@ static int acpi_sleep_proc_init(void)
 	if (entry)
 		entry->proc_fops = &acpi_system_wakeup_device_fops;
 
-	if(alarm_add_sysfs())
-		return -EINVAL;
+	return 0;
+}
+#else
+static int acpi_sleep_proc_init(void) {
+	return 0;
+}
+#endif
+
+static u32 rtc_handler(void *context)
+{
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int acpi_sleep_fs_init(void)
+{
+	int result;
+
+	if (acpi_disabled)
+		return 0;
+
+	result = alarm_add_sysfs();
+	if (result)
+		return result;
 
 	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
+
+	result = acpi_sleep_proc_init();
+
 	return 0;
 }
 
-late_initcall(acpi_sleep_proc_init);
+late_initcall(acpi_sleep_fs_init);
Index: linux-2.6.20-rc2-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/Kconfig	2007-01-06 17:54:30.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/Kconfig	2007-01-06 18:18:08.000000000 +0800
@@ -64,19 +64,6 @@ config ACPI_SLEEP
 	  This option is not recommended for anyone except those doing driver
 	  power management development.
 
-config ACPI_SLEEP_PROC_FS
-	bool
-	depends on ACPI_SLEEP && PROC_FS
-	default y
-
-config ACPI_SLEEP_PROC_SLEEP
-	bool "/proc/acpi/sleep (deprecated)"
-	depends on ACPI_SLEEP_PROC_FS
-	default n
-	---help---
-	  Create /proc/acpi/sleep
-	  Deprecated by /sys/power/state
-
 config ACPI_PROCFS
 	bool "Procfs interface (deprecated)"
 	depends on ACPI
@@ -87,7 +74,11 @@ config ACPI_PROCFS
 	  and this proc interface will be removed some time later,
 	  it's marked as deprecated.
 	  ( /proc/acpi/debug_layer && debug_level are deprecated by
-	    /sys/module/acpi/parameters/debug_layer && debug_level. )
+	    /sys/module/acpi/parameters/debug_layer && debug_level.
+	    /proc/acpi/sleep is deprecated by /sys/power/state.
+	    /proc/acpi/alarm is deprecated by /sys/power/alarm.
+	    /proc/acpi/wakeup is deprecated by
+	    /sys/devices/acpi_system/.../device/sleep_state && wakeup. )
 
 config ACPI_AC
 	tristate "AC Adapter"
Index: linux-2.6.20-rc2-mm1/drivers/acpi/sleep/Makefile
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/sleep/Makefile	2007-01-06 17:54:30.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/sleep/Makefile	2007-01-06 18:18:08.000000000 +0800
@@ -1,5 +1,4 @@
 obj-y					:= poweroff.o wakeup.o
-obj-$(CONFIG_ACPI_SLEEP)		+= main.o
-obj-$(CONFIG_ACPI_SLEEP_PROC_FS)	+= proc.o
+obj-$(CONFIG_ACPI_SLEEP)		+= main.o proc.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
