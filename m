From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 27/27] toshiba_acpi: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Tue,  3 Sep 2013 08:32:15 +0800
Message-ID: <1378168335-22556-28-git-send-email-rui.zhang@intel.com>
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
in drivers/platform/x86/toshiba_acpi.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/toshiba_acpi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 235185b..0cfadb6 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -940,21 +940,17 @@ static void toshiba_acpi_hotkey_work(struct work_struct *work)
  */
 static int toshiba_acpi_query_hotkey(struct toshiba_acpi_dev *dev)
 {
-	struct acpi_buffer buf;
-	union acpi_object out_obj;
+	unsigned long long value;
 	acpi_status status;
 
-	buf.pointer = &out_obj;
-	buf.length = sizeof(out_obj);
-
-	status = acpi_evaluate_object(dev->acpi_dev->handle, "INFO",
-				      NULL, &buf);
-	if (ACPI_FAILURE(status) || out_obj.type != ACPI_TYPE_INTEGER) {
+	status = acpi_evaluate_integer(dev->acpi_dev->handle, "INFO",
+				      NULL, &value);
+	if (ACPI_FAILURE(status)) {
 		pr_err("ACPI INFO method execution failed\n");
 		return -EIO;
 	}
 
-	return out_obj.integer.value;
+	return value;
 }
 
 static void toshiba_acpi_report_hotkey(struct toshiba_acpi_dev *dev,
-- 
1.8.1.2
