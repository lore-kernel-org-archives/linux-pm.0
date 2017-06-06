From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 7/7] thermal: max77620: fix pinmux conflict on reprobe
Date: Tue,  6 Jun 2017 17:59:04 +0200
Message-ID: <20170606155904.26819-8-johan@kernel.org>
References: <20170606155904.26819-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606155904.26819-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@nxp.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Use the new helper for reusing a device-tree node of another device
instead of managing the node references explicitly.

This also makes sure that the new of_node_reuse flag is set if the
device is ever reprobed, something which specifically now avoids driver
core from attempting to claim any pinmux resources already claimed by
the parent device.

Fixes: ec4664b3fd6d ("thermal: max77620: Add thermal driver for reporting junction temp")
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/thermal/max77620_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 71d35f3c9215..159bbcee8821 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -112,12 +112,10 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Drop any current reference to a device-tree node and get a
-	 * reference to the parent's node which will be balanced on reprobe or
-	 * on platform-device release.
+	 * The reference taken to the parent's node which will be balanced on
+	 * reprobe or on platform-device release.
 	 */
-	of_node_put(pdev->dev.of_node);
-	pdev->dev.of_node = of_node_get(pdev->dev.parent->of_node);
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	mtherm->tz_device = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
 				mtherm, &max77620_thermal_ops);
-- 
2.13.0
