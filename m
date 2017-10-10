From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/5] mfd: bd9571mwv: Allow DDR Backup Power register access
Date: Tue, 10 Oct 2017 17:26:16 +0200
Message-ID: <1507649178-31473-4-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Enable read/write access to the BD9571MWV_BKUP_MODE_CNT register, which
is a.o. used to configure DDR Backup Power.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mfd/bd9571mwv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 64e088dfe7b05b5b..503979c81dae11bb 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -29,6 +29,7 @@ static const struct mfd_cell bd9571mwv_cells[] = {
 
 static const struct regmap_range bd9571mwv_readable_yes_ranges[] = {
 	regmap_reg_range(BD9571MWV_VENDOR_CODE, BD9571MWV_PRODUCT_REVISION),
+	regmap_reg_range(BD9571MWV_BKUP_MODE_CNT, BD9571MWV_BKUP_MODE_CNT),
 	regmap_reg_range(BD9571MWV_AVS_SET_MONI, BD9571MWV_AVS_DVFS_VID(3)),
 	regmap_reg_range(BD9571MWV_VD18_VID, BD9571MWV_VD33_VID),
 	regmap_reg_range(BD9571MWV_DVFS_VINIT, BD9571MWV_DVFS_VINIT),
@@ -44,6 +45,7 @@ static const struct regmap_access_table bd9571mwv_readable_table = {
 };
 
 static const struct regmap_range bd9571mwv_writable_yes_ranges[] = {
+	regmap_reg_range(BD9571MWV_BKUP_MODE_CNT, BD9571MWV_BKUP_MODE_CNT),
 	regmap_reg_range(BD9571MWV_AVS_VD09_VID(0), BD9571MWV_AVS_VD09_VID(3)),
 	regmap_reg_range(BD9571MWV_DVFS_SETVID, BD9571MWV_DVFS_SETVID),
 	regmap_reg_range(BD9571MWV_GPIO_DIR, BD9571MWV_GPIO_OUT),
-- 
2.7.4
