From: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 1/4] thermal: send notifications for cdev state change
Date: Tue, 29 Mar 2016 17:41:34 -0700
Message-ID: <1459298497-29481-2-git-send-email-srikars@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459298497-29481-1-git-send-email-srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Send notifications using sysfs_notify to indicate that a cooling
device cur state has changed. This can alert the listeners that
hardware clocks are about to be throttled.

A listening user space application can use this notification to
perform workload throttling.

Change-Id: I71cd6d11bff87f181fa3b7db36bf6c953d1d77eb
Signed-off-by: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4b5465..b09fff1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1642,6 +1642,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	cdev->updated = true;
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
+	sysfs_notify(&cdev->device.kobj, NULL, "cur_state");
 }
 EXPORT_SYMBOL(thermal_cdev_update);
 
-- 
2.1.4
