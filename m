From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI/thermal : Remove zone disabled warning
Date: Wed, 25 Sep 2013 09:29:50 -0700
Message-ID: <1380126590-25809-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13634 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712Ab3IYQaP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Sep 2013 12:30:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: eduardo.valentin@ti.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Once thermal zone is disabled to move thermal control to user space,
too many warnings printed in logs. Remove pr_warn from this path,
instead warn when user mode issues request to disable thermal zone.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 6a03293..92bebb9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -515,10 +515,9 @@ static void acpi_thermal_check(void *data)
 {
 	struct acpi_thermal *tz = data;
 
-	if (!tz->tz_enabled) {
-		pr_warn("thermal zone is disabled \n");
+	if (!tz->tz_enabled)
 		return;
-	}
+
 	thermal_zone_device_update(tz->thermal_zone);
 }
 
@@ -570,9 +569,10 @@ static int thermal_set_mode(struct thermal_zone_device *thermal,
 	 */
 	if (mode == THERMAL_DEVICE_ENABLED)
 		enable = 1;
-	else if (mode == THERMAL_DEVICE_DISABLED)
+	else if (mode == THERMAL_DEVICE_DISABLED) {
 		enable = 0;
-	else
+		pr_warn("thermal zone will be disabled\n");
+	} else
 		return -EINVAL;
 
 	if (enable != tz->tz_enabled) {
-- 
1.8.3.1

