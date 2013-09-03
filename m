From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 08/27] toshiba_acpi: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:56 +0800
Message-ID: <1378168335-22556-9-git-send-email-rui.zhang@intel.com>
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
in drivers/platform/x86/toshiba_acpi.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/toshiba_acpi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index eb3467e..4c0e657 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -191,16 +191,9 @@ static __inline__ void _set_bit(u32 * word, u32 mask, int value)
 
 static int write_acpi_int(const char *methodName, int val)
 {
-	struct acpi_object_list params;
-	union acpi_object in_objs[1];
 	acpi_status status;
 
-	params.count = ARRAY_SIZE(in_objs);
-	params.pointer = in_objs;
-	in_objs[0].type = ACPI_TYPE_INTEGER;
-	in_objs[0].integer.value = val;
-
-	status = acpi_evaluate_object(NULL, (char *)methodName, &params, NULL);
+	status = acpi_execute_simple_method(NULL, (char *)methodName, val);
 	return (status == AE_OK) ? 0 : -EIO;
 }
 
-- 
1.8.1.2
