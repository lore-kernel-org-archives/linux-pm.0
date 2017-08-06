From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] power: supply: charger-manager: Fix a comment
Date: Mon,  7 Aug 2017 00:37:56 +0200
Message-ID: <f7c303456f991c6bfcafb56045bb1b5698cc0315.1502058761.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

Update a comment which is no more up to date since commit
2ed9e9b653095.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/charger-manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 52a49857e20f..83c08c8e2c32 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1651,8 +1651,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * The following two do not need to be errors.
-	 * Users may intentionally ignore those two features.
+	 * Some of the following do not need to be errors.
+	 * Users may intentionally ignore those features.
 	 */
 	if (desc->fullbatt_uV == 0) {
 		dev_info(&pdev->dev, "Ignoring full-battery voltage threshold as it is not supplied\n");
-- 
2.11.0
