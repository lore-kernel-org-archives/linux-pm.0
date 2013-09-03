From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 05/27] intel-rst: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:53 +0800
Message-ID: <1378168335-22556-6-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55403 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759185Ab3ICAbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:05 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org

acpi_execute_simple_method() is a new ACPI API introduced to invoke
an ACPI control method that has single integer parameter and no return value.

Convert acpi_evaluate_object() to acpi_execute_simple_method()
in drivers/platform/x86/intel-rst.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/intel-rst.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/intel-rst.c b/drivers/platform/x86/intel-rst.c
index 9385afd..fdf8ca0 100644
--- a/drivers/platform/x86/intel-rst.c
+++ b/drivers/platform/x86/intel-rst.c
@@ -54,8 +54,6 @@ static ssize_t irst_store_wakeup_events(struct device *dev,
 					const char *buf, size_t count)
 {
 	struct acpi_device *acpi;
-	struct acpi_object_list input;
-	union acpi_object param;
 	acpi_status status;
 	unsigned long value;
 	int error;
@@ -67,13 +65,7 @@ static ssize_t irst_store_wakeup_events(struct device *dev,
 	if (error)
 		return error;
 
-	param.type = ACPI_TYPE_INTEGER;
-	param.integer.value = value;
-
-	input.count = 1;
-	input.pointer = &param;
-
-	status = acpi_evaluate_object(acpi->handle, "SFFS", &input, NULL);
+	status = acpi_execute_simple_method(acpi->handle, "SFFS", value);
 
 	if (!ACPI_SUCCESS(status))
 		return -EINVAL;
@@ -116,8 +108,6 @@ static ssize_t irst_store_wakeup_time(struct device *dev,
 				      const char *buf, size_t count)
 {
 	struct acpi_device *acpi;
-	struct acpi_object_list input;
-	union acpi_object param;
 	acpi_status status;
 	unsigned long value;
 	int error;
@@ -129,13 +119,7 @@ static ssize_t irst_store_wakeup_time(struct device *dev,
 	if (error)
 		return error;
 
-	param.type = ACPI_TYPE_INTEGER;
-	param.integer.value = value;
-
-	input.count = 1;
-	input.pointer = &param;
-
-	status = acpi_evaluate_object(acpi->handle, "SFTV", &input, NULL);
+	status = acpi_execute_simple_method(acpi->handle, "SFTV", value);
 
 	if (!ACPI_SUCCESS(status))
 		return -EINVAL;
-- 
1.8.1.2

