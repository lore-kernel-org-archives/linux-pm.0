From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/3] power: bq27xxx_battery: fix defined but not used warnings
Date: Fri, 16 Oct 2015 15:44:12 +0200
Message-ID: <1445003052-31373-4-git-send-email-sre@kernel.org>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:34750 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbbJPNo5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 09:44:57 -0400
In-Reply-To: <1445003052-31373-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

If BQ27XXX is enabled, but neither I2C based initialization, nor
platform based initialization are activated, bq27xxx_powersupply_init
and bq27xxx_powersupply_unregister are defined but not used.

This configuration doesn't make sense, but there is no easy way
to make it unavailable in the build system, so just mark the
functions as __maybe_unused instead.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/bq27xxx_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 880233ce9343..452c9f079e0d 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
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
-- 
2.6.1

