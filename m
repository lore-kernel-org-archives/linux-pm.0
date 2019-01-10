From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v5 07/10] Platform: OLPC: Add a regulator for the DCON
Date: Thu, 10 Jan 2019 18:58:42 +0100
Message-ID: <20190110175845.1203986-8-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lubomir Rintel <lkundrak@v3.sk>
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

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
index 559f843199d7..858ac1d2290a 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -1,4 +1,5 @@
 config OLPC_EC
+	select REGULATOR
 	bool
=20
 config OLPC_XO175_EC
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index a91f78245f5e..8566bcf2938d 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/regulator/driver.h>
 #include <linux/olpc-ec.h>
=20
 struct ec_cmd_desc {
@@ -36,6 +37,10 @@ struct olpc_ec_priv {
 	struct work_struct worker;
 	struct mutex cmd_lock;
=20
+	/* DCON regulator */
+	struct regulator_dev *dcon_rdev;
+	bool dcon_enabled;
+
 	/* Pending EC commands */
 	struct list_head cmd_q;
 	spinlock_t cmd_q_lock;
@@ -346,9 +351,61 @@ static struct dentry *olpc_ec_setup_debugfs(void)
=20
 #endif /* CONFIG_DEBUG_FS */
=20
+static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
+{
+	unsigned char ec_byte =3D state;
+	int ret;
+
+	if (ec->dcon_enabled =3D=3D state)
+		return 0;
+
+	ret =3D olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
+	if (ret)
+		return ret;
+
+	ec->dcon_enabled =3D state;
+	return 0;
+}
+
+static int dcon_regulator_enable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, true);
+}
+
+static int dcon_regulator_disable(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return olpc_ec_set_dcon_power(ec, false);
+}
+
+static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct olpc_ec_priv *ec =3D rdev_get_drvdata(rdev);
+
+	return ec->dcon_enabled ? 1 : 0;
+}
+
+static struct regulator_ops dcon_regulator_ops =3D {
+	.enable		=3D dcon_regulator_enable,
+	.disable	=3D dcon_regulator_disable,
+	.is_enabled	=3D dcon_regulator_is_enabled,
+};
+
+static const struct regulator_desc dcon_desc =3D {
+	.name	=3D "dcon",
+	.id	=3D 0,
+	.ops	=3D &dcon_regulator_ops,
+	.type	=3D REGULATOR_VOLTAGE,
+	.owner	=3D THIS_MODULE,
+};
+
 static int olpc_ec_probe(struct platform_device *pdev)
 {
 	struct olpc_ec_priv *ec;
+	struct regulator_config config =3D { };
 	int err;
=20
 	if (!ec_driver)
@@ -376,6 +433,16 @@ static int olpc_ec_probe(struct platform_device *pde=
v)
 		return err;
 	}
=20
+	config.dev =3D pdev->dev.parent;
+	config.driver_data =3D ec;
+	ec->dcon_enabled =3D true;
+	ec->dcon_rdev =3D devm_regulator_register(&pdev->dev, &dcon_desc,
+								&config);
+	if (IS_ERR(ec->dcon_rdev)) {
+		dev_err(&pdev->dev, "failed to register DCON regulator\n");
+		return PTR_ERR(ec->dcon_rdev);
+	}
+
 	ec->dbgfs_dir =3D olpc_ec_setup_debugfs();
=20
 	return err;
--=20
2.20.1
