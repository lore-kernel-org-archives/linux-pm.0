From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 10/10] ACPI: thermal fixup
Date: Thu, 17 Jan 2008 15:51:18 +0800
Message-ID: <1200556279.2935.119.camel__30752.6275552393$1200556564$gmane$org@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, sujith.thomas@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

The alias name may be used in _PSL, _ALx and _TZD,
so we bind the cooling device only if the acpi_device node matches.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
---
 drivers/acpi/thermal.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -1015,7 +1015,9 @@ static int acpi_thermal_cooling_device_c
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_thermal *tz = thermal->devdata;
-	acpi_handle handle = device->handle;
+	struct acpi_device *dev;
+	acpi_status status;
+	acpi_handle handle;
 	int i;
 	int j;
 	int trip = -1;
@@ -1031,12 +1033,13 @@ static int acpi_thermal_cooling_device_c
 		trip++;
 		for (i = 0; i < tz->trips.passive.devices.count;
 		    i++) {
-			if (tz->trips.passive.devices.handles[i] !=
-				handle)
-				continue;
-			result = action(thermal, trip, cdev);
-			if (result)
-				goto failed;
+			handle = tz->trips.passive.devices.handles[i];
+			status = acpi_bus_get_device(handle, &dev);
+			if (ACPI_SUCCESS(status) && (dev == device)) {
+				result = action(thermal, trip, cdev);
+				if (result)
+					goto failed;
+			}
 		}
 	}
 
@@ -1047,21 +1050,24 @@ static int acpi_thermal_cooling_device_c
 		for (j = 0;
 		    j < tz->trips.active[i].devices.count;
 		    j++) {
-			if (tz->trips.active[i].devices.
-						handles[j] != handle)
-				continue;
-			result = action(thermal, trip, cdev);
-			if (result)
-				goto failed;
+			handle = tz->trips.active[i].devices.handles[j];
+			status = acpi_bus_get_device(handle, &dev);
+			if (ACPI_SUCCESS(status) && (dev == device)) {
+				result = action(thermal, trip, cdev);
+				if (result)
+					goto failed;
+			}
 		}
 	}
 
 	for (i = 0; i < tz->devices.count; i++) {
-		if (tz->devices.handles[i] != handle)
-			continue;
-		result = action(thermal, -1, cdev);
-		if (result)
-			goto failed;
+		handle = tz->devices.handles[i];
+		status = acpi_bus_get_device(handle, &dev);
+		if (ACPI_SUCCESS(status) && (dev == device)) {
+			result = action(thermal, -1, cdev);
+			if (result)
+				goto failed;
+		}
 	}
 
 failed:
