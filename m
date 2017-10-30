From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] max8997_charger: Improve a size determination in
 max8997_battery_probe()
Date: Mon, 30 Oct 2017 22:36:44 +0100
Message-ID: <47b1573e-6f12-6949-e330-7dbe7a39c60c@users.sourceforge.net>
References: <286b1fea-ccff-5fed-5e2d-fc3b0064cd4d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <286b1fea-ccff-5fed-5e2d-fc3b0064cd4d@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 30 Oct 2017 22:22:54 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/max8997_charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 38a01706a56b..1de0e74b7dea 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -142,8 +142,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto report_bus_failure;
 
-	charger = devm_kzalloc(&pdev->dev, sizeof(struct charger_data),
-				GFP_KERNEL);
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
 	if (!charger)
 		return -ENOMEM;
 
-- 
2.14.3
