From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/5] ACPI / sleep: EC-based wakeup from suspend-to-idle on Dell systems
Date: Wed, 26 Apr 2017 23:24:12 +0200
Message-ID: <3060629.nj3VExRueE@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some recent Dell laptops, including the XPS13 model numbers 9360 and
9365, cannot be woken up from suspend-to-idle by pressing the power
button which is unexpected and makes that feature hardly usable on
those systems.  However, on the 9365 ACPI S3 (suspend-to-RAM) is not
expected to be used at all (these systems ship with Windows 10 using
Modern Standby which never exercises the ACPI S3 path) and
suspend-to-idle is the only viable system suspend mechanism in there.

The reason why the power button wakeup from suspend-to-idle doesn't
work on those systems is because their power button events are
signaled by the EC (Embedded Controller), whose GPE (General Purpose
Event) line is disabled during suspend-to-idle transitions in Linux.
That is done on purpose, because in general the EC tends to generate
tons of events for various reasons (battery and thermal updates and
similar, for example) and all of them would kick the CPUs out of deep
idle states while in suspend-to-idle, which would not be desirable.

Of course, on the Dell systems in question the EC GPE must be enabled
during suspend-to-idle transitions for the button press events to
be signaled while suspended at all.  Fortunately, there is a way to
tell the EC to stop generating the non-wakeup events, which is by
using the _DSM object under the so called micro-PEP (uPEP) device
provided to support Modern Standby in Windows 10.

The expected way to use it is to invoke function 0 from it on system
initialization, functions 3 and 5 during suspend transitions and
functions 4 and 6 during resume transitions (to reverse the actions
carried out by the former).  In particular, function 5 from the uPEP
device _DSM causes the EC to become less verbose (so to speak) on the
affected systems and then its GPE can be enabled as a wakeup source
(then, on resume, function 6 switches it back to the "working state"
mode).

In support of the affected Dell systems, implement the uPEP device
handling as described and allow the EC to generate system wakeup
events if that device is present and behaves as expected.  Enable
that for Dell only, as there are other systems out there in which
the uPEP device is exposed in the ACPI tables and its _DSM appears
to be functional, but it actually isn't, whereas Dell is committed
to supporting it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   19 +++++++-
 drivers/acpi/internal.h |    2 
 drivers/acpi/sleep.c    |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

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
@@ -160,6 +160,10 @@ static int __init init_nvs_nosave(const
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+static int __init init_upep_device(const struct dmi_system_id *d);
+#endif
+
 static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -343,6 +347,15 @@ static struct dmi_system_id acpisleep_dm
 		DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
 		},
 	},
+#ifdef CONFIG_SUSPEND
+	{
+	 .callback = init_upep_device,
+	 .ident = "All Dell systems",
+	 .matches = {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+#endif
 	{},
 };
 
@@ -649,6 +662,94 @@ static const struct platform_suspend_ops
 	.recover = acpi_pm_finish,
 };
 
+/*
+ * The micro-PEP (uPEP) device object is exposed in ACPI tables on systems
+ * supporting Windows 10 with Modern Standby.  The _DSM object under it, if
+ * present, can be used to indicate to the platform that the OS is transitioning
+ * into a low-power state in which certain types of activity are not desirable.
+ */
+static acpi_handle upep_device_handle;
+
+#define ACPI_S2IDLE_SCREEN_OFF	3
+#define ACPI_S2IDLE_SCREEN_ON	4
+#define ACPI_S2IDLE_IR_ENTRY	5
+#define ACPI_S2IDLE_IR_EXIT	6
+
+#define ACPI_S2IDLE_DSM_MASK	((1 << ACPI_S2IDLE_IR_ENTRY) | (1 << ACPI_S2IDLE_IR_EXIT))
+
+static char upep_dsm_func_mask;
+
+/* uPEP device _DSM UUID: c4eb40a0-6cd2-11e2-bcfd-0800200c9a66 */
+static const u8 upep_dsm_uuid[16] = {
+	0xa0, 0x40, 0xeb, 0xc4, 0xd2, 0x6c, 0xe2, 0x11,
+	0xbc, 0xfd, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66
+};
+
+static void acpi_sleep_call_upep_dsm(unsigned int func)
+{
+	union acpi_object *out_obj;
+
+	if (!(upep_dsm_func_mask & (1 << func)))
+		return;
+
+	out_obj = acpi_evaluate_dsm(upep_device_handle, upep_dsm_uuid, 1, func,
+				    NULL);
+	ACPI_FREE(out_obj);
+
+	acpi_handle_debug(upep_device_handle, "_DSM function %u evaluation %s\n",
+			  func, out_obj ? "successful" : "failed");
+}
+
+static int upep_device_attach(struct acpi_device *adev,
+			      const struct acpi_device_id *not_used)
+{
+	union acpi_object *out_obj;
+
+	if (upep_device_handle)
+		return 0;
+
+	/* Check if the _DSM is present and as expected. */
+	out_obj = acpi_evaluate_dsm(adev->handle, upep_dsm_uuid, 1, 0, NULL);
+	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
+		char bitmask = *(char *)out_obj->buffer.pointer;
+
+		if (bitmask & ACPI_S2IDLE_DSM_MASK) {
+			upep_dsm_func_mask = bitmask;
+			upep_device_handle = adev->handle;
+		}
+
+		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
+				  bitmask);
+	} else {
+		acpi_handle_debug(adev->handle,
+				  "_DSM function 0 evaluation failed\n");
+	}
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static const struct acpi_device_id upep_device_ids[] = {
+	{"INT33A1", },
+	{"PNP0D80", },
+	{"", },
+};
+
+static struct acpi_scan_handler upep_handler = {
+	.ids = upep_device_ids,
+	.attach = upep_device_attach,
+};
+
+static int __init init_upep_device(const struct dmi_system_id *d)
+{
+	acpi_scan_add_handler(&upep_handler);
+	return 0;
+}
+
+bool acpi_sleep_ec_gpe_may_wakeup(void)
+{
+	return !!upep_device_handle;
+}
+
 static int acpi_freeze_begin(void)
 {
 	acpi_scan_lock_acquire();
@@ -657,6 +758,8 @@ static int acpi_freeze_begin(void)
 
 static int acpi_freeze_prepare(void)
 {
+	acpi_sleep_call_upep_dsm(ACPI_S2IDLE_SCREEN_OFF);
+	acpi_sleep_call_upep_dsm(ACPI_S2IDLE_IR_ENTRY);
 	acpi_enable_wakeup_devices(ACPI_STATE_S0);
 	acpi_enable_all_wakeup_gpes();
 	acpi_enable_all_runtime_gpes();
@@ -698,6 +801,8 @@ static void acpi_freeze_restore(void)
 		disable_irq_wake(acpi_sci_irq);
 
 	acpi_enable_all_runtime_gpes();
+	acpi_sleep_call_upep_dsm(ACPI_S2IDLE_IR_EXIT);
+	acpi_sleep_call_upep_dsm(ACPI_S2IDLE_SCREEN_ON);
 }
 
 static void acpi_freeze_end(void)
@@ -729,6 +834,11 @@ static void acpi_sleep_suspend_setup(voi
 
 #else /* !CONFIG_SUSPEND */
 static inline void acpi_sleep_suspend_setup(void) {}
+
+bool acpi_sleep_ec_gpe_may_wakeup(void)
+{
+	return false;
+}
 #endif /* !CONFIG_SUSPEND */
 
 #ifdef CONFIG_PM_SLEEP

