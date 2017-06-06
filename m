From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: check for sensor when PTYP is missing
Date: Tue,  6 Jun 2017 16:00:41 -0700
Message-ID: <1496790041-104500-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25225 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbdFFXAw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jun 2017 19:00:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

For INT3403 sensor PTYP field is mandatory. But some platforms didn't
have this field for sensors. This cause load failure for int3403 driver.

This change checks for the presence of _TMP method and if present, then
treats this device as a sensor.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index c4890c9..8a7f24d 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -238,8 +238,16 @@ static int int3403_add(struct platform_device *pdev)
 	status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
 				       NULL, &priv->type);
 	if (ACPI_FAILURE(status)) {
-		result = -EINVAL;
-		goto err;
+		unsigned long long tmp;
+
+		status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
+					       NULL, &tmp);
+		if (ACPI_FAILURE(status)) {
+			result = -EINVAL;
+			goto err;
+		} else {
+			priv->type = INT3403_TYPE_SENSOR;
+		}
 	}
 
 	platform_set_drvdata(pdev, priv);
-- 
2.7.4
