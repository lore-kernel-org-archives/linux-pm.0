From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle on recent Dell systems
Date: Mon, 19 Jun 2017 23:53:31 +0200
Message-ID: <2026371.DVJN39QYJi@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan> <3689795.xuIczRHZsl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52363 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752138AbdFSWAy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2017 18:00:54 -0400
In-Reply-To: <3689795.xuIczRHZsl@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some recent Dell laptops, including the XPS13 model numbers 9360 and
9365, cannot be woken up from suspend-to-idle by pressing the power
button which is unexpected and makes that feature less usable on
those systems.  Moreover, on the 9365 ACPI S3 (suspend-to-RAM) is
not expected to be used at all (the OS these systems ship with never
exercises the ACPI S3 path) and suspend-to-idle is the only viable
system suspend mechanism in there.

The reason why the power button wakeup from suspend-to-idle doesn't
work on those systems is because their power button events are
signaled by the EC (Embedded Controller), whose GPE (General Purpose
Event) line is disabled during suspend-to-idle transitions in Linux.
That is done on purpose, because in general the EC tends to generate
tons of events for various reasons (battery and thermal updates and
similar, for example) and all of them would kick the CPUs out of deep
idle states while in suspend-to-idle, which effectively would defeat
its purpose.

Of course, on the Dell systems in question the EC GPE must be enabled
during suspend-to-idle transitions for the button press events to
be signaled while suspended at all.  For this reason, add a DMI
switch to the ACPI system suspend infrastructure to treat the EC
GPE as a wakeup one on the affected Dell systems.  In case the
users would prefer not to do that after all, add a new kernel
command line switch, acpi_sleep=no_ec_wakeup, to disable that new
behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Added acpi_sleep=no_ec_wakeup to prevent EC events from waking up
          the system from s2idle on systems where they do that by default.

---
 Documentation/admin-guide/kernel-parameters.txt |    6 ++-
 arch/x86/kernel/acpi/sleep.c                    |    2 +
 drivers/acpi/ec.c                               |   19 ++++++++++
 drivers/acpi/internal.h                         |    2 +
 drivers/acpi/sleep.c                            |   43 ++++++++++++++++++++++++
 include/linux/acpi.h                            |    1 
 6 files changed, 71 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/suspend.h>
 #include <asm/io.h>
 
 #include "internal.h"
@@ -1493,6 +1494,16 @@ static int acpi_ec_setup(struct acpi_ec
 	acpi_handle_info(ec->handle,
 			 "GPE=0x%lx, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
 			 ec->gpe, ec->command_addr, ec->data_addr);
+
+	/*
+	 * On some platforms the EC GPE is used for waking up the system from
+	 * suspend-to-idle, so mark it as a wakeup one.
+	 *
+	 * This can be done unconditionally, as the setting does not matter
+	 * until acpi_set_gpe_wake_mask() is called for the GPE.
+	 */
+	acpi_mark_gpe_for_wake(NULL, ec->gpe);
+
 	return ret;
 }
 
@@ -1835,8 +1846,11 @@ static int acpi_ec_suspend(struct device
 	struct acpi_ec *ec =
 		acpi_driver_data(to_acpi_device(dev));
 
-	if (ec_freeze_events)
+	if (!pm_suspend_via_firmware() && acpi_sleep_ec_gpe_may_wakeup())
+		acpi_set_gpe_wake_mask(NULL, ec->gpe, ACPI_GPE_ENABLE);
+	else if (ec_freeze_events)
 		acpi_ec_disable_event(ec);
+
 	return 0;
 }
 
