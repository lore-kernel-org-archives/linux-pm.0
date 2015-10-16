From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] power: bq27xxx_battery: Remove unneeded dependency in Kconfig
Date: Fri, 16 Oct 2015 09:49:20 -0500
Message-ID: <1445006960-3655-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38651 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbJPOt2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 10:49:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

I2C is only required when using the config item BATTERY_BQ27XXX_I2C which
already depends on the I2C subsystem, remove the unneeded dependency from
BATTERY_BQ27XXX.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index eeb5776..34aa017 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -159,7 +159,6 @@ config BATTERY_SBS
 
 config BATTERY_BQ27XXX
 	tristate "BQ27xxx battery driver"
-	depends on I2C || I2C=n
 	help
 	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ) chips.
 
-- 
1.9.1

