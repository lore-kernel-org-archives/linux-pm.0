From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 4/8] mfd: intel_soc_pmic_bxtwc: remove second level irq for gpio device
Date: Tue, 23 May 2017 10:30:02 -0700
Message-ID: <2f332f4212ccd9a62344f20c8439a491b2385aaf.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170523072615.r4widzjc6apwxpwb@dell>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59189 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966155AbdEWReU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 13:34:20 -0400
In-Reply-To: <20170523072615.r4widzjc6apwxpwb@dell>
In-Reply-To: <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently all PMIC GPIO domain irqs are consumed by the same
device(bxt_wcove_gpio), so there is no need to export them as
separate interrupts. We can just export only the first level
GPIO irq(BXTWC_GPIO_LVL1_IRQ) as an irq resource and let the
GPIO device driver(bxt_wcove_gpio) handle the GPIO sub domain
irqs based on status value of GPIO level2 interrupt status
register. Also, just using only the first level irq will eliminate
the bug involved in requesting only the second level irq and not
explicitly enable the first level irq. For more info on this
issue please read the details at,

https://lkml.org/lkml/2017/2/27/148

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Changes since v1:
 * None

Changes since v2: 
 * Rebased on top of latest release.

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 7c1ed27..af11c43 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -89,8 +89,6 @@ enum bxtwc_irqs_level2 {
 	BXTWC_USBC_IRQ,
 	BXTWC_CHGR0_IRQ,
 	BXTWC_CHGR1_IRQ,
-	BXTWC_GPIO0_IRQ,
-	BXTWC_GPIO1_IRQ,
 	BXTWC_CRIT_IRQ,
 };
 
@@ -116,8 +114,6 @@ static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
 	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
 	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
 	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 4, 0xff),
-	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 5, 0x3f),
 	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
 };
 
@@ -153,8 +149,7 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
 };
 
 static struct resource gpio_resources[] = {
-	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO0_IRQ, "GPIO0"),
-	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO1_IRQ, "GPIO1"),
+	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
 };
 
 static struct resource adc_resources[] = {
-- 
2.7.4
