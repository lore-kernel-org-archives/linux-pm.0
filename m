From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] power: ab8500_btemp: use builtin_platform_driver
Date: Wed, 23 Nov 2016 22:56:52 +0800
Message-ID: <e9ca1fc1443a01e115a7603b7c6584dc3235fd76.1479912980.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/power/supply/ab8500_btemp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 6ffdc18..f925e50 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -1193,17 +1193,12 @@ static struct platform_driver ab8500_btemp_driver = {
 	},
 };
 
-static int __init ab8500_btemp_init(void)
-{
-	return platform_driver_register(&ab8500_btemp_driver);
-}
-
 static void __exit ab8500_btemp_exit(void)
 {
 	platform_driver_unregister(&ab8500_btemp_driver);
 }
 
-device_initcall(ab8500_btemp_init);
+builtin_platform_driver(ab8500_btemp_driver);
 module_exit(ab8500_btemp_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
2.9.3
