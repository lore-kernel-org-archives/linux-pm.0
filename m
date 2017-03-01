From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] power: supply: twl4030_charger: remove incorrect __exit
 markups
Date: Wed, 1 Mar 2017 15:44:53 -0800
Message-ID: <20170301234453.GA13831@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34545 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbdCAXpt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 18:45:49 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Even if bus is not hot-pluggable, the devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/power/supply/twl4030_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index bcd4dc304f27..990ff3d218bc 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1117,7 +1117,7 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit twl4030_bci_remove(struct platform_device *pdev)
+static int twl4030_bci_remove(struct platform_device *pdev)
 {
 	struct twl4030_bci *bci = platform_get_drvdata(pdev);
 
@@ -1148,11 +1148,11 @@ MODULE_DEVICE_TABLE(of, twl_bci_of_match);
 
 static struct platform_driver twl4030_bci_driver = {
 	.probe = twl4030_bci_probe,
+	.remove	= twl4030_bci_remove,
 	.driver	= {
 		.name	= "twl4030_bci",
 		.of_match_table = of_match_ptr(twl_bci_of_match),
 	},
-	.remove	= __exit_p(twl4030_bci_remove),
 };
 module_platform_driver(twl4030_bci_driver);
 
-- 
2.12.0.rc1.440.g5b76565f74-goog


-- 
Dmitry
