From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 7/7] platform: x86: intel_bxtwc_tmu: remove first level irq unmask
Date: Mon, 10 Apr 2017 11:52:29 -0700
Message-ID: <17d331d34c77fa78ac8ad140de0fece1192aa4e2.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org, hdegoede@redhat.com
Cc: linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently in WCOVE PMIC mfd driver, all second level irq chips
are chained to the respective first level irqs. So there is no
need for explicitly unmasking the first level irq in this
driver. This patches removes this level 1 irq unmask support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_bxtwc_tmu.c | 4 ----
 1 file changed, 4 deletions(-)

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
