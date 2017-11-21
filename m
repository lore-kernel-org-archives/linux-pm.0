From: raitosyo@gmail.com
Subject: [PATCH] power: supply: charger-manager: Fix typo in condition
Date: Tue, 21 Nov 2017 13:27:12 +0900
Message-ID: <20171121042712.3035-1-raitosyo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Ryosuke Saito <raitosyo@gmail.com>

Should be discharging_max_duration_ms, not charging_max_duration_ms.

Signed-off-by: Ryosuke Saito <raitosyo@gmail.com>
---
 drivers/power/supply/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 6502fa7..1de4b44 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -578,7 +578,7 @@ static int check_charging_duration(struct charger_manager *cm)
 	} else if (is_ext_pwr_online(cm) && !cm->charger_enabled) {
 		duration = curr - cm->charging_end_time;
 
-		if (duration > desc->charging_max_duration_ms &&
+		if (duration > desc->discharging_max_duration_ms &&
 				is_ext_pwr_online(cm)) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
-- 
2.9.5
