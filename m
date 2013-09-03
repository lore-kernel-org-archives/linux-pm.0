From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 09/27] wmi: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:57 +0800
Message-ID: <1378168335-22556-10-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_execute_simple_method() is a new ACPI API introduced to invoke
an ACPI control method that has single integer parameter and no return value.

Convert acpi_evaluate_object() to acpi_execute_simple_method()
in drivers/platform/x86/wmi.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/wmi.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index b13344c..cb4fe80 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -252,8 +252,6 @@ static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 {
 	struct guid_block *block = NULL;
 	char method[5];
-	struct acpi_object_list input;
-	union acpi_object params[1];
 	acpi_status status;
 	acpi_handle handle;
 
@@ -263,13 +261,9 @@ static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 	if (!block)
 		return AE_NOT_EXIST;
 
-	input.count = 1;
-	input.pointer = params;
-	params[0].type = ACPI_TYPE_INTEGER;
-	params[0].integer.value = enable;
 
 	snprintf(method, 5, "WE%02X", block->notify_id);
-	status = acpi_evaluate_object(handle, method, &input, NULL);
+	status = acpi_execute_simple_method(handle, method, enable);
 
 	if (status != AE_OK && status != AE_NOT_FOUND)
 		return status;
@@ -355,8 +349,8 @@ struct acpi_buffer *out)
 	struct wmi_block *wblock = NULL;
 	acpi_handle handle, wc_handle;
 	acpi_status status, wc_status = AE_ERROR;
-	struct acpi_object_list input, wc_input;
-	union acpi_object wc_params[1], wq_params[1];
+	struct acpi_object_list input;
+	union acpi_object wq_params[1];
 	char method[5];
 	char wc_method[5] = "WC";
 
@@ -386,11 +380,6 @@ struct acpi_buffer *out)
 	 * enable collection.
 	 */
 	if (block->flags & ACPI_WMI_EXPENSIVE) {
-		wc_input.count = 1;
-		wc_input.pointer = wc_params;
-		wc_params[0].type = ACPI_TYPE_INTEGER;
-		wc_params[0].integer.value = 1;
-
 		strncat(wc_method, block->object_id, 2);
 
 		/*
@@ -400,8 +389,8 @@ struct acpi_buffer *out)
 		 */
 		wc_status = acpi_get_handle(handle, wc_method, &wc_handle);
 		if (ACPI_SUCCESS(wc_status))
-			wc_status = acpi_evaluate_object(handle, wc_method,
-				&wc_input, NULL);
+			wc_status = acpi_execute_simple_method(handle,
+								wc_method, 1);
 	}
 
 	strcpy(method, "WQ");
@@ -414,9 +403,7 @@ struct acpi_buffer *out)
 	 * the WQxx method failed - we should disable collection anyway.
 	 */
 	if ((block->flags & ACPI_WMI_EXPENSIVE) && ACPI_SUCCESS(wc_status)) {
-		wc_params[0].integer.value = 0;
-		status = acpi_evaluate_object(handle,
-		wc_method, &wc_input, NULL);
+		status = acpi_execute_simple_method(handle, wc_method, 0);
 	}
 
 	return status;
-- 
1.8.1.2
