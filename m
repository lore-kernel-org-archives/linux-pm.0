From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] [v2] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Sun, 27 Sep 2015 09:23:10 +0800
Message-ID: <1443316990-8265-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10253 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697AbbI0BUN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Sep 2015 21:20:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: rui.zhang@intel.com, jiang.liu@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

For ACPI compatible system, SCI(ACPI System Control
Interrupt) is used to wake system up from suspend-to-idle.
Once CPU is woken up by SCI, interrupt handler will
firstly checks if current interrupt is legal to wake up
the whole system, thus irq_pm_check_wakeup is invoked
to validate the irq number. However, before suspend-to-idle,
acpi_gbl_FADT.sci_interrupt is marked rather than actual
irq number in acpi_freeze_prepare, this might lead to unable
to wake up the system.

This patch fixes this problem by marking the irq number
return by acpi_gsi_to_irq as IRQD_WAKEUP_STATE, rather than
marking the acpi_gbl_FADT.sci_interrupt. Meanwhile this patch
fixes the same problems inside acpi_os_remove_interrupt_handler
and acpi_os_wait_events_complete respectively.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2:
 - 1.Define a global acpi_inuse_irq variable, store irq in it
   and access it directly from acpi_freeze_prepare(), and it
   doesn't have to depend on CONFIG_SUSPEND as it is just the
   IRQ number actually used by ACPI.
   2.Also fix the same problems inside acpi_os_remove_interrupt_handler,
   acpi_os_wait_events_complete.
---
 drivers/acpi/osl.c   |  9 ++++++++-
 drivers/acpi/sleep.c | 10 ++++++++--
 include/linux/acpi.h |  3 +++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 739a4a6..97507fc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -81,6 +81,7 @@ static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
 static struct workqueue_struct *kacpi_hotplug_wq;
 static bool acpi_os_initialized;
+unsigned int acpi_inuse_irq = INVALID_ACPI_IRQ;
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -856,6 +857,7 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
 	}
+	acpi_inuse_irq = irq;
 
 	return AE_OK;
 }
@@ -865,6 +867,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
 	if (irq != acpi_gbl_FADT.sci_interrupt)
 		return AE_BAD_PARAMETER;
 
+	if (!IS_INVALID_ACPI_IRQ(acpi_inuse_irq))
+		irq = acpi_inuse_irq;
+
 	free_irq(irq, acpi_irq);
 	acpi_irq_handler = NULL;
 
@@ -1176,12 +1181,14 @@ EXPORT_SYMBOL(acpi_os_execute);
 
 void acpi_os_wait_events_complete(void)
 {
+	unsigned int irq = IS_INVALID_ACPI_IRQ(acpi_inuse_irq) ?
+		acpi_gbl_FADT.sci_interrupt : acpi_inuse_irq;
 	/*
 	 * Make sure the GPE handler or the fixed event handler is not used
 	 * on another CPU after removal.
 	 */
 	if (acpi_irq_handler)
-		synchronize_hardirq(acpi_gbl_FADT.sci_interrupt);
+		synchronize_hardirq(irq);
 	flush_workqueue(kacpid_wq);
 	flush_workqueue(kacpi_notify_wq);
 }
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2f0d4db..a7a467b 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -629,17 +629,23 @@ static int acpi_freeze_begin(void)
 
 static int acpi_freeze_prepare(void)
 {
+	unsigned int irq = IS_INVALID_ACPI_IRQ(acpi_inuse_irq) ?
+		acpi_gbl_FADT.sci_interrupt : acpi_inuse_irq;
+
 	acpi_enable_wakeup_devices(ACPI_STATE_S0);
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
-	enable_irq_wake(acpi_gbl_FADT.sci_interrupt);
+	enable_irq_wake(irq);
 	return 0;
 }
 
 static void acpi_freeze_restore(void)
 {
+	unsigned int irq = IS_INVALID_ACPI_IRQ(acpi_inuse_irq) ?
+		acpi_gbl_FADT.sci_interrupt : acpi_inuse_irq;
+
 	acpi_disable_wakeup_devices(ACPI_STATE_S0);
-	disable_irq_wake(acpi_gbl_FADT.sci_interrupt);
+	disable_irq_wake(irq);
 	acpi_enable_all_runtime_gpes();
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7235c48..df8ed19 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -193,6 +193,9 @@ int acpi_ioapic_registered(acpi_handle handle, u32 gsi_base);
 void acpi_irq_stats_init(void);
 extern u32 acpi_irq_handled;
 extern u32 acpi_irq_not_handled;
+extern unsigned int acpi_inuse_irq;
+#define INVALID_ACPI_IRQ  ((unsigned)-1)
+#define IS_INVALID_ACPI_IRQ(x) unlikely((x) == INVALID_ACPI_IRQ)
 
 extern int sbf_port;
 extern unsigned long acpi_realmode_flags;
-- 
1.8.4.2

