From: Yao Dongdong <yaodongdong@huawei.com>
Subject: [PATCH 2/2 resend] Thermal:Remove usless if(!result) before return tz
Date: Tue, 28 Oct 2014 07:40:25 +0000
Message-ID: <1414482025-4482-2-git-send-email-yaodongdong@huawei.com>
References: <1414482025-4482-1-git-send-email-yaodongdong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414482025-4482-1-git-send-email-yaodongdong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lizefan@huawei.com
List-Id: linux-pm@vger.kernel.org

result is always zero when comes here.

Signed-off-by: Yao Dongdong <yaodongdong@huawei.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d358605..a438c95 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1575,8 +1575,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	thermal_zone_device_update(tz);
 
-	if (!result)
-		return tz;
+	return tz;
 
 unregister:
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
-- 
1.8.3.4
