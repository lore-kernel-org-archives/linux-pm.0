From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI: processor thermal cooling device regression
Date: Wed, 16 Dec 2015 20:32:23 -0800
Message-ID: <1450326743-9460-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27531 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbbLQEee (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Dec 2015 23:34:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org
Cc: len.brown@intel.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The processor cooling device is no longer present for passive thermal
control. The change
commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor driver")
moved the processing to a new function acpi_pss_perf_init, but
missing "return 0" after successful creation. This causes the error
handling functions to be called, which will delete the previously
created processor cooling device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/processor_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index f4e02ae..11154a3 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -200,7 +200,8 @@ static int acpi_pss_perf_init(struct acpi_processor *pr,
 		goto err_remove_sysfs_thermal;
 	}
 
-	sysfs_remove_link(&pr->cdev->device.kobj, "device");
+	return 0;
+
  err_remove_sysfs_thermal:
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
  err_thermal_unregister:
-- 
2.4.3

