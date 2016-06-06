From: Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH 1/2] thermal: helpers: Check return value of get_temp
Date: Mon, 6 Jun 2016 12:50:23 -0400
Message-ID: <1465231823-12384-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14055 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbcFFQv7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 12:51:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>

Check the return value of get_temp, which can fail. If it does, then
unlock and return the error code.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 drivers/thermal/thermal_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 5e1c160944c9..dc260749f8d6 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -90,6 +90,10 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	mutex_lock(&tz->lock);
 
 	ret = tz->ops->get_temp(tz, temp);
+	if (!ret) {
+		mutex_unlock(&tz->lock);
+		goto exit;
+	}
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
 		for (count = 0; count < tz->trips; count++) {
-- 
1.9.1

