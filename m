From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 18/27] toshiba_acpi: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:06 +0800
Message-ID: <1378168335-22556-19-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/platform/x86/toshiba_acpi.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/toshiba_acpi.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 4c0e657..235185b 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -974,7 +974,7 @@ static void toshiba_acpi_report_hotkey(struct toshiba_acpi_dev *dev,
 static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
 {
 	acpi_status status;
-	acpi_handle ec_handle, handle;
+	acpi_handle ec_handle;
 	int error;
 	u32 hci_result;
 
@@ -1001,10 +1001,7 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
 	 */
 	status = AE_ERROR;
 	ec_handle = ec_get_handle();
-	if (ec_handle)
-		status = acpi_get_handle(ec_handle, "NTFY", &handle);
-
-	if (ACPI_SUCCESS(status)) {
+	if (ec_handle && acpi_has_method(ec_handle, "NTFY")) {
 		INIT_WORK(&dev->hotkey_work, toshiba_acpi_hotkey_work);
 
 		error = i8042_install_filter(toshiba_acpi_i8042_filter);
@@ -1020,10 +1017,9 @@ static int toshiba_acpi_setup_keyboard(struct toshiba_acpi_dev *dev)
 	 * Determine hotkey query interface. Prefer using the INFO
 	 * method when it is available.
 	 */
-	status = acpi_get_handle(dev->acpi_dev->handle, "INFO", &handle);
-	if (ACPI_SUCCESS(status)) {
+	if (acpi_has_method(dev->acpi_dev->handle, "INFO"))
 		dev->info_supported = 1;
-	} else {
+	else {
 		hci_write1(dev, HCI_SYSTEM_EVENT, 1, &hci_result);
 		if (hci_result == HCI_SUCCESS)
 			dev->system_event_supported = 1;
@@ -1148,15 +1144,10 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 
 static const char *find_hci_method(acpi_handle handle)
 {
-	acpi_status status;
-	acpi_handle hci_handle;
-
-	status = acpi_get_handle(handle, "GHCI", &hci_handle);
-	if (ACPI_SUCCESS(status))
+	if (acpi_has_method(handle, "GHCI"))
 		return "GHCI";
 
-	status = acpi_get_handle(handle, "SPFC", &hci_handle);
-	if (ACPI_SUCCESS(status))
+	if (acpi_has_method(handle, "SPFC"))
 		return "SPFC";
 
 	return NULL;
-- 
1.8.1.2
