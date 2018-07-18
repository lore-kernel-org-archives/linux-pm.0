From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: bd9571mwv: Add support for toggle power switches" to the regulator tree
Date: Wed, 18 Jul 2018 13:29:41 +0100
Message-ID: <E1fflaP-0007Tt-AZ@debutante>
References: <20180716153052.1830-3-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716153052.1830-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The patch

   regulator: bd9571mwv: Add support for toggle power switches

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

>From e436875f6f97708613976da75a92974f18998af9 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 16 Jul 2018 17:30:51 +0200
Subject: [PATCH] regulator: bd9571mwv: Add support for toggle power switches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the existing support for backup mode to toggle power switches.
With a toggle power switch (or level signal), the following steps must
be followed exactly:
   1. Configure PMIC for backup mode, to change the role of the
      accessory power switch from a power switch to a wake-up switch,
   2. Switch accessory power switch off, to prepare for system suspend,
      which is a manual step not controlled by software,
   3. Suspend system,
   4. Switch accessory power switch on, to resume the system.

Hence the PMIC is configured for backup mode when "on" or "1" is written
to the PMIC's "backup_mode" virtual file in sysfs.  Conversely, writing
"off" or "0" reverts the role of the accessory switch to a power
switch.

Unlike with momentary switches, backup mode is not enabled by default,
as enabling it prevents the board from being powered off using the power
switch, which may confuse the user.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd9571mwv-regulator.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index 1da36a6590c8..c44613b9423b 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -185,6 +185,7 @@ static ssize_t backup_mode_store(struct device *dev,
 				 const char *buf, size_t count)
 {
 	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
+	unsigned int mode;
 	int ret;
 
 	if (!count)
@@ -194,6 +195,25 @@ static ssize_t backup_mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (!bdreg->rstbmode_level)
+		return count;
+
+	/*
+	 * Configure DDR Backup Mode, to change the role of the accessory power
+	 * switch from a power switch to a wake-up switch, or vice versa
+	 */
+	ret = bd9571mwv_bkup_mode_read(bdreg->bd, &mode);
+	if (ret)
+		return ret;
+
+	mode &= ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
+	if (bdreg->bkup_mode_enabled)
+		mode |= bdreg->bkup_mode_cnt_keepon;
+
+	ret = bd9571mwv_bkup_mode_write(bdreg->bd, mode);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
-- 
2.18.0
