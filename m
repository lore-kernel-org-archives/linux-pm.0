From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 16/27] intel_menlow: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:04 +0800
Message-ID: <1378168335-22556-17-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41893 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759251Ab3ICAbg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:36 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/platform/x86/intel_menlow.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Matthew Garrett <matthew.garrett@nebula.com>
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/intel_menlow.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index d6cfc15..11244f8 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -156,19 +156,15 @@ static struct thermal_cooling_device_ops memory_cooling_ops = {
 static int intel_menlow_memory_add(struct acpi_device *device)
 {
 	int result = -ENODEV;
-	acpi_status status = AE_OK;
-	acpi_handle dummy;
 	struct thermal_cooling_device *cdev;
 
 	if (!device)
 		return -EINVAL;
 
-	status = acpi_get_handle(device->handle, MEMORY_GET_BANDWIDTH, &dummy);
-	if (ACPI_FAILURE(status))
+	if (!acpi_has_method(device->handle, MEMORY_GET_BANDWIDTH))
 		goto end;
 
-	status = acpi_get_handle(device->handle, MEMORY_SET_BANDWIDTH, &dummy);
-	if (ACPI_FAILURE(status))
+	if (!acpi_has_method(device->handle, MEMORY_SET_BANDWIDTH))
 		goto end;
 
 	cdev = thermal_cooling_device_register("Memory controller", device,
-- 
1.8.1.2

