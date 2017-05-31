From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 9/9] usb: typec: typec_wcove: Use charger irq chip to get usbc virq
Date: Tue, 30 May 2017 22:19:58 -0700
Message-ID: <1f736aa673c542262cb0bac554017843f01c0cd0.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently, in Whiskey cove PMIC driver, USBC IRQ is moved under charger
level2 irq chip. So use irq_chip_data_chgr to get the USBC virtual IRQ
number.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/usb/typec/typec_wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v3:
 * Added typec fix.

diff --git a/drivers/usb/typec/typec_wcove.c b/drivers/usb/typec/typec_wcove.c
index d5a7b21..00a4bd2 100644
--- a/drivers/usb/typec/typec_wcove.c
+++ b/drivers/usb/typec/typec_wcove.c
@@ -303,7 +303,7 @@ static int wcove_typec_probe(struct platform_device *pdev)
 	wcove->dev = &pdev->dev;
 	wcove->regmap = pmic->regmap;
 
-	ret = regmap_irq_get_virq(pmic->irq_chip_data_level2,
+	ret = regmap_irq_get_virq(pmic->irq_chip_data_chgr,
 				  platform_get_irq(pdev, 0));
 	if (ret < 0)
 		return ret;
-- 
2.7.4
