From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] ACPI / Sleep: Rework enabling wakeup devices
Date: Fri, 2 Jul 2010 00:12:26 +0200
Message-ID: <201007020012.27005.rjw__11441.3941083059$1278022670$gmane$org@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007020010.13755.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is no reason why acpi_enable_wakeup_device() should be called
with interrupts disabled, because it doesn't access hardware.  Thus
it is possible to move it next to acpi_enable_wakeup_device_prep()
and make the ACPI suspend, hibernate and poweroff code more
straightforward.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -70,10 +70,11 @@ static int acpi_sleep_prepare(u32 acpi_s
 
 	}
 	ACPI_FLUSH_CPU_CACHE();
-	acpi_enable_wakeup_device_prep(acpi_state);
 #endif
 	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
 		acpi_state);
+	acpi_enable_wakeup_device_prep(acpi_state);
+	acpi_enable_wakeup_device(acpi_state);
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
@@ -233,7 +234,6 @@ static int acpi_suspend_enter(suspend_st
 	}
 
 	local_irq_save(flags);
-	acpi_enable_wakeup_device(acpi_state);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
@@ -437,7 +437,6 @@ static int acpi_hibernation_enter(void)
 	ACPI_FLUSH_CPU_CACHE();
 
 	local_irq_save(flags);
-	acpi_enable_wakeup_device(ACPI_STATE_S4);
 	/* This shouldn't return.  If it returns, we have a problem */
 	status = acpi_enter_sleep_state(ACPI_STATE_S4);
 	/* Reprogram control registers and execute _BFS */
@@ -682,7 +681,6 @@ static void acpi_power_off(void)
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk(KERN_DEBUG "%s called\n", __func__);
 	local_irq_disable();
-	acpi_enable_wakeup_device(ACPI_STATE_S5);
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
