From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 19/27] wmi: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:07 +0800
Message-ID: <1378168335-22556-20-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42466 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759258Ab3ICAbh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:37 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/platform/x86/wmi.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/wmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index cb4fe80..806ad7a 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -347,7 +347,7 @@ struct acpi_buffer *out)
 {
 	struct guid_block *block = NULL;
 	struct wmi_block *wblock = NULL;
-	acpi_handle handle, wc_handle;
+	acpi_handle handle;
 	acpi_status status, wc_status = AE_ERROR;
 	struct acpi_object_list input;
 	union acpi_object wq_params[1];
@@ -387,8 +387,7 @@ struct acpi_buffer *out)
 		 * expensive, but have no corresponding WCxx method. So we
 		 * should not fail if this happens.
 		 */
-		wc_status = acpi_get_handle(handle, wc_method, &wc_handle);
-		if (ACPI_SUCCESS(wc_status))
+		if (acpi_has_method(handle, wc_method))
 			wc_status = acpi_execute_simple_method(handle,
 								wc_method, 1);
 	}
-- 
1.8.1.2

