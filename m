From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/6] power: supply: charger-manager: Remove unused index counting
Date: Fri, 16 Nov 2018 19:01:08 +0800
Message-ID: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

Remove unused index counting.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index faa1a67..a1b420a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1687,10 +1687,6 @@ static int charger_manager_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Counting index only */
-	while (desc->psy_charger_stat[i])
-		i++;
-
 	/* Check if charger's supplies are present at probe */
 	for (i = 0; desc->psy_charger_stat[i]; i++) {
 		struct power_supply *psy;
-- 
1.7.9.5
