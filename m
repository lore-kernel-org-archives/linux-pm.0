From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 6/7] Hibernation: Call _PTS early on ACPI
	1.0x systems
Date: Thu, 27 Dec 2007 19:19:10 +0100
Message-ID: <200712271919.12184.rjw@sisk.pl>
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
hibernation code follows ACPI 2.0 in that respect which may cause some
ACPI 1.0x systems to hang during hibernation (ref.
http://bugzilla.kernel.org/show_bug.cgi?id=9528).

Make the hibernation code execute _PTS before putting devices into low
power states on ACPI 1.0x systems (i.e. on systems for which the
revision in the FADT header is lesser than 3).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -271,21 +271,35 @@ static struct dmi_system_id __initdata a
 static int acpi_hibernation_open(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
+
+	/* On ACPI 1.0x systems _PTS has to be executed right now. */
+	if (acpi_gbl_FADT.header.revision < 3) {
+		int error = acpi_sleep_prepare(ACPI_STATE_S4);
+
+		if (error) {
+			acpi_target_sleep_state = ACPI_STATE_S0;
+			return error;
+		}
+		acpi_sleep_finish_wake_up = true;
+	}
+
 	return 0;
 }
 
 static int acpi_hibernation_prepare(void)
 {
-	int error;
-
-	error = acpi_sleep_prepare(ACPI_STATE_S4);
-	if (error)
-		return error;
-
-	if (!ACPI_SUCCESS(acpi_hw_disable_all_gpes()))
-		error = -EFAULT;
+	/* On ACPI 1.0x systems _PTS global is executed earlier. */
+	if (acpi_gbl_FADT.header.revision >= 3) {
+		int error = acpi_sleep_prepare(ACPI_STATE_S4);
+
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
@@ -326,15 +340,17 @@ static void acpi_hibernation_finish(void
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
