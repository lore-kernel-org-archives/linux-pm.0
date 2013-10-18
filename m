From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] thermal: Fix binding problem when there is thermal zone params
Date: Fri, 18 Oct 2013 18:03:06 +0800
Message-ID: <1382090587-9602-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jinyoung Park <jinyoungp-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The thermal zone params can be used to set governor
to specific thermal governor for thermal zone device.
But if the thermal zone params has only governor name
without thermal bind params, then the thermal zone device
will not be binding to cooling device. Because tz->ops->bind
operator is not invoked in bind_tz() and bind_cdev() when
there is thermal zone params.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Jinyoung Park <jinyoungp-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/thermal_core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4962a6a..2ea41d3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -247,7 +247,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 		if (!pos->tzp && !pos->ops->bind)
 			continue;
 
-		if (!pos->tzp && pos->ops->bind) {
+		if (pos->ops->bind) {
 			ret = pos->ops->bind(pos, cdev);
 			if (ret)
 				print_bind_err_msg(pos, cdev, ret);
@@ -282,8 +282,8 @@ static void bind_tz(struct thermal_zone_device *tz)
 
 	mutex_lock(&thermal_list_lock);
 
-	/* If there is no platform data, try to use ops->bind */
-	if (!tzp && tz->ops->bind) {
+	/* If there is ops->bind, try to use ops->bind */
+	if (tz->ops->bind) {
 		list_for_each_entry(pos, &thermal_cdev_list, node) {
 			ret = tz->ops->bind(tz, pos);
 			if (ret)
-- 
1.7.9.5
