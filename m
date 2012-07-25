From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/52] ACPI: Add _OST support for ACPI CPU hotplug
Date: Tue, 24 Jul 2012 23:41:18 -0400
Message-ID: <51af3b9202ccffe0476899d5c29f0ae7e6bfdcea.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Toshi Kani <toshi.kani@hp.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Toshi Kani <toshi.kani@hp.com>

Changed acpi_processor_hotplug_notify() to call ACPI _OST method
when ACPI CPU hotplug operation has completed.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_driver.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 0734086..971c454 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -701,9 +701,9 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
 {
 	struct acpi_processor *pr;
 	struct acpi_device *device = NULL;
+	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE; /* default */
 	int result;
 
-
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -715,14 +715,18 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
 		if (!is_processor_present(handle))
 			break;
 
-		if (acpi_bus_get_device(handle, &device)) {
-			result = acpi_processor_device_add(handle, &device);
-			if (result)
-				printk(KERN_ERR PREFIX
-					    "Unable to add the device\n");
+		if (!acpi_bus_get_device(handle, &device))
+			break;
+
+		result = acpi_processor_device_add(handle, &device);
+		if (result) {
+			printk(KERN_ERR PREFIX "Unable to add the device\n");
 			break;
 		}
+
+		ost_code = ACPI_OST_SC_SUCCESS;
 		break;
+
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "received ACPI_NOTIFY_EJECT_REQUEST\n"));
@@ -736,15 +740,23 @@ static void acpi_processor_hotplug_notify(acpi_handle handle,
 		if (!pr) {
 			printk(KERN_ERR PREFIX
 				    "Driver data is NULL, dropping EJECT\n");
-			return;
+			break;
 		}
+
+		/* REVISIT: update when eject is supported */
+		ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
 		break;
+
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
-		break;
+
+		/* non-hotplug event; possibly handled by other handler */
+		return;
 	}
 
+	/* Inform firmware that the hotplug operation has completed */
+	(void) acpi_evaluate_hotplug_ost(handle, event, ost_code, NULL);
 	return;
 }
 
-- 
1.7.12.rc0
