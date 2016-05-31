From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 29/48] thermal: core: small style fix on __unbind() helper
Date: Mon, 30 May 2016 23:18:36 -0700
Message-ID: <1464675535-2433-30-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply aligning to parenthesis.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e77e6d1..261cc16 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -320,7 +320,7 @@ static void __bind(struct thermal_zone_device *tz, int mask,
 }
 
 static void __unbind(struct thermal_zone_device *tz, int mask,
-			struct thermal_cooling_device *cdev)
+		     struct thermal_cooling_device *cdev)
 {
 	int i;
 
-- 
2.1.4
