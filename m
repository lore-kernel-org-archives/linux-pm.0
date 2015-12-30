From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer for the bq27xxx driver.
Date: Wed, 30 Dec 2015 12:35:41 -0600
Message-ID: <1451500541-2442-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49516 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbL3Sfw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2015 13:35:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 MAINTAINERS | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44666b1..046d001 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7605,10 +7605,8 @@ NOKIA N900 POWER SUPPLY DRIVERS
 M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
 S:	Maintained
 F:	include/linux/power/bq2415x_charger.h
-F:	include/linux/power/bq27xxx_battery.h
 F:	include/linux/power/isp1704_charger.h
 F:	drivers/power/bq2415x_charger.c
-F:	drivers/power/bq27xxx_battery.c
 F:	drivers/power/isp1704_charger.c
 F:	drivers/power/rx51_battery.c
=20
@@ -10710,6 +10708,14 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/thermal/ti-soc-thermal/
=20
+TI BQ27XXX POWER SUPPLY DRIVER
+M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
+R:	Andrew F. Davis <afd@ti.com>
+S:	Maintained
+F:	include/linux/power/bq27xxx_battery.h
+F:	drivers/power/bq27xxx_battery.c
+F:	drivers/power/bq27xxx_battery_i2c.c
+
 TI CDCE706 CLOCK DRIVER
 M:	Max Filippov <jcmvbkbc@gmail.com>
 S:	Maintained
--=20
2.6.4

