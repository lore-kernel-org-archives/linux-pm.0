From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT][PATCH 3/4] ACPI / PM: Shorten variable name in
	acpi_pm_device_sleep_state()
Date: Sat, 26 May 2012 23:21:04 +0200
Message-ID: <201205262321.04574.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
	<201205262227.47442.rjw@sisk.pl> <201205262316.30096.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205262316.30096.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Save a couple of code lines by using a more concise name for the
variable representing the ACPI method to evaluate.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -697,7 +697,7 @@ int acpi_pm_device_sleep_state(struct de
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
 	struct acpi_device *adev;
-	char acpi_method[] = "_SxD";
+	char method[] = "_SxD";
 	unsigned long long d_min, d_max;
 
 	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
@@ -705,7 +705,7 @@ int acpi_pm_device_sleep_state(struct de
 		return -ENODEV;
 	}
 
-	acpi_method[2] = '0' + acpi_target_sleep_state;
+	method[2] = '0' + acpi_target_sleep_state;
 	/*
 	 * If the sleep state is S0, we will return D3, but if the device has
 	 * _S0W, we will use the value from _S0W
@@ -722,7 +722,7 @@ int acpi_pm_device_sleep_state(struct de
 	 * provided -- that's our fault recovery, we ignore retval.
 	 */
 	if (acpi_target_sleep_state > ACPI_STATE_S0)
-		acpi_evaluate_integer(handle, acpi_method, NULL, &d_min);
+		acpi_evaluate_integer(handle, method, NULL, &d_min);
 
 	/*
 	 * If _PRW says we can wake up the system from the target sleep state,
@@ -736,17 +736,15 @@ int acpi_pm_device_sleep_state(struct de
 	     adev->wakeup.sleep_state >= acpi_target_sleep_state)) {
 		acpi_status status;
 
-		acpi_method[3] = 'W';
-		status = acpi_evaluate_integer(handle, acpi_method, NULL,
-						&d_max);
+		method[3] = 'W';
+		status = acpi_evaluate_integer(handle, method, NULL, &d_max);
 		if (ACPI_FAILURE(status)) {
 			if (acpi_target_sleep_state != ACPI_STATE_S0 ||
 			    status != AE_NOT_FOUND)
 				d_max = d_min;
 		} else if (d_max < d_min) {
 			/* Warn the user of the broken DSDT */
-			printk(KERN_WARNING "ACPI: Wrong value from %s\n",
-				acpi_method);
+			pr_warning("ACPI: Wrong value from %s\n", method);
 			/* Sanitize it */
 			d_min = d_max;
 		}
