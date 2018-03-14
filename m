From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/2] regulator: bd9571mwv: Add support for toggle power switches
Date: Wed, 14 Mar 2018 12:26:25 +0100
Message-ID: <1521026785-26456-3-git-send-email-geert+renesas@glider.be>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Extend the existing support for backup mode to toggle power switches.
With a toggle power switch (or level signal), the following steps must
be followed exactly:
   1. Configure PMIC for backup mode,
   2. Switch accessory power switch off, to prepare for system suspend,
      which is a manual step not controlled by software,
   3. Suspend system.
Hence the PMIC is configured for backup mode when "enabled" is written
to the PMIC's "wakeup" virtual file in sysfs, using the newly introduced
callback for wake-up change notification.
Unlike with momentary switches, backup mode is not enabled by default,
as enabling it prevents the board from being powered off using the power
switch, which may confuse the user.
Conversely, writing "disabled" reverts the role of the accessory switch
to a power switch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/regulator/bd9571mwv-regulator.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index be574eb444ebda97..435c8da576b604cf 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -171,6 +171,24 @@ static int bd9571mwv_bkup_mode_write(struct bd9571mwv *bd, unsigned int mode)
 	return 0;
 }
 
+static void bd9571mwv_wakeup_change_notify(struct device *dev, bool enable)
+{
+	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+
+	unsigned int mode;
+	int ret;
+
+	ret = bd9571mwv_bkup_mode_read(bdreg->bd, &mode);
+	if (ret)
+		return;
+
+	mode &= ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+	if (enable)
+		mode |= bdreg->bkup_mode_cnt_keepon;
+
+	bd9571mwv_bkup_mode_write(bdreg->bd, mode);
+}
+
 static int bd9571mwv_suspend(struct device *dev)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
@@ -277,6 +295,11 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 		 * explicit user setup in level mode.
 		 */
 		device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
+#ifdef CONFIG_PM_SLEEP
+		if (bdreg->rstbmode_level)
+			pdev->dev.power.wakeup_change_notify =
+				bd9571mwv_wakeup_change_notify;
+#endif /* CONFIG_PM_SLEEP */
 	}
 
 	return 0;
-- 
2.7.4
