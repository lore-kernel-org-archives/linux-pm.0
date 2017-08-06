From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] power: supply: charger-manager: Slighly simplify code
Date: Mon,  7 Aug 2017 00:37:57 +0200
Message-ID: <4cf75823640aa667fc050e75b7a86a62aa2bdaa6.1502058761.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

Use 'sizeof(*var)' instead of the equivalent 'sizeof(data structure type)'
because it is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/charger-manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 83c08c8e2c32..6502fa7c2106 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1632,8 +1632,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	cm = devm_kzalloc(&pdev->dev,
-			sizeof(struct charger_manager),	GFP_KERNEL);
+	cm = devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);
 	if (!cm)
 		return -ENOMEM;
 
-- 
2.11.0
