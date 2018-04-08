From: srplinux2008 <srplinux2008@gmail.com>
Subject: [PATCH] thermal: tegra: soctherm: add const to struct thermal_cooling_device_ops
Date: Sun,  8 Apr 2018 17:31:45 +0530
Message-ID: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, srplinux2008@gmail.com
List-Id: linux-pm@vger.kernel.org

From: srp linux <srplinux2008@gmail.com>

Correct the typecast with const to struct thermal_cooling_device_ops.
It is the last argument to the function thermal_of_cooling_device_register
and this argument is of type const. So, declare this structure
thermal_cooling_device_ops as constant.

Signed-off-by: srp linux <srplinux2008@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 455b58c..72da745 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -926,7 +926,7 @@ static int throt_set_cdev_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static struct thermal_cooling_device_ops throt_cooling_ops = {
+static const struct thermal_cooling_device_ops throt_cooling_ops = {
 	.get_max_state = throt_get_cdev_max_state,
 	.get_cur_state = throt_get_cdev_cur_state,
 	.set_cur_state = throt_set_cdev_state,
-- 
2.7.4
