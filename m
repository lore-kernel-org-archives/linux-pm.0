From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/3] power_supply: bq27xxx_battery: Fix copy/paste error in header comment
Date: Tue, 31 May 2016 13:44:58 -0500
Message-ID: <20160531184500.10871-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:45882 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbcEaSpF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 31 May 2016 14:45:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27xxx_battery_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq27xxx_battery_i2c.c b/drivers/power/bq27xxx_battery_i2c.c
index b8f8d3a..85d4ea2 100644
--- a/drivers/power/bq27xxx_battery_i2c.c
+++ b/drivers/power/bq27xxx_battery_i2c.c
@@ -1,5 +1,5 @@
 /*
- * SCI Reset driver for Keystone based devices
+ * BQ27xxx battery monitor I2C driver
  *
  * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
-- 
2.8.3

