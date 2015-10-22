From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/3] ACPI: Using correct irq when waiting for events
Date: Thu, 22 Oct 2015 20:03:19 +0800
Message-ID: <1445515399-31302-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: rui.zhang@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When system is waiting for GPE/fixed event handler to finish,
it uses the acpi_gbl_FADT.sci_interrupt directly. However, we
should use mapped irq returned by acpi_gsi_to_irq for synchronize_hardirq.

Cc: <stable@vger.kernel.org> # 3.19+
Acked-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/osl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 2e9eccf..3341788 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1184,8 +1184,8 @@ void acpi_os_wait_events_complete(void)
 	 * Make sure the GPE handler or the fixed event handler is not used
 	 * on another CPU after removal.
 	 */
-	if (acpi_irq_handler)
-		synchronize_hardirq(acpi_gbl_FADT.sci_interrupt);
+	if (!IS_INVALID_ACPI_IRQ(acpi_sci_irq))
+		synchronize_hardirq(acpi_sci_irq);
 	flush_workqueue(kacpid_wq);
 	flush_workqueue(kacpi_notify_wq);
 }
-- 
1.8.4.2
