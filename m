From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 03/27] eeepc-laptop: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:51 +0800
Message-ID: <1378168335-22556-4-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_execute_simple_method() is a new ACPI API introduced to invoke
an ACPI control method that has single integer parameter and no return value.

Convert acpi_evaluate_object() to acpi_execute_simple_method()
in drivers/platform/x86/eeepc-laptop.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Corentin Chary <corentincj@iksaif.net>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/eeepc-laptop.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index a6afd41..aefcc32 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -190,16 +190,10 @@ struct eeepc_laptop {
  */
 static int write_acpi_int(acpi_handle handle, const char *method, int val)
 {
-	struct acpi_object_list params;
-	union acpi_object in_obj;
 	acpi_status status;
 
-	params.count = 1;
-	params.pointer = &in_obj;
-	in_obj.type = ACPI_TYPE_INTEGER;
-	in_obj.integer.value = val;
+	status = acpi_execute_simple_method(handle, (char *)method, val);
 
-	status = acpi_evaluate_object(handle, (char *)method, &params, NULL);
 	return (status == AE_OK ? 0 : -1);
 }
 
-- 
1.8.1.2
