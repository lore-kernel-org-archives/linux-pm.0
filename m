From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/3] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Thu, 22 Oct 2015 20:03:29 +0800
Message-ID: <1445515409-31349-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: rui.zhang@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

Cc: <stable@vger.kernel.org> # 3.18+
Acked-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/sleep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2f0d4db..1704595 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -632,14 +632,16 @@ static int acpi_freeze_prepare(void)
 	acpi_enable_wakeup_devices(ACPI_STATE_S0);
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
-	enable_irq_wake(acpi_gbl_FADT.sci_interrupt);
+	if (!IS_INVALID_ACPI_IRQ(acpi_sci_irq))
+		enable_irq_wake(acpi_sci_irq);
 	return 0;
 }
 
 static void acpi_freeze_restore(void)
 {
 	acpi_disable_wakeup_devices(ACPI_STATE_S0);
-	disable_irq_wake(acpi_gbl_FADT.sci_interrupt);
+	if (!IS_INVALID_ACPI_IRQ(acpi_sci_irq))
+		disable_irq_wake(acpi_sci_irq);
 	acpi_enable_all_runtime_gpes();
 }
 
-- 
1.8.4.2
