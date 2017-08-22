From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3 v3] mfd: db8500-prcmu: Get rid of cpufreq dependency
Date: Tue, 22 Aug 2017 15:17:40 +0200
Message-ID: <20170822131741.23473-2-linus.walleij@linaro.org>
References: <20170822131741.23473-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35523 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbdHVNRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 09:17:50 -0400
Received: by mail-lf0-f46.google.com with SMTP id k186so23467006lfe.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2017 06:17:49 -0700 (PDT)
In-Reply-To: <20170822131741.23473-1-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The ARMSS clock, also known as the operating point of the
CPU, should not cross-depend on cpufreq like this. Move
the code to use just frequencies and remove the false
frequency (1GHz) and put in the actual frequency provided
by the ARMSS clock (998400000 Hz) as part of the process.

After this and the related cpufreq patch, the DB8500 will
simply use the standard DT cpufreq driver to change the
operating points through the common clock framework using
the ARMSS clock.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Fixed freq table indentation so both checkpatch and Lee
  are happy.
---
 drivers/mfd/db8500-prcmu.c | 62 ++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5c739ac752e8..5970b8def548 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -33,7 +33,6 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/regulator/db8500-prcmu.h>
 #include <linux/regulator/machine.h>
-#include <linux/cpufreq.h>
 #include <linux/platform_data/ux500_wdt.h>
 #include <linux/platform_data/db8500_thermal.h>
 #include "dbx500-prcmu-regs.h"
@@ -1692,32 +1691,27 @@ static long round_clock_rate(u8 clock, unsigned long rate)
 	return rounded_rate;
 }
 
-/* CPU FREQ table, may be changed due to if MAX_OPP is supported. */
-static struct cpufreq_frequency_table db8500_cpufreq_table[] = {
-	{ .frequency = 200000, .driver_data = ARM_EXTCLK,},
-	{ .frequency = 400000, .driver_data = ARM_50_OPP,},
-	{ .frequency = 800000, .driver_data = ARM_100_OPP,},
-	{ .frequency = CPUFREQ_TABLE_END,}, /* To be used for MAX_OPP. */
-	{ .frequency = CPUFREQ_TABLE_END,},
+static const unsigned long armss_freqs[] = {
+	200000000,
+	400000000,
+	800000000,
+	998400000
 };
 
 static long round_armss_rate(unsigned long rate)
 {
-	struct cpufreq_frequency_table *pos;
-	long freq = 0;
-
-	/* cpufreq table frequencies is in KHz. */
-	rate = rate / 1000;
+	unsigned long freq = 0;
+	int i;
 
 	/* Find the corresponding arm opp from the cpufreq table. */
-	cpufreq_for_each_entry(pos, db8500_cpufreq_table) {
-		freq = pos->frequency;
-		if (freq == rate)
+	for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
+		freq = armss_freqs[i];
+		if (rate <= freq)
 			break;
 	}
 
 	/* Return the last valid value, even if a match was not found. */
-	return freq * 1000;
+	return freq;
 }
 
 #define MIN_PLL_VCO_RATE 600000000ULL
@@ -1854,21 +1848,23 @@ static void set_clock_rate(u8 clock, unsigned long rate)
 
 static int set_armss_rate(unsigned long rate)
 {
-	struct cpufreq_frequency_table *pos;
-
-	/* cpufreq table frequencies is in KHz. */
-	rate = rate / 1000;
+	unsigned long freq;
+	u8 opps[] = { ARM_EXTCLK, ARM_50_OPP, ARM_100_OPP, ARM_MAX_OPP };
+	int i;
 
 	/* Find the corresponding arm opp from the cpufreq table. */
-	cpufreq_for_each_entry(pos, db8500_cpufreq_table)
-		if (pos->frequency == rate)
+	for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
+		freq = armss_freqs[i];
+		if (rate == freq)
 			break;
+	}
 
-	if (pos->frequency != rate)
+	if (rate != freq)
 		return -EINVAL;
 
 	/* Set the new arm opp. */
-	return db8500_prcmu_set_arm_opp(pos->driver_data);
+	pr_debug("SET ARM OPP 0x%02x\n", opps[i]);
+	return db8500_prcmu_set_arm_opp(opps[i]);
 }
 
 static int set_plldsi_rate(unsigned long rate)
@@ -3049,12 +3045,6 @@ static const struct mfd_cell db8500_prcmu_devs[] = {
 		.pdata_size = sizeof(db8500_regulators),
 	},
 	{
-		.name = "cpufreq-ux500",
-		.of_compatible = "stericsson,cpufreq-ux500",
-		.platform_data = &db8500_cpufreq_table,
-		.pdata_size = sizeof(db8500_cpufreq_table),
-	},
-	{
 		.name = "cpuidle-dbx500",
 		.of_compatible = "stericsson,cpuidle-dbx500",
 	},
@@ -3067,14 +3057,6 @@ static const struct mfd_cell db8500_prcmu_devs[] = {
 	},
 };
 
-static void db8500_prcmu_update_cpufreq(void)
-{
-	if (prcmu_has_arm_maxopp()) {
-		db8500_cpufreq_table[3].frequency = 1000000;
-		db8500_cpufreq_table[3].driver_data = ARM_MAX_OPP;
-	}
-}
-
 static int db8500_prcmu_register_ab8500(struct device *parent)
 {
 	struct device_node *np;
@@ -3160,8 +3142,6 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 
 	prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
 
-	db8500_prcmu_update_cpufreq();
-
 	err = mfd_add_devices(&pdev->dev, 0, common_prcmu_devs,
 			      ARRAY_SIZE(common_prcmu_devs), NULL, 0, db8500_irq_domain);
 	if (err) {
-- 
2.13.5
