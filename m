From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 3/8] thermal: intel_bxt_pmic_thermal: use first level PMIC thermal irq
Date: Fri, 14 Apr 2017 16:25:55 -0700
Message-ID: <fda73b083e5e67e8fcc9fc2d01a590f689a06c91.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29855 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755822AbdDNX3j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 19:29:39 -0400
In-Reply-To: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
 drivers/thermal/intel_bxt_pmic_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v1:
 * None

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
