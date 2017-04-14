From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 1/8] mfd: intel_soc_pmic_bxtwc: fix TMU interrupt index
Date: Fri, 14 Apr 2017 16:25:53 -0700
Message-ID: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755540AbdDNX3h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 19:29:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

TMU interrupts are registered as a separate interrupt chip, and
hence it should start its interrupt index(BXTWC_TMU_IRQ) number
from 0. But currently, BXTWC_TMU_IRQ is defined as part of enum
bxtwc_irqs_level2 and its index value is 11. Since this index
value is used when calculating .num_irqs of regmap_irq_chip_tmu,
it incorrectly reports number of irqs as 12 instead of actual
value of 1.

This patch fixes this issue by creating new enum of tmu irqs and
resetting its starting index to 0.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Changes since v1: 
 * Removed code from commit message.

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
