From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 1/3] bq24022: Evaluate returns of
	gpio_direction_output-calls
Date: Sun, 28 Aug 2011 15:08:30 +0200
Message-ID: <201108281508.31412.heiko@sntech.de>
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

It wasn't done before.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/regulator/bq24022.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/bq24022.c b/drivers/regulator/bq24022.c
index e24d1b7..973af08 100644
--- a/drivers/regulator/bq24022.c
+++ b/drivers/regulator/bq24022.c
@@ -104,7 +104,17 @@ static int __init bq24022_probe(struct platform_device *pdev)
 		goto err_iset2;
 	}
 	ret = gpio_direction_output(pdata->gpio_iset2, 0);
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't set ISET2 GPIO: %d\n",
+			pdata->gpio_iset2);
+		goto err_reg;
+	}
 	ret = gpio_direction_output(pdata->gpio_nce, 1);
+	if (ret) {
+		dev_dbg(&pdev->dev, "couldn't set nCE GPIO: %d\n",
+			pdata->gpio_nce);
+		goto err_reg;
+	}
 
 	bq24022 = regulator_register(&bq24022_desc, &pdev->dev,
 				     pdata->init_data, pdata);
-- 
1.7.2.3
