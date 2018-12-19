From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 10/10] i2c: rcar: add suspend/resume support
Date: Wed, 19 Dec 2018 17:48:26 +0100
Message-ID: <20181219164827.20985-11-wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Because the adapter will be set up before every transaction anyhow, we
just need to mark it as suspended to the I2C core.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 254e6219e538..1d6390eed861 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1017,10 +1017,35 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int rcar_i2c_suspend(struct device *dev)
+{
+	struct rcar_i2c_priv *priv = dev_get_drvdata(dev);
+
+	i2c_mark_adapter_suspended(&priv->adap);
+	return 0;
+}
+
+static int rcar_i2c_resume(struct device *dev)
+{
+	struct rcar_i2c_priv *priv = dev_get_drvdata(dev);
+
+	i2c_mark_adapter_resumed(&priv->adap);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rcar_i2c_pm_ops, rcar_i2c_suspend, rcar_i2c_resume);
+
+#define DEV_PM_OPS (&rcar_i2c_pm_ops)
+#else
+#define DEV_PM_OPS NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
 		.of_match_table = rcar_i2c_dt_ids,
+		.pm	= DEV_PM_OPS,
 	},
 	.probe		= rcar_i2c_probe,
 	.remove		= rcar_i2c_remove,
-- 
2.11.0
