From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] power: ipaq_micro_battery: fix alias
Date: Tue, 01 Nov 2016 09:59:50 +0000
Message-ID: <E1c1VrC-0000LC-Jo@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44480 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034822AbcKAJ7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 05:59:54 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

The alias for the ipaq_micro_battery driver is incorrect, fix it so the
module can be auto-loaded.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/power/supply/ipaq_micro_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/supply/ipaq_micro_battery.c
index 4af7b770f293..2fa6edd6e8b1 100644
--- a/drivers/power/supply/ipaq_micro_battery.c
+++ b/drivers/power/supply/ipaq_micro_battery.c
@@ -313,4 +313,4 @@ module_platform_driver(micro_batt_device_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("driver for iPAQ Atmel micro battery");
-MODULE_ALIAS("platform:battery-ipaq-micro");
+MODULE_ALIAS("platform:ipaq-micro-battery");
-- 
2.1.0

