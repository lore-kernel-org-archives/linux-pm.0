From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 2/3] ACPI: enable ACPI SCI during suspend
Date: Mon,  4 Feb 2013 15:10:10 +0800
Message-ID: <1359961811-978-2-git-send-email-rui.zhang@intel.com>
References: <1359961811-978-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7996 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab3BDHKg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Feb 2013 02:10:36 -0500
In-Reply-To: <1359961811-978-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: rjw@sisk.pl, lenb@kernel.org, Zhang Rui <rui.zhang@intel.com>

Enable ACPI SCI during suspend so that SCI can be used
as wake events for PM_SUSPEND_FREEZE.

For S3/S4 transition,
We disable all GPEs in suspend_ops->prepare_late() to
fix a problem that GPEs may trigger SCI  before
arch_suspend_disable_irqs() is run.
So it is safe to leave the SCI enabled until
arch_suspend_irq_disable() is run.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3ff2678..3adeb10 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -787,7 +787,7 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
-	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
+	if (request_irq(irq, acpi_irq, IRQF_SHARED | IRQF_NO_SUSPEND, "acpi", acpi_irq)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
-- 
1.7.9.5

