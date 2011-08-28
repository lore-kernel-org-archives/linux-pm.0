From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 3/3] bq24022: Add support for the bq2407x family
Date: Sun, 28 Aug 2011 15:10:09 +0200
Message-ID: <201108281510.10224.heiko@sntech.de>
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

The bq2407x family of charger ICs simply supports another machine
specific charging current above 500mA. To use this setting a
second gpio pin is used while the rest of the pins stay the same.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/regulator/Kconfig         |    7 ++--
 drivers/regulator/bq24022.c       |   65 ++++++++++++++++++++++++++++++++++---
 include/linux/regulator/bq24022.h |    7 ++++
 3 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c7fd2c0..546a7a6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -67,10 +67,11 @@ config REGULATOR_USERSPACE_CONSUMER
 config REGULATOR_BQ24022
 	tristate "TI bq24022 Dual Input 1-Cell Li-Ion Charger IC"
 	help
-	  This driver controls a TI bq24022 Charger attached via
-	  GPIOs. The provided current regulator can enable/disable
+	  This driver controls a TI bq24022 or bq2407x Charger attached
+	  via GPIOs. The provided current regulator can enable/disable
 	  charging select between 100 mA and 500 mA charging current
-	  limit.
+	  limit. The bq2407x family also supports a machine specific
+	  current limit above 500 mA.
 
 config REGULATOR_MAX1586
 	tristate "Maxim 1586/1587 voltage regulator"
diff --git a/drivers/regulator/bq24022.c b/drivers/regulator/bq24022.c
index b5a6755..ad6942a 100644
--- a/drivers/regulator/bq24022.c
+++ b/drivers/regulator/bq24022.c
@@ -19,15 +19,20 @@
 #include <linux/gpio.h>
 #include <linux/regulator/bq24022.h>
 #include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 
 struct bq24022 {
 	struct regulator_dev	*rdev;
 
 	int gpio_nce;
 	int gpio_iset2;
+	int gpio_2407x_en2;
 
 	int state_nce;
 	int state_iset2;
+	int state_2407x_en2;
+
+	int max_uA;
 };
 
 static int bq24022_set_current_limit(struct regulator_dev *rdev,
@@ -35,12 +40,30 @@ static int bq24022_set_current_limit(struct regulator_dev *rdev,
 {
 	struct bq24022 *bq = rdev_get_drvdata(rdev);
 
-	dev_dbg(rdev_get_dev(rdev), "setting current limit to %s mA\n",
-		max_uA >= 500000 ? "500" : "100");
+	if (bq->max_uA && bq->max_uA > 500000
+			&& max_uA >= bq->max_uA && bq->gpio_2407x_en2) {
+		dev_dbg(rdev_get_dev(rdev),
+			"setting current limit to %d mA\n",
+			bq->max_uA / 1000);
+		gpio_set_value(bq->gpio_2407x_en2, 1);
+		bq->state_2407x_en2 = 1;
+		gpio_set_value(bq->gpio_iset2, 0);
+		bq->state_iset2 = 0;
+	} else if (max_uA >= 100000) {
+		dev_dbg(rdev_get_dev(rdev), "setting current limit to %s mA\n",
+			max_uA >= 500000 ? "500" : "100");
+		if (bq->gpio_2407x_en2) {
+			gpio_set_value(bq->gpio_2407x_en2, 0);
+			bq->state_2407x_en2 = 0;
+		}
+		bq->state_iset2 = (max_uA >= 500000);
+		gpio_set_value(bq->gpio_iset2, bq->state_iset2);
+	} else {
+		dev_err(rdev_get_dev(rdev), "cannot set current limit below 100 mA\n");
+		return -EINVAL;
+	}
 
 	/* REVISIT: maybe return error if min_uA != 0 ? */
-	bq->state_iset2 = (max_uA >= 500000);
-	gpio_set_value(bq->gpio_iset2, bq->state_iset2);
 	return 0;
 }
 
@@ -48,7 +71,10 @@ static int bq24022_get_current_limit(struct regulator_dev *rdev)
 {
 	struct bq24022 *bq = rdev_get_drvdata(rdev);
 
-	return bq->state_iset2 ? 500000 : 100000;
+	if (bq->state_2407x_en2)
+		return bq->state_iset2 ? 0 : bq->max_uA;
+	else
+		return bq->state_iset2 ? 500000 : 100000;
 }
 
 static int bq24022_enable(struct regulator_dev *rdev)
@@ -122,8 +148,25 @@ static int __init bq24022_probe(struct platform_device *pdev)
 			pdata->gpio_iset2);
 		goto err_iset2;
 	}
