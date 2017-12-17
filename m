From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] abx500_chargalg: Delete an error message for a failed memory
 allocation in abx500_chargalg_probe()
Date: Sun, 17 Dec 2017 22:08:12 +0100
Message-ID: <b16d7d4b-df0d-a4ce-f5fd-e4e2ab3d38c4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 17 Dec 2017 22:02:11 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/abx500_chargalg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index a4411d6bbc96..5340421014c9 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -2054,10 +2054,8 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
-	if (!di) {
-		dev_err(&pdev->dev, "%s no mem for ab8500_chargalg\n", __func__);
+	if (!di)
 		return -ENOMEM;
-	}
 
 	if (!plat) {
 		dev_err(&pdev->dev, "no battery management data supplied\n");
-- 
2.15.1

