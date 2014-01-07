From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/1] thermal: fix compilation issue on CONFIG_THERMAL_OF dependencies
Date: Tue, 7 Jan 2014 08:44:27 -0400
Message-ID: <1389098667-9826-1-git-send-email-eduardo.valentin@ti.com>
References: <52CBF1CF.2000603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59085 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbaAGMqD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jan 2014 07:46:03 -0500
In-Reply-To: <52CBF1CF.2000603@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: rdunlap@infradead.org, Eduardo Valentin <eduardo.valentin@ti.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Users of API provided by THERMAL_OF config may suffer when
CONFIG_THERMAL=y, causing linking issues, such as:

drivers/built-in.o: In function `lm75_remove':
lm75.c:(.text+0x12bd8c): undefined reference to `thermal_zone_of_sensor_unregister'
drivers/built-in.o: In function `lm75_probe':
lm75.c:(.text+0x12c123): undefined reference to `thermal_zone_of_sensor_register'

Therefore, this patch limits the compilation build to always
have THERMAL=y, whenever THERMAL_OF=y. In this way, whenever
the API user is built, if THERMAL_OF=y, the build shall have
the full thermal support, otherwise, the thermal API will provide
stubs.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/Kconfig | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 58f98bd..dc315e9 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -29,19 +29,6 @@ config THERMAL_HWMON
 	  Say 'Y' here if you want all thermal sensors to
 	  have hwmon sysfs interface too.
 
-config THERMAL_OF
-	bool
-	prompt "APIs to parse thermal data out of device tree"
-	depends on OF
-	default y
-	help
-	  This options provides helpers to add the support to
-	  read and parse thermal data definitions out of the
-	  device tree blob.
-
-	  Say 'Y' here if you need to build thermal infrastructure
-	  based on device tree.
-
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
@@ -235,3 +222,19 @@ source "drivers/thermal/samsung/Kconfig"
 endmenu
 
 endif
+
+menuconfig THERMAL_OF
+	bool
+	prompt "APIs to parse thermal data out of device tree"
+	depends on OF
+	select THERMAL
+	default y
+	help
+	  This options enables DT thermal API which adds support to
+	  read and parse thermal data definitions out of the
+	  device tree blob. This option is mostly used by embedded
+	  thermal drivers.
+
+	  Say 'Y' here if you need to build thermal infrastructure
+	  based on device tree.
+
-- 
1.8.2.1.342.gfa7285d

