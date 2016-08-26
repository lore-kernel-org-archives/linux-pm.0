From: Joe Perches <joe@perches.com>
Subject: [PATCH v4 possible follow-on] intel_bxt_pmic_thermal: Constify and neaten
Date: Fri, 26 Aug 2016 14:46:56 -0700
Message-ID: <635000393918b69339e034c59557272fd2f40f24.1472247756.git.joe@perches.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:36395 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751645AbcHZVrf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2016 17:47:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>, Bin Gao <bin.gao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Making some data structures const reduces data.

$ size drivers/thermal/intel_bxt_pmic_thermal.o*
   text	   data	    bss	    dec	    hex	filename
   2525	   1112	      0	   3637	    e35	drivers/thermal/intel_bxt_pmic_thermal.o.new
   2010	   1656	      0	   3666	    e52	drivers/thermal/intel_bxt_pmic_thermal.o.old

Miscellaneous:

o Unindent a function using continue
o Align multiple line statements to open parenthesis

Signed-off-by: Joe Perches <joe@perches.com>
---

Or maybe integrate something like this into your submission
if another pass is necessary

 drivers/thermal/intel_bxt_pmic_thermal.c | 63 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
index dd175c0..3ee325b 100644
--- a/drivers/thermal/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel_bxt_pmic_thermal.c
@@ -48,15 +48,15 @@ struct trip_config_map {
 struct thermal_irq_map {
 	char handle[20];
 	int num_trips;
-	struct trip_config_map *trip_config;
+	const struct trip_config_map *trip_config;
 };
 
 struct pmic_thermal_data {
-	struct thermal_irq_map *maps;
+	const struct thermal_irq_map *maps;
 	int num_maps;
 };
 
-static struct trip_config_map bxtwc_str0_trip_config[] = {
+static const struct trip_config_map bxtwc_str0_trip_config[] = {
 	{
 		.irq_reg = BXTWC_THRM0IRQ,
 		.irq_mask = 0x01,
@@ -77,7 +77,7 @@ static struct trip_config_map bxtwc_str0_trip_config[] = {
 	}
 };
 
-static struct trip_config_map bxtwc_str1_trip_config[] = {
+static const struct trip_config_map bxtwc_str1_trip_config[] = {
 	{
 		.irq_reg = BXTWC_THRM0IRQ,
 		.irq_mask = 0x02,
@@ -98,7 +98,7 @@ static struct trip_config_map bxtwc_str1_trip_config[] = {
 	},
 };
 
-static struct trip_config_map bxtwc_str2_trip_config[] = {
+static const struct trip_config_map bxtwc_str2_trip_config[] = {
 	{
 		.irq_reg = BXTWC_THRM0IRQ,
 		.irq_mask = 0x04,
@@ -119,7 +119,7 @@ static struct trip_config_map bxtwc_str2_trip_config[] = {
 	},
 };
 
-static struct trip_config_map bxtwc_str3_trip_config[] = {
+static const struct trip_config_map bxtwc_str3_trip_config[] = {
 	{
 		.irq_reg = BXTWC_THRM2IRQ,
 		.irq_mask = 0x10,
@@ -131,7 +131,7 @@ static struct trip_config_map bxtwc_str3_trip_config[] = {
 	},
 };
 
-static struct thermal_irq_map bxtwc_thermal_irq_map[] = {
+static const struct thermal_irq_map bxtwc_thermal_irq_map[] = {
 	{
 		.handle = "STR0",
 		.trip_config = bxtwc_str0_trip_config,
@@ -154,7 +154,7 @@ static struct thermal_irq_map bxtwc_thermal_irq_map[] = {
 	},
 };
 
-static struct pmic_thermal_data bxtwc_thermal_data = {
+static const struct pmic_thermal_data bxtwc_thermal_data = {
 	.maps = bxtwc_thermal_irq_map,
 	.num_maps = ARRAY_SIZE(bxtwc_thermal_irq_map),
 };
@@ -188,27 +188,25 @@ static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
 				return IRQ_HANDLED;
 
 			reg_val = (u8)ret;
-			irq_stat = ((u8)ret & mask);
-
-			if (irq_stat) {
-				/*
-				 * Read the status register to find out what
-				 * event occurred i.e a high or a low
-				 */
-				evt_stat_reg =
-					td->maps[i].trip_config[j].evt_stat;
-				if (regmap_read(regmap, evt_stat_reg, &ret))
-					return IRQ_HANDLED;
-
-				trip = td->maps[i].trip_config[j].trip_num;
-				tzd = thermal_zone_get_zone_by_name(
-						td->maps[i].handle);
-				if (!IS_ERR(tzd))
-					thermal_zone_device_update(tzd);
-
-				/* Clear the appropriate irq */
-				regmap_write(regmap, reg, reg_val & mask);
-			}
+			irq_stat = reg_val & mask;
+
+			if (!irq_stat)
+				continue;
+			/*
+			 * Read the status register to find out what
+			 * event occurred i.e a high or a low
+			 */
+			evt_stat_reg = td->maps[i].trip_config[j].evt_stat;
+			if (regmap_read(regmap, evt_stat_reg, &ret))
+				return IRQ_HANDLED;
+
+			trip = td->maps[i].trip_config[j].trip_num;
+			tzd = thermal_zone_get_zone_by_name(td->maps[i].handle);
+			if (!IS_ERR(tzd))
+				thermal_zone_device_update(tzd);
+
+			/* Clear the appropriate irq */
+			regmap_write(regmap, reg, irq_stat);
 		}
 	}
 
@@ -252,8 +250,9 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 		}
 
 		ret = devm_request_threaded_irq(&pdev->dev, virq,
-				NULL, pmic_thermal_irq_handler,
-				IRQF_ONESHOT, "pmic_thermal", pdev);
+						NULL, pmic_thermal_irq_handler,
+						IRQF_ONESHOT, "pmic_thermal",
+						pdev);
 
 		if (ret) {
 			dev_err(dev, "request irq(%d) failed: %d\n", virq, ret);
@@ -276,7 +275,7 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id pmic_thermal_id_table[] = {
+static const struct platform_device_id pmic_thermal_id_table[] = {
 	{
 		.name = "bxt_wcove_thermal",
 		.driver_data = (kernel_ulong_t)&bxtwc_thermal_data,
-- 
2.8.0.rc4.16.g56331f8

