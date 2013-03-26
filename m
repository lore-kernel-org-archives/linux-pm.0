From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 2/5] Thermal: thermal framework registration failure case cleanup
Date: Wed, 27 Mar 2013 00:26:06 +0800
Message-ID: <1364315169-15427-3-git-send-email-rui.zhang@intel.com>
References: <1364315169-15427-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364315169-15427-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: amit.daniel@samsung.com, durgadoss.r@intel.com, andi@lisas.de, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5b7863a..845ed6e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1863,13 +1863,9 @@ static int __init thermal_init(void)
 	int result = 0;
 
 	result = class_register(&thermal_class);
-	if (result) {
-		idr_destroy(&thermal_tz_idr);
-		idr_destroy(&thermal_cdev_idr);
-		mutex_destroy(&thermal_idr_lock);
-		mutex_destroy(&thermal_list_lock);
+	if (result)
 		return result;
-	}
+
 	result = genetlink_init();
 	return result;
 }
@@ -1877,10 +1873,6 @@ static int __init thermal_init(void)
 static void __exit thermal_exit(void)
 {
 	class_unregister(&thermal_class);
-	idr_destroy(&thermal_tz_idr);
-	idr_destroy(&thermal_cdev_idr);
-	mutex_destroy(&thermal_idr_lock);
-	mutex_destroy(&thermal_list_lock);
 	genetlink_exit();
 }
 
-- 
1.7.9.5
