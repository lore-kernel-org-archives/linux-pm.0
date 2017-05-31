From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 1/8] mfd: intel_soc_pmic_bxtwc: Fix TMU interrupt index
Date: Wed, 31 May 2017 15:37:09 -0700
Message-ID: <c2d9fd92df80132f3629c1a54b9873687b5b4a35.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170531070225.bymdhhpclidwwtpt@dell>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170531070225.bymdhhpclidwwtpt@dell>
In-Reply-To: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

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

Changes since v2: 
 * Rebased on top of latest release.

Changes sinve v3:
 * Rebased on top of latest release.

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 8c3cbf6..7cbaf1e 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -95,7 +95,10 @@ enum bxtwc_irqs_level2 {
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
