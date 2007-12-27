From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 4/7] Suspend: Call _PTS early on ACPI 1.0x
	systems
Date: Thu, 27 Dec 2007 19:17:32 +0100
Message-ID: <200712271917.32982.rjw@sisk.pl>
References: <200712271903.53961.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712271903.53961.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI 1.0 specification wants us to put devices into low power
states after executing the _PTS global control methods, while ACPI
2.0 and later want us to do that in the reverse order.  The current
suspend code follows ACPI 2.0 in that respect which causes some
ACPI 1.0x systems to hang during suspend (ref.
http://bugzilla.kernel.org/show_bug.cgi?id=9528).

Make the suspend code execute _PTS before putting devices into low
power states on ACPI 1.0x systems (i.e. on systems for which the
revision in the FADT header is lesser than 3).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -26,6 +26,7 @@ u8 sleep_states[ACPI_S_STATE_COUNT];
 
 #ifdef CONFIG_PM_SLEEP
 static u32 acpi_target_sleep_state = ACPI_STATE_S0;
+static bool acpi_sleep_finish_wake_up;
 #endif
 
 int acpi_sleep_prepare(u32 acpi_state)
@@ -74,6 +75,14 @@ static int acpi_pm_open(suspend_state_t 
 
 	if (sleep_states[acpi_state]) {
 		acpi_target_sleep_state = acpi_state;
+		/* On ACPI 1.0x systems _PTS has to be executed right now. */
+		if (acpi_gbl_FADT.header.revision < 3) {
+			error = acpi_sleep_prepare(acpi_state);
+			if (error)
+				acpi_target_sleep_state = ACPI_STATE_S0;
+			else
+				acpi_sleep_finish_wake_up = true;
+		}
 	} else {
 		printk(KERN_ERR "ACPI does not support this state: %d\n",
 			pm_state);
@@ -91,15 +100,18 @@ static int acpi_pm_open(suspend_state_t 
 
 static int acpi_pm_prepare(void)
 {
-	int error;
+	/* On ACPI 1.0x systems_PTS global is executed earlier. */
+	if (acpi_gbl_FADT.header.revision >= 3) {
+		int error = acpi_sleep_prepare(acpi_target_sleep_state);
 
-	error = acpi_sleep_prepare(acpi_target_sleep_state);
-	if (error)
-		acpi_target_sleep_state = ACPI_STATE_S0;
-	else if (!ACPI_SUCCESS(acpi_hw_disable_all_gpes()))
-		error = -EFAULT;
+		if (error) {
+			acpi_target_sleep_state = ACPI_STATE_S0;
+			return error;
+		}
+		acpi_sleep_finish_wake_up = true;
+	}
 
-	return error;
+	return ACPI_SUCCESS(acpi_hw_disable_all_gpes()) ? 0 : -EFAULT;
 }
 
 /**
@@ -123,10 +135,8 @@ static int acpi_pm_enter(suspend_state_t
 	if (acpi_state == ACPI_STATE_S3) {
 		int error = acpi_save_state_mem();
 
-		if (error) {
-			acpi_target_sleep_state = ACPI_STATE_S0;
+		if (error)
 			return error;
-		}
 	}
 
 	local_irq_save(flags);
@@ -187,6 +197,7 @@ static void acpi_pm_finish(void)
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
 	acpi_target_sleep_state = ACPI_STATE_S0;
+	acpi_sleep_finish_wake_up = false;
 
 #ifdef CONFIG_X86
 	if (init_8259A_after_S1) {
@@ -203,10 +214,11 @@ static void acpi_pm_finish(void)
 static void acpi_pm_close(void)
 {
 	/*
-	 * This is necessary in case acpi_pm_finish() is not called during a
-	 * failing transition to a sleep state.
+	 * This is necessary in case acpi_pm_finish() is not called directly
+	 * during a failing transition to a sleep state.
 	 */
-	acpi_target_sleep_state = ACPI_STATE_S0;
+	if (acpi_sleep_finish_wake_up)
+		acpi_pm_finish();
 }
 
 static int acpi_pm_state_valid(suspend_state_t pm_state)
