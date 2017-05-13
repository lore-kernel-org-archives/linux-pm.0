From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] ACPI / sleep: Simplify suspend-to-idle event processing loop
Date: Sun, 14 May 2017 01:57:13 +0200
Message-ID: <4299064.sJpOkfBeiA@aspire.rjw.lan>
References: <2169867.RZcCZmJK9B@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2169867.RZcCZmJK9B@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Box <david.e.box@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from
suspend-to-idle) modified the core suspend-to-idle code to filter
out spurious SCI interrupts received while suspended, but it
implemented that by resuming the system partially every time an
SCI triggers wakeup, so that the SCI handler can run (and possibly
further event handlers invoked by it can run too), which requires the
"noirq" phase of device resume to be carried out.  One drawback of
that implementation is that PCI devices are put into the full-power
state (D0) during the "noirq" resume phase and they need to be put
into low-power states again in case the wakeup event turns out to be
spurious, which may cause some unpleasant power fluctuations in the
system to happen among other things.

However, that can be avoided by using the observation that it is
generally possible to call the SCI handler directly from the ACPI
suspend-to-idle ->wake callback and the processing initiated by it
can be carried out before the "noirq" phase of device resume starts,
so if the SCI interrupt turns out to be non-wakeup, the system can
go back to sleep immediately.

Implement that idea, drop the suspend-to-idle ->sync callback added
by commit eed4d47efe95 as it is not necessary any more and simplify
the suspend-to-idle event processing loop in the core code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    2 ++
 drivers/acpi/osl.c      |    9 +++++++++
 drivers/acpi/sleep.c    |   17 ++++++++---------
 include/linux/suspend.h |    1 -
 kernel/power/suspend.c  |   12 +++++-------
 5 files changed, 24 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -197,6 +197,8 @@ void acpi_ec_remove_query_handler(struct
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
+void acpi_irq_run(void);
+
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
 extern int acpi_sleep_init(void);
 #else
Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -589,6 +589,15 @@ acpi_status acpi_os_remove_interrupt_han
 	return AE_OK;
 }
 
+void acpi_irq_run(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	acpi_irq(acpi_gbl_FADT.sci_interrupt, NULL);
+	local_irq_restore(flags);
+}
+
 /*
  * Running in interpreter thread context, safe to sleep
  */
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -669,18 +669,18 @@ static int acpi_freeze_prepare(void)
 
 static void acpi_freeze_wake(void)
 {
+	if (!acpi_sci_irq_valid() ||
+	    irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
+		return;
+
 	/*
 	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
 	 * that the SCI has triggered while suspended, so cancel the wakeup in
-	 * case it has not been a wakeup event (the GPEs will be checked later).
+	 * case it has not been a wakeup event and call the SCI handler directly
+	 * to allow it to check the event sources.
 	 */
-	if (acpi_sci_irq_valid() &&
-	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
-		pm_system_cancel_wakeup();
-}
-
-static void acpi_freeze_sync(void)
-{
+	pm_system_cancel_wakeup();
+	acpi_irq_run();
 	/*
 	 * Process all pending events in case there are any wakeup ones.
 	 *
@@ -709,7 +709,6 @@ static const struct platform_freeze_ops
 	.begin = acpi_freeze_begin,
 	.prepare = acpi_freeze_prepare,
 	.wake = acpi_freeze_wake,
-	.sync = acpi_freeze_sync,
 	.restore = acpi_freeze_restore,
 	.end = acpi_freeze_end,
 };
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -190,7 +190,6 @@ struct platform_freeze_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
 	void (*wake)(void);
-	void (*sync)(void);
 	void (*restore)(void);
 	void (*end)(void);
 };
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -106,21 +106,17 @@ static void freeze_enter(void)
 
 static void s2idle_loop(void)
 {
-	do {
+	for (;;) {
 		freeze_enter();
 
 		if (freeze_ops && freeze_ops->wake)
 			freeze_ops->wake();
 
-		dpm_resume_noirq(PMSG_RESUME);
-		if (freeze_ops && freeze_ops->sync)
-			freeze_ops->sync();
-
 		if (pm_wakeup_pending())
 			break;
 
 		pm_wakeup_clear(false);
-	} while (!dpm_suspend_noirq(PMSG_SUSPEND));
+	}
 }
 
 void freeze_wake(void)
@@ -395,7 +391,7 @@ static int suspend_enter(suspend_state_t
 	 */
 	if (state == PM_SUSPEND_FREEZE) {
 		s2idle_loop();
-		goto Platform_early_resume;
+		goto Devices_resume_noirq;
 	}
 
 	error = disable_nonboot_cpus();
@@ -429,6 +425,8 @@ static int suspend_enter(suspend_state_t
 
  Platform_wake:
 	platform_resume_noirq(state);
+
+ Devices_resume_noirq:
 	dpm_resume_noirq(PMSG_RESUME);
 
  Platform_early_resume:

