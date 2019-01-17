From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] power: supply: core: remove duplicated include from power_supply_core.c
Date: Thu, 17 Jan 2019 15:11:43 +0800
Message-ID: <20190117071143.14652-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sebastian.reichel@collabora.com, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-pm@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/power/supply/power_supply_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 569790e..07a85e1 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -156,8 +156,6 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 }
 
 #ifdef CONFIG_OF
-#include <linux/of.h>
-
 static int __power_supply_populate_supplied_from(struct device *dev,
 						 void *data)
 {
-- 
2.7.0
