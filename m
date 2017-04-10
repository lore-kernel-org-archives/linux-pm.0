From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/7] mfd: intel_soc_pmic_bxtwc: fix TMU interrupt index
Date: Mon, 10 Apr 2017 11:52:23 -0700
Message-ID: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org, hdegoede@redhat.com
Cc: linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

TMU interrupts are registered as a separate interrupt chip, and
hence it should start its interrupt index(BXTWC_TMU_IRQ) number
from 0. But currently, BXTWC_TMU_IRQ is defined as part of enum
bxtwc_irqs_level2 and its index value is 11. Since this index
value is used when calculating .num_irqs of regmap_irq_chip_tmu,
it incorrectly reports number of irqs as 12 instead of actual
value of 1.

static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
	REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
};

static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
	.name = "bxtwc_irq_chip_tmu",
	.status_base = BXTWC_TMUIRQ,
	.mask_base = BXTWC_MTMUIRQ,
	.irqs = bxtwc_regmap_irqs_tmu,
	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_tmu),
	.num_regs = 1,
};

This patch fixes this issue by creating new enum of tmu irqs and
resetting its starting index to 0.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 699c8c7..bb18e20 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -94,7 +94,10 @@ enum bxtwc_irqs_level2 {
 	BXTWC_GPIO0_IRQ,
 	BXTWC_GPIO1_IRQ,
 	BXTWC_CRIT_IRQ,
-	BXTWC_TMU_IRQ,
+};
+
+enum bxtwc_irqs_tmu {
+	BXTWC_TMU_IRQ = 0,
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs[] = {
-- 
2.7.4

