From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 2/3] regulator: bd9571mwv: Add support for toggle power switches
Date: Mon, 16 Jul 2018 17:30:51 +0200
Message-ID: <20180716153052.1830-3-geert+renesas@glider.be>
References: <20180716153052.1830-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716153052.1830-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

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
---
v4:
  - Improve patch description and comment,

v3:
  - Replace use of "wake_up" sysfs file and extra callback for wake-up
    change notification by custom "backup_mode" sysfs file,

v2:
  - Improve patch description,
  - Drop "return;" at end of function.
---
 drivers/regulator/bd9571mwv-regulator.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index 1da36a6590c84ba4..c44613b9423baf07 100644
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
2.17.1