+	if (pdata->gpio_2407x_en2) {
+		ret = gpio_request(pdata->gpio_2407x_en2, "charge_mode2");
+		if (ret) {
+			dev_dbg(&pdev->dev, "couldn't request EN2 GPIO: %d\n",
+				pdata->gpio_2407x_en2);
+			goto err_en2;
+		}
+	}
 
 	/* set initial current to 100mA and disable regulator */
+	if (pdata->gpio_2407x_en2) {
+		ret = gpio_direction_output(pdata->gpio_2407x_en2, 0);
+		if (ret) {
+			dev_dbg(&pdev->dev, "couldn't set EN2 GPIO: %d\n",
+				pdata->gpio_2407x_en2);
+			goto err_reg;
+		}
+		bq->gpio_2407x_en2  = pdata->gpio_2407x_en2;
+	}
 	ret = gpio_direction_output(pdata->gpio_iset2, 0);
 	if (ret) {
 		dev_dbg(&pdev->dev, "couldn't set ISET2 GPIO: %d\n",
@@ -140,6 +183,13 @@ static int __init bq24022_probe(struct platform_device *pdev)
 	bq->gpio_nce  = pdata->gpio_nce;
 	bq->state_nce = 1;
 
+	/* get maximum current from regulator_init_data */
+	if (pdata->init_data) {
+		bq->max_uA = pdata->init_data->constraints.max_uA;
+		dev_dbg(&pdev->dev, "maximum current is %d mA\n",
+			bq->max_uA / 1000);
+	}
+
 	bq->rdev = regulator_register(&bq24022_desc, &pdev->dev,
 				     pdata->init_data, bq);
 	if (IS_ERR(bq->rdev)) {
@@ -152,6 +202,9 @@ static int __init bq24022_probe(struct platform_device *pdev)
 
 	return 0;
 err_reg:
+	if (pdata->gpio_2407x_en2)
+		gpio_free(pdata->gpio_2407x_en2);
+err_en2:
 	gpio_free(pdata->gpio_iset2);
 err_iset2:
 	gpio_free(pdata->gpio_nce);
@@ -164,6 +217,8 @@ static int __devexit bq24022_remove(struct platform_device *pdev)
 	struct bq24022 *bq = platform_get_drvdata(pdev);
 
 	regulator_unregister(bq->rdev);
+	if (bq->gpio_2407x_en2)
+		gpio_free(bq->gpio_2407x_en2);
 	gpio_free(bq->gpio_iset2);
 	gpio_free(bq->gpio_nce);
 
diff --git a/include/linux/regulator/bq24022.h b/include/linux/regulator/bq24022.h
index a6d0140..39a48e1 100644
--- a/include/linux/regulator/bq24022.h
+++ b/include/linux/regulator/bq24022.h
@@ -16,9 +16,16 @@ struct regulator_init_data;
  * bq24022_mach_info - platform data for bq24022
  * @gpio_nce: GPIO line connected to the nCE pin, used to enable / disable charging
  * @gpio_iset2: GPIO line connected to the ISET2 pin, used to limit charging current to 100 mA / 500 mA
+ * @gpio_2407x_en2: GPIO line connected to the en2 pin of the bq2407x family
+ * Modes of operation for bq2407x:
+ * EN2 = 0, ISET2 = 0: 100mA
+ * EN2 = 0, ISET2 = 1: 500mA
+ * EN2 = 1, ISET2 = 0: max_current
+ * EN2 = 1, ISET2 = 1: Standby (usb suspend)
  */
 struct bq24022_mach_info {
 	int gpio_nce;
 	int gpio_iset2;
+	int gpio_2407x_en2;
 	struct regulator_init_data *init_data;
 };
-- 
1.7.2.3
