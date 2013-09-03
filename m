From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 06/27] intel-smartconnect: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:54 +0800
Message-ID: <1378168335-22556-7-git-send-email-rui.zhang@intel.com>
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
in drivers/platform/x86/intel-smartconnect.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/intel-smartconnect.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel-smartconnect.c b/drivers/platform/x86/intel-smartconnect.c
index f74e93d..9758b00 100644
--- a/drivers/platform/x86/intel-smartconnect.c
+++ b/drivers/platform/x86/intel-smartconnect.c
@@ -25,10 +25,8 @@ MODULE_LICENSE("GPL");
 
 static int smartconnect_acpi_init(struct acpi_device *acpi)
 {
-	struct acpi_object_list input;
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *result;
-	union acpi_object param;
 	acpi_status status;
 
 	status = acpi_evaluate_object(acpi->handle, "GAOS", NULL, &output);
@@ -43,15 +41,8 @@ static int smartconnect_acpi_init(struct acpi_device *acpi)
 	}
 
 	if (result->integer.value & 0x1) {
-		param.type = ACPI_TYPE_INTEGER;
-		param.integer.value = 0;
-
-		input.count = 1;
-		input.pointer = &param;
-
 		dev_info(&acpi->dev, "Disabling Intel Smart Connect\n");
-		status = acpi_evaluate_object(acpi->handle, "SAOS", &input,
-					      NULL);
+		status = acpi_execute_simple_method(acpi->handle, "SAOS", 0);
 	}
 
 	kfree(result);
-- 
1.8.1.2
