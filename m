From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 3/8] thermal: intel_bxt_pmic_thermal: use first level PMIC thermal irq
Date: Tue, 23 May 2017 10:30:01 -0700
Message-ID: <040f4eb6192c0e591de2c8a5c31f0a219f473a9b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170523072615.r4widzjc6apwxpwb@dell>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59189 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966155AbdEWReR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 13:34:17 -0400
In-Reply-To: <20170523072615.r4widzjc6apwxpwb@dell>
In-Reply-To: <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <75e12563a835dc4f8e8dab26ecea46822262604b.1495559980.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

PMIC mfd driver only exports first level irq for thermal device.
But currently we are reading the irqs from the second level irq
chip, So this patch fixes this issue by adding support to use
first level PMIC thermal irq.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel_bxt_pmic_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v1:
 * None

Changes since v2: 
 * Rebased on top of latest release.

diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
index 0f19a39..ef6b322 100644
--- a/drivers/thermal/intel_bxt_pmic_thermal.c
+++ b/drivers/thermal/intel_bxt_pmic_thermal.c
@@ -241,7 +241,7 @@ static int pmic_thermal_probe(struct platform_device *pdev)
 	}
 
 	regmap = pmic->regmap;
-	regmap_irq_chip = pmic->irq_chip_data_level2;
+	regmap_irq_chip = pmic->irq_chip_data;
 
 	pmic_irq_count = 0;
 	while ((irq = platform_get_irq(pdev, pmic_irq_count)) != -ENXIO) {
-- 
2.7.4
