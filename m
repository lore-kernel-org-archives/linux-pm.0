From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 3/8] thermal: intel_bxt_pmic_thermal: Use first level PMIC thermal irq
Date: Wed, 31 May 2017 15:37:11 -0700
Message-ID: <3e58ab749a67cce5c956ef13db8563fb0a8bc190.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v3: 
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
