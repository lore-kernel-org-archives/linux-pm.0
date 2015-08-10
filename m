From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Mon, 10 Aug 2015 10:11:26 +0800
Message-ID: <1439172686-16360-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34580 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbbHJCIG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 9 Aug 2015 22:08:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, jiang.liu@linux.intel.com
Cc: rui.zhang@intel.com, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

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
marking the acpi_gbl_FADT.sci_interrupt.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/osl.c   |  5 ++++-
 drivers/acpi/sleep.c | 20 ++++++++++++++++++--
 drivers/acpi/sleep.h |  5 +++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3b8963f..8e1420a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -49,6 +49,7 @@
 #include <asm/uaccess.h>
 
 #include "internal.h"
+#include "sleep.h"
 
 #define _COMPONENT		ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osl");
@@ -850,7 +851,9 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 		       gsi);
 		return AE_OK;
 	}
-
+#ifdef CONFIG_SUSPEND
+	set_wake_irq_freeze(irq);
+#endif
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
 	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2f0d4db..9e7b54e 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -620,6 +620,22 @@ static const struct platform_suspend_ops acpi_suspend_ops_old = {
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };
+static int wake_irq_freeze = -EINVAL;
+
+int get_wake_irq_freeze(void)
+{
+	if (IS_ERR_VALUE(wake_irq_freeze))
+		return acpi_gbl_FADT.sci_interrupt;
+	else
+		return wake_irq_freeze;
+}
+EXPORT_SYMBOL_GPL(get_wake_irq_freeze);
+
+void set_wake_irq_freeze(unsigned int irq)
+{
+	wake_irq_freeze = (int)irq;
+}
+EXPORT_SYMBOL_GPL(set_wake_irq_freeze);
 
 static int acpi_freeze_begin(void)
 {
@@ -632,14 +648,14 @@ static int acpi_freeze_prepare(void)
 	acpi_enable_wakeup_devices(ACPI_STATE_S0);
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
-	enable_irq_wake(acpi_gbl_FADT.sci_interrupt);
+	enable_irq_wake(get_wake_irq_freeze());
 	return 0;
 }
 
 static void acpi_freeze_restore(void)
 {
 	acpi_disable_wakeup_devices(ACPI_STATE_S0);
-	disable_irq_wake(acpi_gbl_FADT.sci_interrupt);
+	disable_irq_wake(get_wake_irq_freeze());
 	acpi_enable_all_runtime_gpes();
 }
 
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index c797ffa..eca4fda 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -6,3 +6,8 @@ extern struct list_head acpi_wakeup_device_list;
 extern struct mutex acpi_device_lock;
 
 extern void acpi_resume_power_resources(void);
+
+#ifdef CONFIG_SUSPEND
+extern int get_wake_irq_freeze(void);
+extern void set_wake_irq_freeze(unsigned int irq);
+#endif
-- 
2.1.4

