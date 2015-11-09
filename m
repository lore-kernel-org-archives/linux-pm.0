From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] power: bq27xxx_battery: Add I2C module check dependency in Kconfig
Date: Mon, 9 Nov 2015 15:23:03 -0600
Message-ID: <1447104183-13556-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, Xiong Zhou <jencce.kernel@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

Check if I2C core has been built as a module when BATTERY_BQ27XXX
is built-in. If so disable I2C functionality.

Fixes: 6bd03ce3c12a ("power: bq27xxx_battery: Remove unneeded dependency in Kconfig")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 237d7aa..2f944d7 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -166,6 +166,7 @@ config BATTERY_BQ27XXX_I2C
 	bool "BQ27xxx I2C support"
 	depends on BATTERY_BQ27XXX
 	depends on I2C
+	depends on !(I2C=m && BATTERY_BQ27XXX=y)
 	default y
 	help
 	  Say Y here to enable support for batteries with BQ27xxx (I2C) chips.
-- 
1.9.1
