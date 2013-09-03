From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 24/27] fujitsu-laptop: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Tue,  3 Sep 2013 08:32:12 +0800
Message-ID: <1378168335-22556-25-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_evaluate_integer() is an ACPI API introduced to evaluate an
ACPI control method that is known to have an integer return value.
This API can simplify the code because the calling function does not need to
use the specified acpi_buffer structure required by acpi_evaluate_object();

Convert acpi_evaluate_object() to acpi_evaluate_integer()
in drivers/platform/x86/fujitsu-laptop.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/fujitsu-laptop.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 765d8c1..9d30d69 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -219,8 +219,7 @@ static int call_fext_func(int cmd, int arg0, int arg1, int arg2)
 	{ .type = ACPI_TYPE_INTEGER }
 	};
 	struct acpi_object_list arg_list = { 4, &params[0] };
-	struct acpi_buffer output;
-	union acpi_object out_obj;
+	unsigned long long value;
 	acpi_handle handle = NULL;
 
 	status = acpi_get_handle(fujitsu_hotkey->acpi_handle, "FUNC", &handle);
@@ -235,10 +234,7 @@ static int call_fext_func(int cmd, int arg0, int arg1, int arg2)
 	params[2].integer.value = arg1;
 	params[3].integer.value = arg2;
 
-	output.length = sizeof(out_obj);
-	output.pointer = &out_obj;
-
-	status = acpi_evaluate_object(handle, NULL, &arg_list, &output);
+	status = acpi_evaluate_integer(handle, NULL, &arg_list, &value);
 	if (ACPI_FAILURE(status)) {
 		vdbg_printk(FUJLAPTOP_DBG_WARN,
 			"FUNC 0x%x (args 0x%x, 0x%x, 0x%x) call failed\n",
@@ -246,18 +242,10 @@ static int call_fext_func(int cmd, int arg0, int arg1, int arg2)
 		return -ENODEV;
 	}
 
-	if (out_obj.type != ACPI_TYPE_INTEGER) {
-		vdbg_printk(FUJLAPTOP_DBG_WARN,
-			"FUNC 0x%x (args 0x%x, 0x%x, 0x%x) did not "
-			"return an integer\n",
-			cmd, arg0, arg1, arg2);
-		return -ENODEV;
-	}
-
 	vdbg_printk(FUJLAPTOP_DBG_TRACE,
 		"FUNC 0x%x (args 0x%x, 0x%x, 0x%x) returned 0x%x\n",
-			cmd, arg0, arg1, arg2, (int)out_obj.integer.value);
-	return out_obj.integer.value;
+			cmd, arg0, arg1, arg2, (int)value);
+	return value;
 }
 
 #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
-- 
1.8.1.2
