From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] power: supply: remove some duplicated includes
Date: Wed, 26 Dec 2018 11:53:57 -0500
Message-ID: <20181226165357.6426-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

We include of.h twice. It's unnecessary,so
just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index e85361878450..529721660e68 100644
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
2.17.0
