From: sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [PATCH v4 4/9] mfd: intel_soc_pmic_bxtwc: remove second level irq for gpio device
Date: Tue, 30 May 2017 22:19:53 -0700
Message-ID: <1ea129df0d2a954dedfc99c8f818c64829110e36.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1496206507.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sathyaosid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

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

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Changes since v1:
 * None

Changes since v2: 
 * Rebased on top of latest release.

Changes since v3:
 * None

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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
