From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 2/3] bq24022: Keep track of gpio states
Date: Sun, 28 Aug 2011 15:09:23 +0200
Message-ID: <201108281509.24250.heiko@sntech.de>
References: <201108281507.35105.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108281507.35105.heiko@sntech.de>
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

gpio_get_value is not definied for output-gpios and can therefore not be
used for the is_enabled and get_current_limit methods of the bq24022.

This patch introduces a private struct to keep track of the values set.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/regulator/bq24022.c |   67 +++++++++++++++++++++++++++++-------------
 1 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/bq24022.c b/drivers/regulator/bq24022.c
index 973af08..b5a6755 100644
--- a/drivers/regulator/bq24022.c
+++ b/drivers/regulator/bq24022.c
@@ -15,56 +15,69 @@
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/regulator/bq24022.h>
 #include <linux/regulator/driver.h>
 
+struct bq24022 {
+	struct regulator_dev	*rdev;
+
+	int gpio_nce;
+	int gpio_iset2;
+
+	int state_nce;
+	int state_iset2;
+};
 
 static int bq24022_set_current_limit(struct regulator_dev *rdev,
 					int min_uA, int max_uA)
 {
-	struct bq24022_mach_info *pdata = rdev_get_drvdata(rdev);
+	struct bq24022 *bq = rdev_get_drvdata(rdev);
 
 	dev_dbg(rdev_get_dev(rdev), "setting current limit to %s mA\n",
 		max_uA >= 500000 ? "500" : "100");
 
 	/* REVISIT: maybe return error if min_uA != 0 ? */
-	gpio_set_value(pdata->gpio_iset2, max_uA >= 500000);
+	bq->state_iset2 = (max_uA >= 500000);
+	gpio_set_value(bq->gpio_iset2, bq->state_iset2);
 	return 0;
 }
 
 static int bq24022_get_current_limit(struct regulator_dev *rdev)
 {
-	struct bq24022_mach_info *pdata = rdev_get_drvdata(rdev);
+	struct bq24022 *bq = rdev_get_drvdata(rdev);
 
-	return gpio_get_value(pdata->gpio_iset2) ? 500000 : 100000;
+	return bq->state_iset2 ? 500000 : 100000;
 }
 
 static int bq24022_enable(struct regulator_dev *rdev)
 {
-	struct bq24022_mach_info *pdata = rdev_get_drvdata(rdev);
+	struct bq24022 *bq = rdev_get_drvdata(rdev);
 
 	dev_dbg(rdev_get_dev(rdev), "enabling charger\n");
 
-	gpio_set_value(pdata->gpio_nce, 0);
+	gpio_set_value(bq->gpio_nce, 0);
+	bq->state_nce = 0;
 	return 0;
 }
 
 static int bq24022_disable(struct regulator_dev *rdev)
 {
-	struct bq24022_mach_info *pdata = rdev_get_drvdata(rdev);
+	struct bq24022 *bq = rdev_get_drvdata(rdev);
 
 	dev_dbg(rdev_get_dev(rdev), "disabling charger\n");
 
-	gpio_set_value(pdata->gpio_nce, 1);
+	gpio_set_value(bq->gpio_nce, 1);
+	bq->state_nce = 1;
 	return 0;
 }
 
 static int bq24022_is_enabled(struct regulator_dev *rdev)
 {
-	struct bq24022_mach_info *pdata = rdev_get_drvdata(rdev);
+	struct bq24022 *bq = rdev_get_drvdata(rdev);
 
-	return !gpio_get_value(pdata->gpio_nce);
+	return !bq->state_nce;
 }
 
 static struct regulator_ops bq24022_ops = {
@@ -85,12 +98,18 @@ static struct regulator_desc bq24022_desc = {
 static int __init bq24022_probe(struct platform_device *pdev)
 {
 	struct bq24022_mach_info *pdata = pdev->dev.platform_data;
-	struct regulator_dev *bq24022;
+	struct bq24022 *bq;
 	int ret;
 
 	if (!pdata || !pdata->gpio_nce || !pdata->gpio_iset2)
 		return -EINVAL;
 
+	bq = kzalloc(sizeof(struct bq24022), GFP_KERNEL);
+	if (!bq) {
+		dev_err(&pdev->dev, "cannot allocate memory\n");
+		return -ENOMEM;
+	}
+
 	ret = gpio_request(pdata->gpio_nce, "ncharge_en");
 	if (ret) {
 		dev_dbg(&pdev->dev, "couldn't request nCE GPIO: %d\n",
@@ -103,27 +122,32 @@ static int __init bq24022_probe(struct platform_device *pdev)
 			pdata->gpio_iset2);
 		goto err_iset2;
 	}
+
+	/* set initial current to 100mA and disable regulator */
 	ret = gpio_direction_output(pdata->gpio_iset2, 0);
 	if (ret) {
 		dev_dbg(&pdev->dev, "couldn't set ISET2 GPIO: %d\n",
 			pdata->gpio_iset2);
 		goto err_reg;
 	}
+	bq->gpio_iset2  = pdata->gpio_iset2;
 	ret = gpio_direction_output(pdata->gpio_nce, 1);
 	if (ret) {
 		dev_dbg(&pdev->dev, "couldn't set nCE GPIO: %d\n",
 			pdata->gpio_nce);
 		goto err_reg;
 	}
+	bq->gpio_nce  = pdata->gpio_nce;
+	bq->state_nce = 1;
 
-	bq24022 = regulator_register(&bq24022_desc, &pdev->dev,
-				     pdata->init_data, pdata);
-	if (IS_ERR(bq24022)) {
+	bq->rdev = regulator_register(&bq24022_desc, &pdev->dev,
+				     pdata->init_data, bq);
+	if (IS_ERR(bq->rdev)) {
 		dev_dbg(&pdev->dev, "couldn't register regulator\n");
-		ret = PTR_ERR(bq24022);
+		ret = PTR_ERR(bq->rdev);
 		goto err_reg;
 	}
-	platform_set_drvdata(pdev, bq24022);
+	platform_set_drvdata(pdev, bq);
 	dev_dbg(&pdev->dev, "registered regulator\n");
 
 	return 0;
@@ -137,12 +161,13 @@ err_ce:
 
 static int __devexit bq24022_remove(struct platform_device *pdev)
 {
-	struct bq24022_mach_info *pdata = pdev->dev.platform_data;
-	struct regulator_dev *bq24022 = platform_get_drvdata(pdev);
+	struct bq24022 *bq = platform_get_drvdata(pdev);
 
-	regulator_unregister(bq24022);
-	gpio_free(pdata->gpio_iset2);
-	gpio_free(pdata->gpio_nce);
+	regulator_unregister(bq->rdev);
+	gpio_free(bq->gpio_iset2);
+	gpio_free(bq->gpio_nce);
+
+	kfree(bq);
 
 	return 0;
 }
-- 
1.7.2.3
