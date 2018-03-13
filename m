From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Reduce LPI constraints logging noise
Date: Tue, 13 Mar 2018 10:47:36 +0100
Message-ID: <2232544.VHtLQCEKNu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a device referred to by ACPI LPI constrains (coming from function 1
of the Low Power S0 Idle _DSM interface) is not power-manageable via
ACPI (no _PS0 method and no power resources), the code generating
diagnostic information for the LPI constraints will print a message
about that to the kernel log on every system suspend-resume cycle
(possibly for multiple times).

That is not very useful and noisy, so modify that code to disregard
the LPI list entries corresponding to the devices that are not power-
manageable after printing that information for them once.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -851,23 +852,25 @@ static void lpi_check_constraints(void)
 	int i;
 
 	for (i = 0; i < lpi_constraints_table_size; ++i) {
+		acpi_handle handle = lpi_constraints_table[i].handle;
 		struct acpi_device *adev;
 
-		if (acpi_bus_get_device(lpi_constraints_table[i].handle, &adev))
+		if (!handle || acpi_bus_get_device(handle, &adev))
 			continue;
 
-		acpi_handle_debug(adev->handle,
+		acpi_handle_debug(handle,
 			"LPI: required min power state:%s current power state:%s\n",
 			acpi_power_state_string(lpi_constraints_table[i].min_dstate),
 			acpi_power_state_string(adev->power.state));
 
 		if (!adev->flags.power_manageable) {
-			acpi_handle_info(adev->handle, "LPI: Device not power manageble\n");
+			acpi_handle_info(handle, "LPI: Device not power manageable\n");
+			lpi_constraints_table[i].handle = NULL;
 			continue;
 		}
 
 		if (adev->power.state < lpi_constraints_table[i].min_dstate)
-			acpi_handle_info(adev->handle,
+			acpi_handle_info(handle,
 				"LPI: Constraint not met; min power state:%s current power state:%s\n",
 				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
 				acpi_power_state_string(adev->power.state));
