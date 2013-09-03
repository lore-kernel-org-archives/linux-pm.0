From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 26/27] intel-smartconnect: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Tue,  3 Sep 2013 08:32:14 +0800
Message-ID: <1378168335-22556-27-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_evaluate_integer() is an ACPI API introduced to evaluate an
ACPI control method that is known to have an integer return value.
This API can simplify the code because the calling function does not need to
use the specified acpi_buffer structure required by acpi_evaluate_object();

Convert acpi_evaluate_object() to acpi_evaluate_integer()
in drivers/platform/x86/intel-smartconnect.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/intel-smartconnect.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel-smartconnect.c b/drivers/platform/x86/intel-smartconnect.c
index 9758b00..88a30e3 100644
--- a/drivers/platform/x86/intel-smartconnect.c
+++ b/drivers/platform/x86/intel-smartconnect.c
@@ -25,28 +25,18 @@ MODULE_LICENSE("GPL");
 
 static int smartconnect_acpi_init(struct acpi_device *acpi)
 {
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *result;
+	unsigned long long value;
 	acpi_status status;
 
-	status = acpi_evaluate_object(acpi->handle, "GAOS", NULL, &output);
+	status = acpi_evaluate_integer(acpi->handle, "GAOS", NULL, &value);
 	if (!ACPI_SUCCESS(status))
 		return -EINVAL;
 
-	result = output.pointer;
-
-	if (result->type != ACPI_TYPE_INTEGER) {
-		kfree(result);
-		return -EINVAL;
-	}
-
-	if (result->integer.value & 0x1) {
+	if (value & 0x1) {
 		dev_info(&acpi->dev, "Disabling Intel Smart Connect\n");
 		status = acpi_execute_simple_method(acpi->handle, "SAOS", 0);
 	}
 
-	kfree(result);
-
 	return 0;
 }
 
-- 
1.8.1.2
