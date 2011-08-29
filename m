From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 2/4] bq24022: Use dev_err instead of dev_dbg for
	error messages
Date: Mon, 29 Aug 2011 17:57:29 +0200
Message-ID: <201108291757.30189.heiko@sntech.de>
References: <201108291755.15701.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108291755.15701.heiko@sntech.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-pm@lists.linux-foundation.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: linux-pm@vger.kernel.org

This makes error messages visible to the user,
so he/she can eventually fix them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/regulator/bq24022.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/bq24022.c b/drivers/regulator/bq24022.c
index 56627d7..7bd906c 100644
--- a/drivers/regulator/bq24022.c
+++ b/drivers/regulator/bq24022.c
@@ -93,13 +93,13 @@ static int __init bq24022_probe(struct platform_device *pdev)
 
 	ret = gpio_request(pdata->gpio_nce, "ncharge_en");
 	if (ret) {
-		dev_dbg(&pdev->dev, "couldn't request nCE GPIO: %d\n",
+		dev_err(&pdev->dev, "couldn't request nCE GPIO: %d\n",
 			pdata->gpio_nce);
 		goto err_ce;
 	}
 	ret = gpio_request(pdata->gpio_iset2, "charge_mode");
 	if (ret) {
-		dev_dbg(&pdev->dev, "couldn't request ISET2 GPIO: %d\n",
+		dev_err(&pdev->dev, "couldn't request ISET2 GPIO: %d\n",
 			pdata->gpio_iset2);
 		goto err_iset2;
 	}
@@ -119,7 +119,7 @@ static int __init bq24022_probe(struct platform_device *pdev)
 	bq24022 = regulator_register(&bq24022_desc, &pdev->dev,
 				     pdata->init_data, pdata);
 	if (IS_ERR(bq24022)) {
-		dev_dbg(&pdev->dev, "couldn't register regulator\n");
+		dev_err(&pdev->dev, "couldn't register regulator\n");
 		ret = PTR_ERR(bq24022);
 		goto err_reg;
 	}
-- 
1.7.2.3
