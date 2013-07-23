From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 03/27] drivers/cpuidle: don't check resource with devm_ioremap_resource
Date: Tue, 23 Jul 2013 20:01:36 +0200
Message-ID: <1374602524-3398-4-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Please apply via the subsystem-tree.

 drivers/cpuidle/cpuidle-kirkwood.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 521b0a7..2237135 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -60,9 +60,6 @@ static int kirkwood_cpuidle_probe(struct platform_device *pdev)
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL)
-		return -EINVAL;
-
 	ddr_operation_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ddr_operation_base))
 		return PTR_ERR(ddr_operation_base);
-- 
1.7.10.4
