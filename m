From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/6] [-mm]: ACPI: duplicate ACPI "info" attribute in sysfs
Date: Sat, 06 Jan 2007 19:35:33 +0800
Message-ID: <1168083333.5619.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Add "info" attribute to indicates ACPICA version.
/proc/acpi/info is deprecated by /sys/firmware/acpi/info.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig  |    3 ++-
 drivers/acpi/system.c |   48 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

Index: linux-2.6.20-rc2-mm1/drivers/acpi/system.c
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/system.c	2007-01-06 13:51:39.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/system.c	2007-01-06 14:49:45.000000000 +0800
@@ -29,6 +29,7 @@
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
+#include <acpi/acpi_bus.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("acpi_system")
@@ -42,8 +43,32 @@ ACPI_MODULE_NAME("acpi_system")
 extern struct fadt_descriptor acpi_fadt;
 
 /* --------------------------------------------------------------------------
+                              FS Interface (/sys)
+   -------------------------------------------------------------------------- */
+extern struct subsystem acpi_subsys;
+
+static ssize_t info_show(struct subsystem *subsys, char *buf)
+{
+	return 	sprintf(buf, "version:                 %x\n", ACPI_CA_VERSION);
+}
+
+static struct subsys_attribute info_attr = {
+	.attr	= {
+		.name = __stringify(info),
+		.mode = 0444,
+	},
+	.show = info_show,
+	.store = NULL,
+};
+
+static int acpi_system_info_add_sysfs(void)
+{
+	return sysfs_create_file(&acpi_subsys.kset.kobj, &info_attr.attr);
+}
+/* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 
 static int acpi_system_read_info(struct seq_file *seq, void *offset)
 {
@@ -63,6 +88,7 @@ static const struct file_operations acpi
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
 
 static ssize_t acpi_system_read_dsdt(struct file *, char __user *, size_t,
 				     loff_t *);
@@ -118,16 +144,13 @@ acpi_system_read_fadt(struct file *file,
 	return res;
 }
 
-static int __init acpi_system_init(void)
+static int  acpi_system_procfs_init(void)
 {
 	struct proc_dir_entry *entry;
 	int error = 0;
 	char *name;
 
-
-	if (acpi_disabled)
-		return 0;
-
+#ifdef CONFIG_ACPI_PROCFS
 	/* 'info' [R] */
 	name = ACPI_SYSTEM_FILE_INFO;
 	entry = create_proc_entry(name, S_IRUGO, acpi_root_dir);
@@ -136,6 +159,7 @@ static int __init acpi_system_init(void)
 	else {
 		entry->proc_fops = &acpi_system_info_ops;
 	}
+#endif
 
 	/* 'dsdt' [R] */
 	name = ACPI_SYSTEM_FILE_DSDT;
@@ -165,4 +189,18 @@ static int __init acpi_system_init(void)
 	goto Done;
 }
 
+static int __init acpi_system_init(void) {
+	int result;
+
+	if (acpi_disabled)
+		return 0;
+
+	result = acpi_system_info_add_sysfs();
+	if(result)
+		return result;
+
+	result = acpi_system_procfs_init();
+
+	return result;
+}
 subsys_initcall(acpi_system_init);
Index: linux-2.6.20-rc2-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/Kconfig	2007-01-06 14:37:10.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/Kconfig	2007-01-06 14:46:24.000000000 +0800
@@ -78,7 +78,8 @@ config ACPI_PROCFS
 	    /proc/acpi/sleep is deprecated by /sys/power/state.
 	    /proc/acpi/alarm is deprecated by /sys/power/alarm.
 	    /proc/acpi/wakeup is deprecated by
-	    /sys/devices/acpi_system/.../device/sleep_state && wakeup. )
+	    /sys/devices/acpi_system/.../device/sleep_state && wakeup.
+	    /proc/acpi/info is deprecated by /sys/firmware/acpi/info. )
 
 config ACPI_AC
 	tristate "AC Adapter"
