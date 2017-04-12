From: Brian Bian <brian.bian@intel.com>
Subject: [PATCH] Thermal: Intel SoC DTS: Change interrupt request behavior
Date: Wed, 12 Apr 2017 14:07:17 -0700
Message-ID: <1492031237-27387-1-git-send-email-brian.bian@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:29585 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755137AbdDLVQH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 17:16:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Brian Bian <brian.bian@intel.com>

The interrupt request call in Intel SoC DTS driver may fail if
there is no underlying BIOS support. However, the user space
thermal daemon can still use the thermal zones created by the
SoC DTS driver in polling mode, therefore, instead of bailing
out on interrupt request failures, it is better just to log
a warning message and continue the init process.

Signed-off-by: Brian Bian <brian.bian@intel.com>
---
 drivers/thermal/intel_soc_dts_thermal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel_soc_dts_thermal.c b/drivers/thermal/intel_soc_dts_thermal.c
index b2bbaa1c60b0..c27868b2c6af 100644
--- a/drivers/thermal/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel_soc_dts_thermal.c
@@ -73,8 +73,12 @@ static int __init intel_soc_thermal_init(void)
 					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					   "soc_dts", soc_dts);
 		if (err) {
-			pr_err("request_threaded_irq ret %d\n", err);
-			goto error_irq;
+			/*
+			 * Do not just error out because the user space thermal
+			 * daemon such as DPTF may use polling instead of being
+			 * interrupt driven.
+			 */
+			pr_warn("request_threaded_irq ret %d\n", err);
 		}
 	}
 
@@ -88,7 +92,6 @@ static int __init intel_soc_thermal_init(void)
 error_trips:
 	if (soc_dts_thres_irq)
 		free_irq(soc_dts_thres_irq, soc_dts);
-error_irq:
 	intel_soc_dts_iosf_exit(soc_dts);
 
 	return err;
-- 
2.7.4
