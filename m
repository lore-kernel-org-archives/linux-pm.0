From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 19/33] thermal: db8500: use match_string() helper
Date: Mon, 21 May 2018 19:57:56 +0800
Message-ID: <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Yisheng Xie <xieyisheng1@huawei.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/thermal/db8500_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index f491faf..dd83614 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -50,12 +50,10 @@ static int db8500_thermal_match_cdev(struct thermal_cooling_device *cdev,
 	if (!strlen(cdev->type))
 		return -EINVAL;
 
-	for (i = 0; i < COOLING_DEV_MAX; i++) {
-		if (!strcmp(trip_point->cdev_name[i], cdev->type))
-			return 0;
-	}
+	i = match_string((const char **)trip_point->cdev_name,
+			 COOLING_DEV_MAX, cdev->type);
 
-	return -ENODEV;
+	return (i < 0) ? -ENODEV : 0;
 }
 
 /* Callback to bind cooling device to thermal zone */
-- 
1.7.12.4
