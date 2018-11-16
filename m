From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 10/17] Platform: OLPC: add a regulator for the DCON
Date: Fri, 16 Nov 2018 17:23:56 +0100
Message-ID: <20181116162403.49854-11-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

All OLPC ECs are able to turn the power to the DCON on an off. Use the
regulator framework to expose the functionality.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Use idiomatic form of return on error
- Avoid mixing bool and int

 drivers/platform/olpc/Kconfig   |  1 +
 drivers/platform/olpc/olpc-ec.c | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfig
index 7c643d24ad0f..c5a872fb286f 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -6,6 +6,7 @@ config OLPC
 	select OF
 	select OF_PROMTREE if X86
 	select IRQ_DOMAIN
+	select REGULATOR
 	help
 	  Add support for detecting the unique features of the OLPC
 	  XO hardware.
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 2b80174b8f4b..f725ab2a2db9 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/regulator/driver.h>
 #include <linux/olpc-ec.h>
 
 struct ec_cmd_desc {
@@ -34,6 +35,10 @@ struct olpc_ec_priv {
 	struct work_struct worker;
 	struct mutex cmd_lock;
 
+	/* DCON regulator */
+	struct regulator_dev *dcon_rdev;
+	bool dcon_enabled;
+
 	/* Pending EC commands */
 	struct list_head cmd_q;
 	spinlock_t cmd_q_lock;
@@ -344,9 +349,61 @@ static struct dentry *olpc_ec_setup_debugfs(void)
 
 #endif /* CONFIG_DEBUG_FS */
 
+static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
+{
+	unsigned char ec_byte = state;
+	int ret;
+
+	if (ec->dcon_enabled == state)
+		return 0;
+
+	ret = olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
+	if (ret)
+		return ret;
+
+	ec->dcon_enabled = state;
+	return 0;
+}
+
+static int dcon_regulator_enable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec = rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, true);
+}
+
+static int dcon_regulator_disable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec = rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, false);
+}
+
+static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec = rdev_get_drvdata(rdev);
+
+	return ec->dcon_enabled ? 1 : 0;
+}
+
+static struct regulator_ops dcon_regulator_ops = {
+	.enable		= dcon_regulator_enable,
+	.disable	= dcon_regulator_disable,
+	.is_enabled	= dcon_regulator_is_enabled,
+};
+
+static const struct regulator_desc dcon_desc = {
+	.name	= "dcon",
+	.id	= 0,
+	.ops	= &dcon_regulator_ops,
+	.type	= REGULATOR_VOLTAGE,
+	.owner	= THIS_MODULE,
+};
+
 static int olpc_ec_probe(struct platform_device *pdev)
 {
 	struct olpc_ec_priv *ec;
+	struct regulator_config config = { };
 	int err;
 
 	if (!ec_driver)
@@ -374,6 +431,16 @@ static int olpc_ec_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	config.dev = pdev->dev.parent;
+	config.driver_data = ec;
+	ec->dcon_enabled = true;
+	ec->dcon_rdev = devm_regulator_register(&pdev->dev, &dcon_desc,
+								&config);
+	if (IS_ERR(ec->dcon_rdev)) {
+		dev_err(&pdev->dev, "failed to register DCON regulator\n");
+		return PTR_ERR(ec->dcon_rdev);
+	}
+
 	ec->dbgfs_dir = olpc_ec_setup_debugfs();
 
 	return err;
-- 
2.19.1
