From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Subject: [PATCH] Thermal/int340x: Fix few typos and kernel warn message
Date: Fri,  4 Aug 2017 23:43:49 +0530
Message-ID: <1501870429-10812-1-git-send-email-sumeet.r.pawnikar@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:50308 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdHDSM7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Aug 2017 14:12:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com, sumeet.r.pawnikar@intel.com

This patch fix the few typos in trt structure. Also, update
kernel warn message for failed to get device name from acpi
handle.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c |    2 +-
 drivers/thermal/int340x_thermal/acpi_thermal_rel.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
index 51ceb80..c719167 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -228,7 +228,7 @@ static void get_single_name(acpi_handle handle, char *name)
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER};
 
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)))
-		pr_warn("Failed get name from handle\n");
+		pr_warn("Failed to get device name from acpi handle\n");
 	else {
 		memcpy(name, buffer.pointer, ACPI_NAME_SIZE);
 		kfree(buffer.pointer);
diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.h b/drivers/thermal/int340x_thermal/acpi_thermal_rel.h
index f00700b..65075b1 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.h
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.h
@@ -34,10 +34,10 @@ struct trt {
 	acpi_handle target;
 	u64 influence;
 	u64 sample_period;
-	u64 reverved1;
-	u64 reverved2;
-	u64 reverved3;
-	u64 reverved4;
+	u64 reserved1;
+	u64 reserved2;
+	u64 reserved3;
+	u64 reserved4;
 } __packed;
 
 #define ACPI_NR_ART_ELEMENTS 13
-- 
1.7.9.5