@@ -1846,6 +1860,9 @@ static int acpi_ec_resume(struct device
 		acpi_driver_data(to_acpi_device(dev));
 
 	acpi_ec_enable_event(ec);
+	if (!pm_resume_via_firmware() && acpi_sleep_ec_gpe_may_wakeup())
+		acpi_set_gpe_wake_mask(NULL, ec->gpe, ACPI_GPE_DISABLE);
+
 	return 0;
 }
 #endif
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -199,9 +199,11 @@ void acpi_ec_remove_query_handler(struct
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
 extern bool acpi_s2idle_wakeup(void);
+extern bool acpi_sleep_ec_gpe_may_wakeup(void);
 extern int acpi_sleep_init(void);
 #else
 static inline bool acpi_s2idle_wakeup(void) { return false; }
+static inline bool acpi_sleep_ec_gpe_may_wakeup(void) { return false; }
 static inline int acpi_sleep_init(void) { return -ENXIO; }
 #endif
 
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -160,6 +160,23 @@ static int __init init_nvs_nosave(const
 	return 0;
 }
 
+/* If set, it is allowed to use the EC GPE to wake up the system. */
+static bool ec_gpe_wakeup_allowed __initdata = true;
+
+void __init acpi_disable_ec_gpe_wakeup(void)
+{
+	ec_gpe_wakeup_allowed = false;
+}
+
+/* If set, the EC GPE will be configured to wake up the system. */
+static bool ec_gpe_wakeup;
+
+static int __init init_ec_gpe_wakeup(const struct dmi_system_id *d)
+{
+	ec_gpe_wakeup = ec_gpe_wakeup_allowed;
+	return 0;
+}
+
 static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -343,6 +360,26 @@ static struct dmi_system_id acpisleep_dm
 		DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
 		},
 	},
+	/*
+	 * Enable the EC to wake up the system from suspend-to-idle to allow
+	 * power button events to it wake up.
+	 */
+	{
+	 .callback = init_ec_gpe_wakeup,
+	 .ident = "Dell XPS 13 9360",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
+		},
+	},
+	{
+	 .callback = init_ec_gpe_wakeup,
+	 .ident = "Dell XPS 13 9365",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9365"),
+		},
+	},
 	{},
 };
 
@@ -485,6 +522,7 @@ static void acpi_pm_end(void)
 }
 #else /* !CONFIG_ACPI_SLEEP */
 #define acpi_target_sleep_state	ACPI_STATE_S0
+#define ec_gpe_wakeup		false
 static inline void acpi_sleep_dmi_check(void) {}
 #endif /* CONFIG_ACPI_SLEEP */
 
@@ -740,6 +778,11 @@ bool acpi_s2idle_wakeup(void)
 	return s2idle_wakeup;
 }
 
+bool acpi_sleep_ec_gpe_may_wakeup(void)
+{
+	return ec_gpe_wakeup;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static u32 saved_bm_rld;
 
Index: linux-pm/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-pm/arch/x86/kernel/acpi/sleep.c
@@ -137,6 +137,8 @@ static int __init acpi_sleep_setup(char
 			acpi_nvs_nosave_s3();
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+		if (strncmp(str, "no_ec_wakeup", 12) == 0)
+			acpi_disable_ec_gpe_wakeup();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -448,6 +448,7 @@ void __init acpi_no_s4_hw_signature(void
 void __init acpi_old_suspend_ordering(void);
 void __init acpi_nvs_nosave(void);
 void __init acpi_nvs_nosave_s3(void);
+void __init acpi_disable_ec_gpe_wakeup(void);
 #endif /* CONFIG_PM_SLEEP */
 
 struct acpi_osc_context {
Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
@@ -223,7 +223,8 @@
 
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
-				  old_ordering, nonvs, sci_force_enable }
+				  old_ordering, nonvs, sci_force_enable,
+				  no_ec_wakeup }
 			See Documentation/power/video.txt for information on
 			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
@@ -239,6 +240,9 @@
 			sci_force_enable causes the kernel to set SCI_EN directly
 			on resume from S1/S3 (which is against the ACPI spec,
 			but some broken systems don't work without it).
+			no_ec_wakeup prevents the EC GPE from being configured
+			to wake up the system on platforms where that is done by
+			default.
 
 	acpi_use_timer_override [HW,ACPI]
 			Use timer override. For some broken Nvidia NF5 boards
