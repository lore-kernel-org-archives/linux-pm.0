From: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Subject: [PATCH 1/2] Thermal/int340x: Clear the error value of the last acpi_bus_get_device() call
Date: Mon,  8 Dec 2014 18:01:31 -0800
Message-ID: <1418090492-87508-2-git-send-email-ilkka.koskinen@linux.intel.com>
References: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55255 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261AbaLICEs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Dec 2014 21:04:48 -0500
In-Reply-To: <1418090492-87508-1-git-send-email-ilkka.koskinen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: ilkka.koskinen@linux.intel.com, rui.zhang@intel.com, edubezval@gmail.com, jacob.jun.pan@linux.intel.com

Previously the return value of the last acpi_bus_get_device() was
returned. However, since we only report those issues, it should be
cleared to continue as expected.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
index ac5c405..e4e61b3 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -131,6 +131,8 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
 			pr_warn("Failed to get target ACPI device\n");
 	}
 
+	result = 0;
+
 	*trtp = trts;
 	/* don't count bad entries */
 	*trt_count -= nr_bad_entries;
-- 
1.9.1

