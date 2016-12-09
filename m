From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 3/8] power: supply: tps65217: Remove IRQ data from driver data
Date: Fri,  9 Dec 2016 16:49:01 +0900
Message-ID: <20161209074906.27545-4-woogyom.kim@gmail.com>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209074906.27545-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

IRQ number is only used on requesting the interrupt, so no need to keep
it inside the driver data.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 55371d6..482ee9f 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -48,8 +48,6 @@ struct tps65217_charger {
 	int	prev_ac_online;
 
 	struct task_struct	*poll_task;
-
-	int	irq;
 };
 
 static enum power_supply_property tps65217_ac_props[] = {
-- 
2.9.3
