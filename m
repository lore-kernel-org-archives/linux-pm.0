From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/2] power_supply: charger-manager: Add parent for power supply
Date: Tue, 19 May 2015 16:16:30 +0900
Message-ID: <1432019790-5664-3-git-send-email-k.kozlowski@samsung.com>
References: <1432019790-5664-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1432019790-5664-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

The 'parent' argument passed to power_supply_register() is now used to
postpone callbacks to the driver until the driver's probe end.

Pass current device from charger-manager to utilize that. This will move
created power supply from virtual to platform devices.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/charger-manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 0aed13f90891..1c202ccbd2a6 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1768,7 +1768,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
 
-	cm->charger_psy = power_supply_register(NULL, &cm->charger_psy_desc,
+	cm->charger_psy = power_supply_register(&pdev->dev,
+						&cm->charger_psy_desc,
 						&psy_cfg);
 	if (IS_ERR(cm->charger_psy)) {
 		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
-- 
1.9.1
