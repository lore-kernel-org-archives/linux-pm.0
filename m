From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] Thermal/int340x/int3403: Free acpi notification handler
Date: Tue, 23 Dec 2014 15:23:36 -0800
Message-ID: <1419377016-13688-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1419377016-13688-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44063 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbaLWXYN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 18:24:13 -0500
In-Reply-To: <1419377016-13688-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Remove acpi notification handler when zone is removed.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index 2ee7fd8..1431cb3 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -302,6 +302,8 @@ static int int3403_sensor_remove(struct int3403_priv *priv)
 {
 	struct int3403_sensor *obj = priv->priv;
 
+	acpi_remove_notify_handler(priv->adev->handle,
+				   ACPI_DEVICE_NOTIFY, int3403_notify);
 	thermal_zone_device_unregister(obj->tzone);
 	return 0;
 }
-- 
1.9.3

