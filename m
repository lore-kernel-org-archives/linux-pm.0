From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 25/27] intel-rst: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Tue,  3 Sep 2013 08:32:13 +0800
Message-ID: <1378168335-22556-26-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42466 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759257Ab3ICAbj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:39 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org

acpi_evaluate_integer() is an ACPI API introduced to evaluate an
ACPI control method that is known to have an integer return value.
This API can simplify the code because the calling function does not need to
use the specified acpi_buffer structure required by acpi_evaluate_object();

Convert acpi_evaluate_object() to acpi_evaluate_integer()
in drivers/platform/x86/intel-rst.c in this patch.
Plus, this should also fix a memory leak that
the acpi_buffer is not freed in some cases.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/intel-rst.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel-rst.c b/drivers/platform/x86/intel-rst.c
index fdf8ca0..6bdfe46 100644
--- a/drivers/platform/x86/intel-rst.c
+++ b/drivers/platform/x86/intel-rst.c
@@ -29,24 +29,16 @@ static ssize_t irst_show_wakeup_events(struct device *dev,
 				       char *buf)
 {
 	struct acpi_device *acpi;
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *result;
+	unsigned long long value;
 	acpi_status status;
 
 	acpi = to_acpi_device(dev);
 
-	status = acpi_evaluate_object(acpi->handle, "GFFS", NULL, &output);
+	status = acpi_evaluate_integer(acpi->handle, "GFFS", NULL, &value);
 	if (!ACPI_SUCCESS(status))
 		return -EINVAL;
 
-	result = output.pointer;
-
-	if (result->type != ACPI_TYPE_INTEGER) {
-		kfree(result);
-		return -EINVAL;
-	}
-
-	return sprintf(buf, "%lld\n", result->integer.value);
+	return sprintf(buf, "%lld\n", value);
 }
 
 static ssize_t irst_store_wakeup_events(struct device *dev,
@@ -83,24 +75,16 @@ static ssize_t irst_show_wakeup_time(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	struct acpi_device *acpi;
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *result;
+	unsigned long long value;
 	acpi_status status;
 
 	acpi = to_acpi_device(dev);
 
-	status = acpi_evaluate_object(acpi->handle, "GFTV", NULL, &output);
+	status = acpi_evaluate_integer(acpi->handle, "GFTV", NULL, &value);
 	if (!ACPI_SUCCESS(status))
 		return -EINVAL;
 
-	result = output.pointer;
-
-	if (result->type != ACPI_TYPE_INTEGER) {
-		kfree(result);
-		return -EINVAL;
-	}
-
-	return sprintf(buf, "%lld\n", result->integer.value);
+	return sprintf(buf, "%lld\n", value);
 }
 
 static ssize_t irst_store_wakeup_time(struct device *dev,
-- 
1.8.1.2

