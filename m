From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 8/9] platform: x86: intel_bxtwc_tmu: remove first level irq unmask
Date: Tue, 30 May 2017 22:19:57 -0700
Message-ID: <a746c0702d6ba922048cfe0902250895402a0a90.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
