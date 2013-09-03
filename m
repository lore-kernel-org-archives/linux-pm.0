From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 07/27] topstar-laptop: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:55 +0800
Message-ID: <1378168335-22556-8-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_execute_simple_method() is a new ACPI API introduced to invoke
an ACPI control method that has single integer parameter and no return value.

Convert acpi_evaluate_object() to acpi_execute_simple_method()
in drivers/platform/x86/topstar-laptop.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/topstar-laptop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 4ab618c..67897c8 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -80,13 +80,9 @@ static void acpi_topstar_notify(struct acpi_device *device, u32 event)
 static int acpi_topstar_fncx_switch(struct acpi_device *device, bool state)
 {
 	acpi_status status;
-	union acpi_object fncx_params[1] = {
-		{ .type = ACPI_TYPE_INTEGER }
-	};
-	struct acpi_object_list fncx_arg_list = { 1, &fncx_params[0] };
 
-	fncx_params[0].integer.value = state ? 0x86 : 0x87;
-	status = acpi_evaluate_object(device->handle, "FNCX", &fncx_arg_list, NULL);
+	status = acpi_execute_simple_method(device->handle, "FNCX",
+						state ? 0x86 : 0x87);
 	if (ACPI_FAILURE(status)) {
 		pr_err("Unable to switch FNCX notifications\n");
 		return -ENODEV;
-- 
1.8.1.2
