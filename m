From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 27/33] thermal: Convert to devm_ioremap_resource()
Date: Mon, 21 Jan 2013 11:09:20 +0100
Message-ID: <1358762966-20791-28-git-send-email-thierry.reding@avionic-design.de>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/exynos_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 224751e..bada130 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -866,11 +866,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	data->base = devm_request_and_ioremap(&pdev->dev, data->mem);
-	if (!data->base) {
-		dev_err(&pdev->dev, "Failed to ioremap memory\n");
-		return -ENODEV;
-	}
+	data->base = devm_ioremap_resource(&pdev->dev, data->mem);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
 
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING, "exynos-tmu", data);
-- 
1.8.1.1
