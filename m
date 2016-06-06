From: Rhyland Klein <rklein@nvidia.com>
Subject: [RESEND PATCH] thermal: helpers: Check return value of get_temp
Date: Mon, 6 Jun 2016 12:53:39 -0400
Message-ID: <1465232019-12441-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>
List-Id: linux-pm@vger.kernel.org

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
