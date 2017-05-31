From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] ACPI / sleep: EC-based wakeup from suspend-to-idle on recent Dell systems
Date: Thu, 01 Jun 2017 01:27:53 +0200
Message-ID: <2944956.jYmHlBxMl3@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3454366.uzaJljlWGm@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

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
GPE as a wakeup one on the affected Dell systems.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   19 ++++++++++++++++++-
 drivers/acpi/internal.h |    2 ++
 drivers/acpi/sleep.c    |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

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
@@ -199,8 +199,10 @@ void acpi_ec_remove_query_handler(struct
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
 extern int acpi_sleep_init(void);
+bool acpi_sleep_ec_gpe_may_wakeup(void);
 #else
 static inline int acpi_sleep_init(void) { return -ENXIO; }
+static inline bool acpi_sleep_ec_gpe_may_wakeup(void) { return false; }
 #endif
 
 #ifdef CONFIG_ACPI_SLEEP
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -160,6 +160,14 @@ static int __init init_nvs_nosave(const
 	return 0;
 }
 
+static bool ec_gpe_wakeup;
+
+static int __init init_ec_gpe_wakeup(const struct dmi_system_id *d)
+{
+	ec_gpe_wakeup = true;
+	return 0;
+}
+
 static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -343,6 +351,26 @@ static struct dmi_system_id acpisleep_dm
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
 
@@ -485,6 +513,7 @@ static void acpi_pm_end(void)
 }
 #else /* !CONFIG_ACPI_SLEEP */
 #define acpi_target_sleep_state	ACPI_STATE_S0
+#define ec_gpe_wakeup		false
 static inline void acpi_sleep_dmi_check(void) {}
 #endif /* CONFIG_ACPI_SLEEP */
 
@@ -731,6 +760,11 @@ static void acpi_sleep_suspend_setup(voi
 static inline void acpi_sleep_suspend_setup(void) {}
 #endif /* !CONFIG_SUSPEND */
 
+bool acpi_sleep_ec_gpe_may_wakeup(void)
+{
+	return ec_gpe_wakeup;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static u32 saved_bm_rld;
 

