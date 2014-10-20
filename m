From: Yao Dongdong <yaodongdong@huawei.com>
Subject: [PATCH 2/2] Thermal:Remove usless if(!result) before return tz
Date: Mon, 20 Oct 2014 16:27:59 +0800
Message-ID: <5444C78F.10404@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, yaodongdong@huawei.com
List-Id: linux-pm@vger.kernel.org

result is always zero when comes here.

Signed-off-by:yaodongdong@huawei.com

---
 drivers/thermal/thermal_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5b7d466..19cac8e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1568,8 +1568,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,

    thermal_zone_device_update(tz);

-   if (!result)
-       return tz;
+   return tz;

 unregister:
    release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
--
1.8.0.1
