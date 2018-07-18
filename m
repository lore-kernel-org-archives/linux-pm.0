From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: bd9571mwv: Use "backup_mode" sysfs file instead of "wake_up"" to the regulator tree
Date: Wed, 18 Jul 2018 13:29:43 +0100
Message-ID: <E1fflaR-0007Uu-G7@debutante>
References: <20180716153052.1830-2-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716153052.1830-2-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The patch

   regulator: bd9571mwv: Use "backup_mode" sysfs file instead of "wake_up"

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 02b3a073c12edc8cbc18e07e8880a32e78c1aee0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 16 Jul 2018 17:30:50 +0200
Subject: [PATCH] regulator: bd9571mwv: Use "backup_mode" sysfs file instead of
 "wake_up"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the BD9571MWV PMIC driver uses the standard "wake_up" sysfs
file to control enablement of DDR Backup Mode.

However, configuring DDR Backup Mode is not really equivalent to
configuring the PMIC as a wake-up source.  To avoid confusion, use a
custom "backup_mode" attribute file in sysfs instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd9571mwv-regulator.c | 52 ++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index be574eb444eb..1da36a6590c8 100644
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
@@ -215,9 +243,15 @@ static const struct dev_pm_ops bd9571mwv_pm  = {
 	SET_SYSTEM_SLEEP_PM_OPS(bd9571mwv_suspend, bd9571mwv_resume)
 };
 
+static int bd9571mwv_regulator_remove(struct platform_device *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_backup_mode);
+	return 0;
+}
 #define DEV_PM_OPS	&bd9571mwv_pm
 #else
 #define DEV_PM_OPS	NULL
+#define bd9571mwv_regulator_remove	NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static int bd9571mwv_regulator_probe(struct platform_device *pdev)
@@ -270,14 +304,21 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_PM_SLEEP
 	if (bdreg->bkup_mode_cnt_keepon) {
-		device_set_wakeup_capable(&pdev->dev, true);
+		int ret;
+
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
 
 	return 0;
 }
@@ -294,6 +335,7 @@ static struct platform_driver bd9571mwv_regulator_driver = {
 		.pm = DEV_PM_OPS,
 	},
 	.probe = bd9571mwv_regulator_probe,
+	.remove = bd9571mwv_regulator_remove,
 	.id_table = bd9571mwv_regulator_id_table,
 };
 module_platform_driver(bd9571mwv_regulator_driver);
-- 
2.18.0
