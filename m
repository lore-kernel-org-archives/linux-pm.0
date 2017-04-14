From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 4/8] mfd: intel_soc_pmic_bxtwc: remove second level irq for gpio device
Date: Fri, 14 Apr 2017 16:25:56 -0700
Message-ID: <bb707d6f9f5540e71626c8d48a9b9919c7ca6b01.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755835AbdDNX3k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 19:29:40 -0400
In-Reply-To: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index c08d514..dc8af1d 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -88,8 +88,6 @@ enum bxtwc_irqs_level2 {
 	BXTWC_USBC_IRQ,
 	BXTWC_CHGR0_IRQ,
 	BXTWC_CHGR1_IRQ,
-	BXTWC_GPIO0_IRQ,
-	BXTWC_GPIO1_IRQ,
 	BXTWC_CRIT_IRQ,
 };
 
@@ -115,8 +113,6 @@ static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
 	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
 	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
 	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_GPIO0_IRQ, 4, 0xff),
-	REGMAP_IRQ_REG(BXTWC_GPIO1_IRQ, 5, 0x3f),
 	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
 };
 
@@ -152,8 +148,7 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
 };
 
 static struct resource gpio_resources[] = {
-	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO0_IRQ, "GPIO0"),
-	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO1_IRQ, "GPIO1"),
+	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
 };
 
 static struct resource adc_resources[] = {
-- 
2.7.4
