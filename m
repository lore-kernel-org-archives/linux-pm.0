From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 6/6] platform/x86: intel_bxtwc_tmu: Remove first level IRQ unmask
Date: Mon,  5 Jun 2017 12:08:06 -0700
Message-ID: <e0715b5794f59243193c8c41a6af929e89ff703c.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdFETLk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jun 2017 15:11:40 -0400
In-Reply-To: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
In-Reply-To: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently in WCOVE PMIC MFD driver, all second level IRQ chips
are chained to the respective first level IRQs. So there is no
need for explicitly unmasking the first level IRQ in this
driver. This patches removes this level 1 IRQ unmask support.

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

Changes since v5:
 * Changed irq->IRQ, mfd->MFD.

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
