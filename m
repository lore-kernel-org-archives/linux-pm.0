From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT][PATCH 4/4] ACPI / PM: Fix interactions between _SxD and _SxW
Date: Sat, 26 May 2012 23:21:50 +0200
Message-ID: <201205262321.50409.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain> <201205262227.47442.rjw@sisk.pl> <201205262316.30096.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201205262316.30096.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI specification (ACPI 5.0 and earlier) tells us to use the
value returned by the _SxD method for the given device as the
lowest-power state the device can be put into before transitioning
the system into the given sleep state if (1) the device is supposed
to wake up the system and (2) the _SxW method is not present for it.
However, if both _SxD and _SxW are not present, we are free to use
D3cold as the lowest-power state to put the device into.

Unfortunately, acpi_pm_device_sleep_state() returns D0 as the
lowest-power state to put the device into if both _SxD and _SxW are
not present, which is incorrect.  Prevent this from happening by
making acpi_pm_device_sleep_state() check whether or not _SxD is
present while deciding what value to use as the lowest-power state
to put the device into.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -699,6 +699,8 @@ int acpi_pm_device_sleep_state(struct de
 	struct acpi_device *adev;
 	char method[] = "_SxD";
 	unsigned long long d_min, d_max;
+	acpi_status status;
+	bool sxd_present = false;
 
 	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
 		printk(KERN_DEBUG "ACPI handle has no context!\n");
@@ -719,10 +721,13 @@ int acpi_pm_device_sleep_state(struct de
 	 * minimum D-state is D0 (ACPI 3.x).
 	 *
 	 * NOTE: We rely on acpi_evaluate_integer() not clobbering the integer
-	 * provided -- that's our fault recovery, we ignore retval.
+	 * provided in case of an error.
 	 */
-	if (acpi_target_sleep_state > ACPI_STATE_S0)
-		acpi_evaluate_integer(handle, method, NULL, &d_min);
+	if (acpi_target_sleep_state > ACPI_STATE_S0) {
+		status = acpi_evaluate_integer(handle, method, NULL, &d_min);
+		if (status != AE_NOT_FOUND)
+			sxd_present = true;
+	}
 
 	/*
 	 * If _PRW says we can wake up the system from the target sleep state,
@@ -734,13 +739,10 @@ int acpi_pm_device_sleep_state(struct de
 	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
 	    (device_may_wakeup(dev) && adev->wakeup.flags.valid &&
 	     adev->wakeup.sleep_state >= acpi_target_sleep_state)) {
-		acpi_status status;
-
 		method[3] = 'W';
 		status = acpi_evaluate_integer(handle, method, NULL, &d_max);
 		if (ACPI_FAILURE(status)) {
-			if (acpi_target_sleep_state != ACPI_STATE_S0 ||
-			    status != AE_NOT_FOUND)
+			if (sxd_present || status != AE_NOT_FOUND)
 				d_max = d_min;
 		} else if (d_max < d_min) {
 			/* Warn the user of the broken DSDT */

