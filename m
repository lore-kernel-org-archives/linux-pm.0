From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 8/8] platform: x86: intel_bxtwc_tmu: remove first level irq unmask
Date: Tue, 23 May 2017 10:30:06 -0700
Message-ID: <b9a8c2d33378aff3258f1c87c871fa2b521e5afc.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170523072615.r4widzjc6apwxpwb@dell>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1320 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967750AbdEWReh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 13:34:37 -0400
In-Reply-To: <20170523072615.r4widzjc6apwxpwb@dell>
In-Reply-To: <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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
