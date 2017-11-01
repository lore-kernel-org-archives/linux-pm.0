From: Colin King <colin.king@canonical.com>
Subject: [PATCH] thermal: bxt: remove redundant variable trip
Date: Wed,  1 Nov 2017 09:41:18 +0000
Message-ID: <20171101094118.16916-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable trip is assigned but never read, hence it is redundant
and can be removed. Cleans up clang warning:

drivers/thermal/intel_bxt_pmic_thermal.c:204:4: warning: Value stored
to 'trip' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/intel_bxt_pmic_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
index ef6b32242ccb..94cfd0064c43 100644
--- a/drivers/thermal/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel_bxt_pmic_thermal.c
@@ -166,7 +166,7 @@ static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
 	struct pmic_thermal_data *td;
 	struct intel_soc_pmic *pmic;
 	struct regmap *regmap;
-	u8 reg_val, mask, irq_stat, trip;
+	u8 reg_val, mask, irq_stat;
 	u16 reg, evt_stat_reg;
 	int i, j, ret;
 
@@ -201,7 +201,6 @@ static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
 			if (regmap_read(regmap, evt_stat_reg, &ret))
 				return IRQ_HANDLED;
 
-			trip = td->maps[i].trip_config[j].trip_num;
 			tzd = thermal_zone_get_zone_by_name(td->maps[i].handle);
 			if (!IS_ERR(tzd))
 				thermal_zone_device_update(tzd,
-- 
2.14.1
