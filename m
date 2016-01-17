From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] MAINTAINERS: update bq27xxx driver
Date: Sun, 17 Jan 2016 21:45:39 +0100
Message-ID: <1453063539-18483-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.101.7]:33397 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbcAQUqM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 17 Jan 2016 15:46:12 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>

Update reviewers for bq27xxx, so that Pali and Andrew
are reviewers with status and maintainer inherited from
the power supply subsystem entry.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Cc: Andrew F. Davis <afd@ti.com>
---
 MAINTAINERS | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04d62b1e8b17..6b0098f0a098 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7581,13 +7581,13 @@ S:	Maintained
 F:	arch/nios2/
=20
 NOKIA N900 POWER SUPPLY DRIVERS
-M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
-S:	Maintained
+R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
 F:	include/linux/power/bq2415x_charger.h
 F:	include/linux/power/bq27xxx_battery.h
 F:	include/linux/power/isp1704_charger.h
 F:	drivers/power/bq2415x_charger.c
 F:	drivers/power/bq27xxx_battery.c
+F:	drivers/power/bq27xxx_battery_i2c.c
 F:	drivers/power/isp1704_charger.c
 F:	drivers/power/rx51_battery.c
=20
@@ -9414,6 +9414,12 @@ M:	Andreas Noever <andreas.noever@gmail.com>
 S:	Maintained
 F:	drivers/thunderbolt/
=20
+TI BQ27XXX POWER SUPPLY DRIVER
+R:	Andrew F. Davis <afd@ti.com>
+F:	include/linux/power/bq27xxx_battery.h
+F:	drivers/power/bq27xxx_battery.c
+F:	drivers/power/bq27xxx_battery_i2c.c
+
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
 M:	John Stultz <john.stultz@linaro.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
--=20
2.7.0.rc3

