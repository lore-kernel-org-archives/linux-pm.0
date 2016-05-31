From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 35/48] thermal: core: add inline to print_bind_err_msg()
Date: Mon, 30 May 2016 23:18:42 -0700
Message-ID: <1464675535-2433-36-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Given that this is simple wrapper, adding the inline flag.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 460220c..c1908c4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -771,8 +771,9 @@ static struct class thermal_class = {
 	.dev_release = thermal_release,
 };
 
-static void print_bind_err_msg(struct thermal_zone_device *tz,
-			       struct thermal_cooling_device *cdev, int ret)
+static inline
+void print_bind_err_msg(struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
 		tz->type, cdev->type, ret);
-- 
2.1.4
