From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: bq27xxx_battery: avoid unused function warnings
Date: Mon, 23 Nov 2015 14:42:29 +0100
Message-ID: <4421924.EN5kWY38Jp@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andreas Dannenberg <dannenberg@ti.com>, "Andrew F. Davis" <afd@ti.com>, Pali Rohar <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

We can configure the bq27xxx_battery driver with neither the I2C
nor the platform driver backends, which leaves out all references
to some of the symbols, causing a couple of warnings in many
randconfig builds:

drivers/power/bq27xxx_battery.c:288:12: warning: 'bq27xxx_regs' defined but not used [-Wunused-variable]
drivers/power/bq27xxx_battery.c:994:12: warning: 'bq27xxx_powersupply_init' defined but not used [-Wunused-function]
drivers/power/bq27xxx_battery.c:1029:13: warning: 'bq27xxx_powersupply_unregister' defined but not used [-Wunused-function]

I first tried replacing the existing #ifdefs with if(IS_ENABLED()
statements, but that failed because the i2c framework does not
declare functions when they are left out of the kernel.

This just marks the unused functions as __maybe_unused, which is
a correct description here. A better fix would be to restructure
the driver into separate files and only build the common parts
if at least one of the two bus specific drivers is enabled, but
that requires much more work and testing on real hardware.

For the time being, my simpler change at least avoids the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 880233ce9343..6c3a447f378b 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -285,7 +285,7 @@ static u8 bq27421_regs[] = {
 	0x18,	/* AP		*/
 };
 
-static u8 *bq27xxx_regs[] = {
+static u8 *bq27xxx_regs[] __maybe_unused = {
 	[BQ27000] = bq27000_regs,
 	[BQ27010] = bq27010_regs,
 	[BQ27500] = bq27500_regs,
@@ -991,7 +991,7 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	schedule_delayed_work(&di->work, 0);
 }
 
-static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
+static int __maybe_unused bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
 				    const char *name)
 {
 	int ret;
@@ -1026,7 +1026,7 @@ static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
 	return 0;
 }
 
-static void bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
+static void __maybe_unused bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
 {
 	/*
 	 * power_supply_unregister call bq27xxx_battery_get_property which
