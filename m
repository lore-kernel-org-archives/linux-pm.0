From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/13] ACPI / PM: Introduce __acpi_bus_get_power()
Date: Thu, 25 Nov 2010 00:07:56 +0100
Message-ID: <201011250007.56895.rjw@sisk.pl>
References: <201011250001.11297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011250001.11297.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

It sometimes is necessary to get the power state of an ACPI device
without updating its device->power.state field, for example to
avoid inconsistencies between device->power.state and the reference
counters of the device's power resources.  For this purpose introduce
__acpi_bus_get_power() that will return the given device's power
state via a pointer (instead of modifying device->power.state)
and make acpi_bus_get_power() use it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c |   48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -196,34 +196,24 @@ EXPORT_SYMBOL(acpi_bus_get_private_data)
                                  Power Management
    -------------------------------------------------------------------------- */
 
-int acpi_bus_get_power(acpi_handle handle, int *state)
+static int __acpi_bus_get_power(struct acpi_device *device, int *state)
 {
 	int result = 0;
 	acpi_status status = 0;
-	struct acpi_device *device = NULL;
 	unsigned long long psc = 0;
 
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
+	if (!device || !state)
+		return -EINVAL;
 
 	*state = ACPI_STATE_UNKNOWN;
 
-	if (!device->flags.power_manageable) {
-		/* TBD: Non-recursive algorithm for walking up hierarchy */
-		if (device->parent)
-			*state = device->parent->power.state;
-		else
-			*state = ACPI_STATE_D0;
-	} else {
+	if (device->flags.power_manageable) {
 		/*
 		 * Get the device's power state either directly (via _PSC) or
 		 * indirectly (via power resources).
 		 */
 		if (device->power.flags.power_resources) {
-			result = acpi_power_get_inferred_state(device,
-							&device->power.state);
+			result = acpi_power_get_inferred_state(device, state);
 			if (result)
 				return result;
 		} else if (device->power.flags.explicit_get) {
@@ -231,20 +221,40 @@ int acpi_bus_get_power(acpi_handle handl
 						       NULL, &psc);
 			if (ACPI_FAILURE(status))
 				return -ENODEV;
-			device->power.state = (int)psc;
+			*state = (int)psc;
 		}
-
-		*state = device->power.state;
+	} else {
+		/* TBD: Non-recursive algorithm for walking up hierarchy. */
+		*state = device->parent ?
+			device->parent->power.state : ACPI_STATE_D0;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is D%d\n",
-			  device->pnp.bus_id, device->power.state));
+			  device->pnp.bus_id, *state));
 
 	return 0;
 }
 
+
+int acpi_bus_get_power(acpi_handle handle, int *state)
+{
+	struct acpi_device *device;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result)
+		return result;
+
+	result = __acpi_bus_get_power(device, state);
+	if (result)
+		return result;
+
+	device->power.state = *state;
+	return 0;
+}
 EXPORT_SYMBOL(acpi_bus_get_power);
 
+
 int acpi_bus_set_power(acpi_handle handle, int state)
 {
 	int result = 0;
