From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10/13] ACPI / PM: Register power resource devices
	as soon as they are needed
Date: Thu, 25 Nov 2010 00:10:44 +0100
Message-ID: <201011250010.44306.rjw__18546.4359856725$1290640727$gmane$org@sisk.pl>
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

Depending on the organization of the ACPI namespace, power resource
device objects may generally be scanned after the "regular" device
objects that they are referred from through _PRn.  This, in turn, may
cause acpi_bus_get_power_flags() to attempt to access them through
acpi_bus_init_power() before they are registered (and initialized by
acpi_power_driver).  [This is not a theoretical issue, it actually
happens for one PnP device on my testbed HP nx6325.]

To fix this problem, make acpi_bus_get_power_flags() attempt to
register power resource devices as soon as they have been found in
the _PRn output for any other devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -827,6 +827,8 @@ end:
 	return 0;
 }
 
+static void acpi_bus_add_power_resource(acpi_handle handle);
+
 static int acpi_bus_get_power_flags(struct acpi_device *device)
 {
 	acpi_status status = 0;
@@ -855,8 +857,12 @@ static int acpi_bus_get_power_flags(stru
 		acpi_evaluate_reference(device->handle, object_name, NULL,
 					&ps->resources);
 		if (ps->resources.count) {
+			int j;
+
 			device->power.flags.power_resources = 1;
 			ps->flags.valid = 1;
+			for (j = 0; j < ps->resources.count; j++)
+				acpi_bus_add_power_resource(ps->resources.handles[j]);
 		}
 
 		/* Evaluate "_PSx" to see if we can do explicit sets */
@@ -1303,6 +1309,20 @@ end:
 #define ACPI_STA_DEFAULT (ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED | \
 			  ACPI_STA_DEVICE_UI      | ACPI_STA_DEVICE_FUNCTIONING)
 
+static void acpi_bus_add_power_resource(acpi_handle handle)
+{
+	struct acpi_bus_ops ops = {
+		.acpi_op_add = 1,
+		.acpi_op_start = 1,
+	};
+	struct acpi_device *device = NULL;
+
+	acpi_bus_get_device(handle, &device);
+	if (!device)
+		acpi_add_single_object(&device, handle, ACPI_BUS_TYPE_POWER,
+					ACPI_STA_DEFAULT, &ops);
+}
+
 static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 				    unsigned long long *sta)
 {
