From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 3/7] thermal: intel_bxt_pmic_thermal: use first level PMIC thermal irq
Date: Mon, 10 Apr 2017 11:52:25 -0700
Message-ID: <7ec363b906f8334f6fb98f1a21609884191d23ed.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org, hdegoede@redhat.com
Cc: linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

PMIC mfd driver only exports first level irq for thermal device.
But currently we are reading the irqs from the second level irq
chip, So this patch fixes this issue by adding support to use
first level PMIC thermal irq.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/thermal/intel_bxt_pmic_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

