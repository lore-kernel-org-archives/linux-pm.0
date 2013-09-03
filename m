From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 21/27] acpi_processor: convert acpi_evaluate_object() to acpi_evaluate_integer()
Date: Tue,  3 Sep 2013 08:32:09 +0800
Message-ID: <1378168335-22556-22-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42466 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759207Ab3ICAbi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:38 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

acpi_evaluate_integer() is an ACPI API introduced to evaluate an
ACPI control method that is known to have an integer return value.
This API can simplify the code because the calling function does not need to
use the specified acpi_buffer structure required by acpi_evaluate_object();

Convert acpi_evaluate_object() to acpi_evaluate_integer()
in drivers/acpi/acpi_processor.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_processor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index f29e06e..357abdc 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -219,6 +219,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	int cpu_index, device_declaration = 0;
 	acpi_status status = AE_OK;
 	static int cpu0_initialized;
+	unsigned long long value;
 
 	if (num_online_cpus() > 1)
 		errata.smp = TRUE;
@@ -258,7 +259,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		 * Declared with "Device" statement; match _UID.
 		 * Note that we don't handle string _UIDs yet.
 		 */
-		unsigned long long value;
 		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
 						NULL, &value);
 		if (ACPI_FAILURE(status)) {
@@ -332,9 +332,9 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 * ensure we get the right value in the "physical id" field
 	 * of /proc/cpuinfo
 	 */
-	status = acpi_evaluate_object(pr->handle, "_SUN", NULL, &buffer);
+	status = acpi_evaluate_integer(pr->handle, "_SUN", NULL, &value);
 	if (ACPI_SUCCESS(status))
-		arch_fix_phys_package_id(pr->id, object.integer.value);
+		arch_fix_phys_package_id(pr->id, value);
 
 	return 0;
 }
-- 
1.8.1.2

