From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 08/15] Platform: OLPC: add a regulator for the DCON
Date: Tue,  8 Jan 2019 18:58:11 +0100
Message-ID: <20190108175818.705110-9-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
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
index 066e439bf4fc..02b232c34444 100644
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
index 0e1449d7aefc..e9cc95da1548 100644
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
