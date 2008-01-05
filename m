From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 6/7] ACPI hibernation: Call _PTS before
	suspending devices
Date: Sat, 5 Jan 2008 23:56:39 +0100
Message-ID: <200801052356.41065.rjw__21867.2985247851$1199575217$gmane$org@sisk.pl>
References: <200801052332.44500.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801052332.44500.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, "Moore,
	Robert" <robert.moore@intel.com>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI 1.0 specification wants us to put devices into low power
states after executing the _PTS global control methods, while ACPI
2.0 and later want us to do that in the reverse order.  The current
hibernation code follows ACPI 2.0 in that respect which may cause some
ACPI 1.0x systems to hang during hibernation (ref.
http://bugzilla.kernel.org/show_bug.cgi?id=9528).

Make the hibernation code execute _PTS before putting devices into
low power (ie. in accordance with ACPI 1.0x) with the possibility to
override that using the 'acpi_new_pts_ordering' kernel command line
option.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -283,22 +283,34 @@ static struct dmi_system_id __initdata a
 #ifdef CONFIG_HIBERNATION
 static int acpi_hibernation_open(void)
 {
+	int error;
+
 	acpi_target_sleep_state = ACPI_STATE_S4;
-	return 0;
+	if (new_pts_ordering)
+		return 0;
+
+	error = acpi_sleep_prepare(ACPI_STATE_S4);
+	if (error)
+		acpi_target_sleep_state = ACPI_STATE_S0;
+	else
+		acpi_sleep_finish_wake_up = true;
+
+	return error;
 }
 
 static int acpi_hibernation_prepare(void)
 {
-	int error;
-
-	error = acpi_sleep_prepare(ACPI_STATE_S4);
-	if (error)
-		return error;
+	if (new_pts_ordering) {
+		int error = acpi_sleep_prepare(ACPI_STATE_S4);
 
-	if (!ACPI_SUCCESS(acpi_hw_disable_all_gpes()))
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
 
 static int acpi_hibernation_enter(void)
@@ -339,15 +351,17 @@ static void acpi_hibernation_finish(void
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
 	acpi_target_sleep_state = ACPI_STATE_S0;
+	acpi_sleep_finish_wake_up = false;
 }
 
 static void acpi_hibernation_close(void)
 {
 	/*
 	 * This is necessary in case acpi_hibernation_finish() is not called
-	 * during a failing transition to the sleep state.
+	 * directly during a failing transition to the sleep state.
 	 */
-	acpi_target_sleep_state = ACPI_STATE_S0;
+	if (acpi_sleep_finish_wake_up)
+		acpi_hibernation_finish();
 }
 
 static int acpi_hibernation_pre_restore(void)
