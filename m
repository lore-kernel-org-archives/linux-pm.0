From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/13] ACPI / PM: Add function for updating device
	power state consistently
Date: Thu, 25 Nov 2010 00:09:15 +0100
Message-ID: <201011250009.15501.rjw__47925.744430586$1290640730$gmane$org@sisk.pl>
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

Add function acpi_bus_update_power() for reading the actual power
state of an ACPI device and updating its device->power.state field
in such a way that its power resources' reference counters will
remain consistent with that field.

For this purpose introduce __acpi_bus_set_power() setting the
power state of an ACPI device without updating its
device->power.state field and make acpi_bus_set_power() and
acpi_bus_update_power() use it (acpi_bus_set_power() retains the
current behavior for now).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c      |   90 ++++++++++++++++++++++++++++++++----------------
 include/acpi/acpi_bus.h |    1 
 2 files changed, 62 insertions(+), 29 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -255,44 +255,17 @@ int acpi_bus_get_power(acpi_handle handl
 EXPORT_SYMBOL(acpi_bus_get_power);
 
 
-int acpi_bus_set_power(acpi_handle handle, int state)
+static int __acpi_bus_set_power(struct acpi_device *device, int state)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
-	struct acpi_device *device = NULL;
 	char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
 
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
-
-	if ((state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
+	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
 		return -EINVAL;
 
 	/* Make sure this is a valid target state */
 
-	if (!device->flags.power_manageable) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device `[%s]' is not power manageable\n",
-				kobject_name(&device->dev.kobj)));
-		return -ENODEV;
-	}
-	/*
-	 * Get device's current power state
-	 */
-	if (!acpi_power_nocheck) {
-		/*
-		 * Maybe the incorrect power state is returned on the bogus
-		 * bios, which is different with the real power state.
-		 * For example: the bios returns D0 state and the real power
-		 * state is D3. OS expects to set the device to D0 state. In
-		 * such case if OS uses the power state returned by the BIOS,
-		 * the device can't be transisted to the correct power state.
-		 * So if the acpi_power_nocheck is set, it is unnecessary to
-		 * get the power state by calling acpi_bus_get_power.
-		 */
-		acpi_bus_get_power(device->handle, &device->power.state);
-	}
 	if ((state == device->power.state) && !device->flags.force_power_state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
 				  state));
@@ -362,6 +335,42 @@ int acpi_bus_set_power(acpi_handle handl
 	return result;
 }
 
+
+int acpi_bus_set_power(acpi_handle handle, int state)
+{
+	struct acpi_device *device;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result)
+		return result;
+
+	if (!device->flags.power_manageable) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				"Device [%s] is not power manageable\n",
+				dev_name(&device->dev)));
+		return -ENODEV;
+	}
+
+	/*
+	 * Get device's current power state
+	 */
+	if (!acpi_power_nocheck) {
+		/*
+		 * Maybe the incorrect power state is returned on the bogus
+		 * bios, which is different with the real power state.
+		 * For example: the bios returns D0 state and the real power
+		 * state is D3. OS expects to set the device to D0 state. In
+		 * such case if OS uses the power state returned by the BIOS,
+		 * the device can't be transisted to the correct power state.
+		 * So if the acpi_power_nocheck is set, it is unnecessary to
+		 * get the power state by calling acpi_bus_get_power.
+		 */
+		__acpi_bus_get_power(device, &device->power.state);
+	}
+
+	return __acpi_bus_set_power(device, state);
+}
 EXPORT_SYMBOL(acpi_bus_set_power);
 
 
@@ -389,6 +398,29 @@ int acpi_bus_init_power(struct acpi_devi
 }
 
 
+int acpi_bus_update_power(acpi_handle handle, int *state_p)
+{
+	struct acpi_device *device;
+	int state;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result)
+		return result;
+
+	result = __acpi_bus_get_power(device, &state);
+	if (result)
+		return result;
+
+	result = __acpi_bus_set_power(device, state);
+	if (!result && state_p)
+		*state_p = state;
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(acpi_bus_update_power);
+
+
 bool acpi_bus_power_manageable(acpi_handle handle)
 {
 	struct acpi_device *device;
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -330,6 +330,7 @@ acpi_status acpi_bus_get_status_handle(a
 int acpi_bus_get_status(struct acpi_device *device);
 int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
+int acpi_bus_update_power(acpi_handle handle, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
 bool acpi_bus_can_wakeup(acpi_handle handle);
 #ifdef CONFIG_ACPI_PROC_EVENT
