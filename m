From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] hwmon: Fix SENSORS_TMP102 dependencies to eliminate build
 errors
Date: Wed, 8 Jan 2014 08:05:57 +0100
Message-ID: <20140108080557.3439ec23@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:14007 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaAHHGY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 02:06:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-pm@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Guenter Roeck <linux@roeck-us.net>

Similar to what was done for the lm75 driver.

Add depends on THERMAL since that is what provides the
register/unregister functions above, but only if THERMAL_OF was
selected as this is an optional feature of the driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/hwmon/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-3.13-rc7.orig/drivers/hwmon/Kconfig	2014-01-08 08:00:58.583072658 +0100
+++ linux-3.13-rc7/drivers/hwmon/Kconfig	2014-01-08 08:01:36.928977997 +0100
@@ -1285,6 +1285,7 @@ config SENSORS_THMC50
 config SENSORS_TMP102
 	tristate "Texas Instruments TMP102"
 	depends on I2C
+	depends on THERMAL || !THERMAL_OF
 	help
 	  If you say yes here you get support for Texas Instruments TMP102
 	  sensor chips.


-- 
Jean Delvare
