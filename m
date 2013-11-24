From: Austin Boyle <boyle.austin@gmail.com>
Subject: [PATCH] max17042: Fix build errors caused by missing REGMAP_I2C
 config
Date: Sun, 24 Nov 2013 21:41:49 +1100
Message-ID: <20131124214149.cf1b6444d6e43d637ea7e34b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39481 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab3KXKlz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2013 05:41:55 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>

max17042 now uses regmap interface but does not enable config option. T=
his patch fixes the following build errors:

drivers/power/max17042_battery.c:661:15: error: variable =E2=80=98max17=
042_regmap_config=E2=80=99 has initializer but incomplete type
drivers/power/max17042_battery.c:662:2: error: unknown field =E2=80=98r=
eg_bits=E2=80=99 specified in initializer
drivers/power/max17042_battery.c:662:2: warning: excess elements in str=
uct initializer
drivers/power/max17042_battery.c:662:2: warning: (near initialization f=
or =E2=80=98max17042_regmap_config=E2=80=99)
drivers/power/max17042_battery.c:663:2: error: unknown field =E2=80=98v=
al_bits=E2=80=99 specified in initializer
drivers/power/max17042_battery.c:663:2: warning: excess elements in str=
uct initializer
drivers/power/max17042_battery.c:663:2: warning: (near initialization f=
or =E2=80=98max17042_regmap_config=E2=80=99)
drivers/power/max17042_battery.c:664:2: error: unknown field =E2=80=98v=
al_format_endian=E2=80=99 specified in initializer
drivers/power/max17042_battery.c:664:23: error: =E2=80=98REGMAP_ENDIAN_=
NATIVE=E2=80=99 undeclared here (not in a function)
drivers/power/max17042_battery.c:664:2: warning: excess elements in str=
uct initializer
drivers/power/max17042_battery.c:664:2: warning: (near initialization f=
or =E2=80=98max17042_regmap_config=E2=80=99)
drivers/power/max17042_battery.c: In function =E2=80=98max17042_probe=E2=
=80=99:
drivers/power/max17042_battery.c:684:2: error: implicit declaration of =
function =E2=80=98devm_regmap_init_i2c=E2=80=99

Signed-off-by: Austin Boyle <boyle.austin@gmail.com>
---
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 5e2054a..85ad58c 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -196,6 +196,7 @@ config BATTERY_MAX17040
 config BATTERY_MAX17042
 	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
 	  in handheld and portable equipment. The MAX17042 is configured
