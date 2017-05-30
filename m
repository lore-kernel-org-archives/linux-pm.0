From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Subject: [PATCH] Thermal/int340x: Fix few typos and kernel-doc style
Date: Tue, 30 May 2017 23:14:58 +0530
Message-ID: <1496166298-17125-1-git-send-email-sumeet.r.pawnikar@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20174 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbdE3RoN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 May 2017 13:44:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

This patch fix the few typos in function header of
acpi_parse_trt. Also, fix the typo in kernel debug
message for acpi_parse_art.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
index 2c2ec76..51ceb80 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -62,8 +62,8 @@ static int acpi_thermal_rel_release(struct inode *inode, struct file *file)
  * acpi_parse_trt - Thermal Relationship Table _TRT for passive cooling
  *
  * @handle: ACPI handle of the device contains _TRT
- * @art_count: the number of valid entries resulted from parsing _TRT
- * @artp: pointer to pointer of array of art entries in parsing result
+ * @trt_count: the number of valid entries resulted from parsing _TRT
+ * @trtp: pointer to pointer of array of _TRT entries in parsing result
  * @create_dev: whether to create platform devices for target and source
  *
  */
@@ -208,7 +208,7 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
 		if (art->target) {
 			result = acpi_bus_get_device(art->target, &adev);
 			if (result)
-				pr_warn("Failed to get source ACPI device\n");
+				pr_warn("Failed to get target ACPI device\n");
 		}
 	}
 
-- 
1.7.9.5
