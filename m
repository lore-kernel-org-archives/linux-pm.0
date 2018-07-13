From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/3] regulator: bd9571mwv: Use "backup_mode" sysfs file instead of "wake_up"
Date: Fri, 13 Jul 2018 17:47:18 +0200
Message-ID: <20180713154720.18316-2-geert+renesas@glider.be>
References: <20180713154720.18316-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713154720.18316-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Currently the BD9571MWV PMIC driver uses the standard "wake_up" sysfs
file to control enablement of DDR Backup Mode.

However, configuring DDR Backup Mode is not really equivalent to
configuring the PMIC as a wake-up source.  To avoid confusion, use a
custom "backup_mode" attribute file in sysfs instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/regulator/bd9571mwv-regulator.c | 52 ++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index be574eb444ebda97..7432b605db4dc879 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -30,6 +30,7 @@ struct bd9571mwv_reg {
 	/* DDR Backup Power */
 	u8 bkup_mode_cnt_keepon;	/* from "rohm,ddr-backup-power" */
 	u8 bkup_mode_cnt_saved;
+	bool bkup_mode_enabled;
 
 	/* Power switch type */
 	bool rstbmode_level;
@@ -171,13 +172,40 @@ static int bd9571mwv_bkup_mode_write(struct bd9571mwv *bd, unsigned int mode)
 	return 0;
 }
 
+static ssize_t backup_mode_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", bdreg->bkup_mode_enabled ? "on" : "off");
+}
+
+static ssize_t backup_mode_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+	int ret;
+
+	if (!count)
+		return 0;
+
+	ret = kstrtobool(buf, &bdreg->bkup_mode_enabled);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+DEVICE_ATTR_RW(backup_mode);
+
 static int bd9571mwv_suspend(struct device *dev)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
 	unsigned int mode;
 	int ret;
 
-	if (!device_may_wakeup(dev))
+	if (!bdreg->bkup_mode_enabled)
 		return 0;
 
 	/* Save DDR Backup Mode */
@@ -204,7 +232,7 @@ static int bd9571mwv_resume(struct device *dev)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
 
-	if (!device_may_wakeup(dev))
+	if (!bdreg->bkup_mode_enabled)
 		return 0;
 
 	/* Restore DDR Backup Mode */
@@ -227,7 +255,7 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 	struct bd9571mwv_reg *bdreg;
 	struct regulator_dev *rdev;
 	unsigned int val;
-	int i;
+	int i, ret;
 
 	bdreg = devm_kzalloc(&pdev->dev, sizeof(*bdreg), GFP_KERNEL);
 	if (!bdreg)
@@ -270,15 +298,26 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_PM_SLEEP
 	if (bdreg->bkup_mode_cnt_keepon) {
-		device_set_wakeup_capable(&pdev->dev, true);
 		/*
-		 * Wakeup is enabled by default in pulse mode, but needs
+		 * Backup mode is enabled by default in pulse mode, but needs
 		 * explicit user setup in level mode.
 		 */
-		device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
+		bdreg->bkup_mode_enabled = bdreg->rstbmode_pulse;
+
+		ret = device_create_file(&pdev->dev, &dev_attr_backup_mode);
+		if (ret)
+			return ret;
 	}
+#endif /* CONFIG_PM_SLEEP */
+
+	return 0;
+}
 
+static int bd9571mwv_regulator_remove(struct platform_device *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_backup_mode);
 	return 0;
 }
 
@@ -294,6 +333,7 @@ static struct platform_driver bd9571mwv_regulator_driver = {
 		.pm = DEV_PM_OPS,
 	},
 	.probe = bd9571mwv_regulator_probe,
+	.remove = bd9571mwv_regulator_remove,
 	.id_table = bd9571mwv_regulator_id_table,
 };
 module_platform_driver(bd9571mwv_regulator_driver);
-- 
2.17.1
