From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 8/8] platform/x86: intel_bxtwc_tmu: Remove first level irq unmask
Date: Wed, 31 May 2017 15:37:16 -0700
Message-ID: <c0439bf64b2eeef807b6197066dbf6118ca09b5e.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170531070225.bymdhhpclidwwtpt@dell>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531070225.bymdhhpclidwwtpt@dell>
In-Reply-To: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently in WCOVE PMIC mfd driver, all second level irq chips
are chained to the respective first level irqs. So there is no
need for explicitly unmasking the first level irq in this
driver. This patches removes this level 1 irq unmask support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/intel_bxtwc_tmu.c | 4 ----
 1 file changed, 4 deletions(-)

Changes since v1:
 * None

Changes since v2:
 * Rebased on top of latest release.

Changes since v3:
 * None

Changes since v4:
 * Changed commit subject from "platform: x86:" "to platform/x86:"

diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel_bxtwc_tmu.c
index e202abd..ea865d4 100644
--- a/drivers/platform/x86/intel_bxtwc_tmu.c
+++ b/drivers/platform/x86/intel_bxtwc_tmu.c
@@ -92,10 +92,6 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 	}
 	wctmu->irq = virq;
 
-	/* Enable TMU interrupts */
-	regmap_update_bits(wctmu->regmap, BXTWC_MIRQLVL1,
-				  BXTWC_MIRQLVL1_MTMU, 0);
-
 	/* Unmask TMU second level Wake & System alarm */
 	regmap_update_bits(wctmu->regmap, BXTWC_MTMUIRQ_REG,
 				  BXTWC_TMU_ALRM_MASK, 0);
-- 
2.7.4
