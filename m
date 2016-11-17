From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] PM / sleep / ACPI: Use the ACPI_FADT_LOW_POWER_S0 flag
Date: Thu, 17 Nov 2016 03:28:53 +0100
Message-ID: <1707436.1pT24M6iWQ@vostro.rjw.lan>
References: <9316960.49SRRJV8RJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <9316960.49SRRJV8RJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the ACPI system sleep support setup code to select
suspend-to-idle as the default system sleep state if the
ACPI_FADT_LOW_POWER_S0 flag is set in the FADT and the
default sleep state was not selected from the kernel command
line.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/power/states.txt |    4 +++-
 drivers/acpi/sleep.c           |    8 ++++++++
 include/linux/suspend.h        |    2 ++
 kernel/power/suspend.c         |    4 ++--
 4 files changed, 15 insertions(+), 3 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -194,6 +194,8 @@ struct platform_freeze_ops {
 };
 
 #ifdef CONFIG_SUSPEND
+extern suspend_state_t mem_sleep_default;
+
 /**
  * suspend_set_ops - set platform dependent suspend operations
  * @ops: The new suspend operations to set.
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -691,6 +691,14 @@ static void acpi_sleep_suspend_setup(voi
 		if (acpi_sleep_state_supported(i))
 			sleep_states[i] = 1;
 
+	/*
+	 * Use suspend-to-idle by default if ACPI_FADT_LOW_POWER_S0 is set and
+	 * the default suspend mode was not selected from the command line.
+	 */
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0 &&
+	    mem_sleep_default > PM_SUSPEND_MEM)
+		mem_sleep_default = PM_SUSPEND_FREEZE;
+
 	suspend_set_ops(old_suspend_ordering ?
 		&acpi_suspend_ops_old : &acpi_suspend_ops);
 	freeze_set_ops(&acpi_freeze_ops);
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -44,7 +44,7 @@ const char * const mem_sleep_labels[] =
 const char *mem_sleep_states[PM_SUSPEND_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_FREEZE;
-static suspend_state_t mem_sleep_default = PM_SUSPEND_MEM;
+suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
 
 unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
@@ -163,7 +163,7 @@ void suspend_set_ops(const struct platfo
 	}
 	if (valid_state(PM_SUSPEND_MEM)) {
 		mem_sleep_states[PM_SUSPEND_MEM] = mem_sleep_labels[PM_SUSPEND_MEM];
-		if (mem_sleep_default == PM_SUSPEND_MEM)
+		if (mem_sleep_default >= PM_SUSPEND_MEM)
 			mem_sleep_current = PM_SUSPEND_MEM;
 	}
 
Index: linux-pm/Documentation/power/states.txt
===================================================================
--- linux-pm.orig/Documentation/power/states.txt
+++ linux-pm/Documentation/power/states.txt
@@ -35,7 +35,9 @@ only one way to cause the system to go i
 The default suspend mode (ie. the one to be used without writing anything into
 /sys/power/mem_sleep) is either "deep" (if Suspend-To-RAM is supported) or
 "s2idle", but it can be overridden by the value of the "mem_sleep_default"
-parameter in the kernel command line.
+parameter in the kernel command line.  On some ACPI-based systems, depending on
+the information in the FADT, the default may be "s2idle" even if Suspend-To-RAM
+is supported.
 
 The properties of all of the sleep states are described below.
 

