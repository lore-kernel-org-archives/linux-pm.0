From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/6] ACPI / PM: Do not switch interrupts off/on
	in acpi_suspend_enter()
Date: Mon, 7 Feb 2011 23:19:10 +0100
Message-ID: <201102072319.10327.rjw__4432.63653801313$1297117777$gmane$org@sisk.pl>
References: <201102072316.41270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102072316.41270.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_suspend_enter() is always called with interrupts
off, so it doesn't need to switch them off and on.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -243,7 +243,6 @@ static int acpi_suspend_begin(suspend_st
 static int acpi_suspend_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
-	unsigned long flags = 0;
 	u32 acpi_state = acpi_target_sleep_state;
 
 	ACPI_FLUSH_CPU_CACHE();
@@ -256,7 +255,6 @@ static int acpi_suspend_enter(suspend_st
 			return error;
 	}
 
-	local_irq_save(flags);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
@@ -290,7 +288,6 @@ static int acpi_suspend_enter(suspend_st
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions_early();
 
-	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
 	suspend_nvs_restore();
