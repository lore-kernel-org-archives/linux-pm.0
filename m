From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/3][v2] ACPI: Using correct irq when uninstalling acpi irq handler
Date: Sun, 25 Oct 2015 01:02:19 +0800
Message-ID: <1445706139-20152-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: rui.zhang@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently when system is trying to uninstall the acpi irq
handler, it uses the acpi_gbl_FADT.sci_interrupt directly.
But acpi irq handler is actually installed by mapped irq
in acpi_os_install_interrupt_handler, so this patch fixes
this problem by using the mapped irq returned from acpi_gsi_to_irq.

Cc: <stable@vger.kernel.org> # 2.6.39
Acked-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/osl.c   | 10 +++++++---
 include/linux/acpi.h |  6 ++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 739a4a6..64df9d4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -81,6 +81,7 @@ static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
 static struct workqueue_struct *kacpi_hotplug_wq;
 static bool acpi_os_initialized;
+unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -856,17 +857,20 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
 	}
+	acpi_sci_irq = irq;
 
 	return AE_OK;
 }
 
-acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
+acpi_status acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
 {
-	if (irq != acpi_gbl_FADT.sci_interrupt)
+	if ((gsi != acpi_gbl_FADT.sci_interrupt) ||
+	    !acpi_sci_irq_valid())
 		return AE_BAD_PARAMETER;
 
-	free_irq(irq, acpi_irq);
+	free_irq(acpi_sci_irq, acpi_irq);
 	acpi_irq_handler = NULL;
+	acpi_sci_irq = INVALID_ACPI_IRQ;
 
 	return AE_OK;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 43856d1..1ae6ba0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -193,6 +193,12 @@ int acpi_ioapic_registered(acpi_handle handle, u32 gsi_base);
 void acpi_irq_stats_init(void);
 extern u32 acpi_irq_handled;
 extern u32 acpi_irq_not_handled;
+extern unsigned int acpi_sci_irq;
+#define INVALID_ACPI_IRQ	((unsigned)-1)
+static inline bool acpi_sci_irq_valid(void)
+{
+	return acpi_sci_irq != INVALID_ACPI_IRQ;
+}
 
 extern int sbf_port;
 extern unsigned long acpi_realmode_flags;
-- 
1.8.4.2
