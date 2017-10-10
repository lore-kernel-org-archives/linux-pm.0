From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
Date: Tue, 10 Oct 2017 17:26:17 +0200
Message-ID: <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507649178-31473-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marek.vasut+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The BD9571MWV PMIC supports backup mode, which keeps one or more DDR
rails powered while the main SoC is powered down.

Which DDR rails are to be kept powered is board-specific, and controlled
using the optional "rohm,ddr-backup-power" DT property.  In the absence
of this property, backup mode is not available.

Backup mode is not enabled automatically, as e.g. on Renesas
Salvator-X(S) boards enabling backup mode changes the role of the ACC
switch from a power switch to a wake-up switch.  Hence enabling it
prevents the board from being powered off using the ACC switch, which
may confuse the user.

Backup mode can be enabled or disabled by the user using the
"backup_mode" sysfs file, e.g.

    echo on > /sys/devices/platform/soc/e60b0000.i2c/i2c-7/7-0030/bd9571mwv-regulator.3.auto/backup_mode

If enabled by the boot loader, initial backup mode state is retained.
As state is lost by PSCI system suspend, it is restored during system
resume.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
What's the right place to document regulator sysfs files?
---
 drivers/regulator/bd9571mwv-regulator.c | 121 +++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index c67a83d53c4cb76b..c7ff67938c3eb48a 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -24,6 +24,14 @@
 
 #include <linux/mfd/bd9571mwv.h>
 
+struct bd9571mwv_reg {
+	struct bd9571mwv *bd;
+
+	/* DDR Backup Power */
+	u8 bkup_mode_cnt_keepon;	/* from "rohm,ddr-backup-power" */
+	u8 bkup_mode_cnt_shadow;
+};
+
 enum bd9571mwv_regulators { VD09, VD18, VD25, VD33, DVFS };
 
 #define BD9571MWV_REG(_name, _of, _id, _ops, _vr, _vm, _nv, _min, _step, _lmin)\
@@ -131,14 +139,99 @@ static struct regulator_desc regulators[] = {
 		      0x80, 600000, 10000, 0x3c),
 };
 
+static int bd9571mwv_bkup_mode_set(struct bd9571mwv_reg *bdreg, u8 mode)
+{
+	int ret;
+
+	ret = regmap_write(bdreg->bd->regmap, BD9571MWV_BKUP_MODE_CNT, mode);
+	if (ret) {
+		dev_err(bdreg->bd->dev,
+			"Failed to configure backup mode 0x%x (ret=%i)\n",
+			mode, ret);
+		return ret;
+	}
+
+	bdreg->bkup_mode_cnt_shadow = mode;
+	return 0;
+}
+
+static ssize_t backup_mode_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+	int enabled = bdreg->bkup_mode_cnt_shadow &
+		      BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+
+	return sprintf(buf, "%s\n", enabled ? "on" : "off");
+}
+
+static ssize_t backup_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t count)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+	bool enable;
+	ssize_t ret;
+	u8 mode;
+
+	if (!count)
+		return 0;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	mode = bdreg->bkup_mode_cnt_shadow &
+	       ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+	if (enable)
+		mode |= bdreg->bkup_mode_cnt_keepon;
+
+	if (mode == bdreg->bkup_mode_cnt_shadow)
+		return count;
+
+	ret = bd9571mwv_bkup_mode_set(bdreg, mode);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+DEVICE_ATTR_RW(backup_mode);
+
+#ifdef CONFIG_PM_SLEEP
+static int bd9571mwv_resume(struct device *dev)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+
+	return bd9571mwv_bkup_mode_set(bdreg, bdreg->bkup_mode_cnt_shadow);
+}
+
+static const struct dev_pm_ops bd9571mwv_pm  = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, bd9571mwv_resume)
+};
+
+#define DEV_PM_OPS	&bd9571mwv_pm
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 {
 	struct bd9571mwv *bd = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
+	struct bd9571mwv_reg *bdreg;
 	struct regulator_dev *rdev;
-	int i;
+	unsigned int val;
+	int i, ret;
+
+	bdreg = devm_kzalloc(&pdev->dev, sizeof(*bdreg), GFP_KERNEL);
+	if (!bdreg)
+		return -ENOMEM;
+
+	bdreg->bd = bd;
 
-	platform_set_drvdata(pdev, bd);
+	platform_set_drvdata(pdev, bdreg);
 
 	config.dev = &pdev->dev;
 	config.dev->of_node = bd->dev->of_node;
@@ -155,6 +248,28 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
+	val = 0;
+	of_property_read_u32(bd->dev->of_node, "rohm,ddr-backup-power", &val);
+	if (val & ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK) {
+		dev_err(bd->dev, "invalid %s mode %u\n",
+			"rohm,ddr-backup-power", val);
+		return -EINVAL;
+	}
+	bdreg->bkup_mode_cnt_keepon = val;
+
+	ret = regmap_read(bd->regmap, BD9571MWV_BKUP_MODE_CNT, &val);
+	if (ret) {
+		dev_err(bd->dev, "Failed to read backup mode (ret=%i)\n", ret);
+		return ret;
+	}
+	bdreg->bkup_mode_cnt_shadow = val;
+
+	return device_create_file(&pdev->dev, &dev_attr_backup_mode);
+}
+
+static int bd9571mwv_regulator_remove(struct platform_device *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_backup_mode);
 	return 0;
 }
 
@@ -167,8 +282,10 @@ MODULE_DEVICE_TABLE(platform, bd9571mwv_regulator_id_table);
 static struct platform_driver bd9571mwv_regulator_driver = {
 	.driver = {
 		.name = "bd9571mwv-regulator",
+		.pm = DEV_PM_OPS,
 	},
 	.probe = bd9571mwv_regulator_probe,
+	.remove = bd9571mwv_regulator_remove,
 	.id_table = bd9571mwv_regulator_id_table,
 };
 module_platform_driver(bd9571mwv_regulator_driver);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
