Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56123D9688;
	Thu, 25 Jun 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407272; cv=none; b=M1BvK+v1AKDYDj10YXcKZGTVPCIkXijUI6tEOiWUGp+4b6bbg6RN00OtZByvCi3RWSAj8vfznSRkNqD0zpessUIDaqGIXd0xPoggJL5dSm96NjEJORYhDqwfKe2AWcwz9dZIujOP3W5IKjTuMy5EWi3/4F8czAD7MLGckH9L+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407272; c=relaxed/simple;
	bh=bnYXH0lOLHdZvIPsRngPxa9h8NfxvI/Sd70LwIpMEag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onQ7O6rPwjC45l9mXcyWP5M4k78Gmvth4Sug6GKDe2mQsdn9D5u++VxBSqAw1nqihPU+WSEpCB7704lvGWufPv6B6jQ4LkLoyJHgyJs8YLDmhqxIxB9c9UmkZA3WTiDLBPHv8AXOwOkf4Cus4pwUjq8A68z4sLomTq+lPIEJyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=t1nZ9gkZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="t1nZ9gkZ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gmQGn2TSxz9t6W;
	Thu, 25 Jun 2026 19:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1782407265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VwJS2KsuOD9m66ITNHoqe/Upe6CiqeoXwItuWdYRdw=;
	b=t1nZ9gkZTORoTDZPMp2BJdGi03UE1eBJcm2/hbRSpbaYzJ6wNKz9TapwFreiAd7AvIAb4K
	2vLeUP9B5xk/CFlAiTAeIzTd2gSVBGlu4CQaqE/H+u5dTW2KkYSAASWvwya380Z2vLERwm
	6poysZ1fjGd62iE66zea4xoV3V1KAW8rVBUQPxId1W533nOGrHHKeF8p+6D4XcYXI1HlRJ
	N9JWrPprwYk7hzR3SrXYRV3YqJ0qp609Nw9AiW8ZZPzstCeu1yTUgGMM356DivuZT82Y8U
	AoMg+RRC1pmNRFc2RLjIF7QsItz+BDlg6YbEDUNAhU3lBIegRbML7Kxe+NiiQg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 25 Jun 2026 19:07:34 +0200
Subject: [PATCH 1/2] power: supply: leds: create triggers based on
 properties, not type
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-std-power-supply-triggers-v1-1-d80db570d329@beckhoff.com>
References: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
In-Reply-To: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782407261; l=7207;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=gND+aD6N0iBP2NMdN+hfsN7FyxJ4ZCoyKYItQIUT37I=;
 b=MfpJtUyJJ61xLYZ14Wj1mRcuZllEgLJeTvSngzoQYN8wQZwGKXfz39B2T/jM3AMsdJrxz5Gwn
 oQ7xrET4ODNDdy6uq4gO5UMiKd3aVWLZLemaFhJDKa476sMKx3wi53/
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4gmQGn2TSxz9t6W

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Currently only battery power supplies get triggers for other properties
and other supplies only get the online trigger.

This changes it to provide the triggers for any power supply depending
on what properties are available. Batteries will still get the same
triggers if the properties are there, but now other power supplies can
get the triggers too.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/power/supply/power_supply_leds.c | 88 ++++++++++++++++----------------
 include/linux/power_supply.h             |  3 +-
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index 1548aaba3362..538cc0440e53 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -17,8 +17,6 @@
 
 #include "power_supply.h"
 
-/* Battery specific LEDs triggers. */
-
 struct power_supply_led_trigger {
 	struct led_trigger trig;
 	struct power_supply *psy;
@@ -89,7 +87,7 @@ static void power_supply_unregister_led_trigger(struct led_trigger *trig)
 	kfree(psy_trig);
 }
 
-static void power_supply_update_bat_leds(struct power_supply *psy)
+static void power_supply_update_status_leds(struct power_supply *psy)
 {
 	union power_supply_propval status;
 	unsigned int intensity_green[3] = { 0, 255, 0 };
@@ -102,7 +100,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 
 	switch (status.intval) {
 	case POWER_SUPPLY_STATUS_FULL:
-		led_trigger_event(psy->trig, LED_FULL);
+		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_FULL);
 		/* Going from blink to LED on requires a LED_OFF event to stop blink */
@@ -114,7 +112,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 				     LED_FULL);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
-		led_trigger_event(psy->trig, LED_FULL);
+		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
 		led_trigger_event(psy->charging_trig, LED_FULL);
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
@@ -124,7 +122,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 				     LED_FULL);
 		break;
 	default:
-		led_trigger_event(psy->trig, LED_OFF);
+		led_trigger_event(psy->charging_or_full_trig, LED_OFF);
 		led_trigger_event(psy->charging_trig, LED_OFF);
 		led_trigger_event(psy->full_trig, LED_OFF);
 		led_trigger_event(psy->charging_blink_full_solid_trig,
@@ -135,21 +133,15 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 	}
 }
 
-static void power_supply_remove_bat_triggers(struct power_supply *psy)
-{
-	power_supply_unregister_led_trigger(psy->trig);
-	power_supply_unregister_led_trigger(psy->charging_trig);
-	power_supply_unregister_led_trigger(psy->full_trig);
-	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
-	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
-}
-
-static int power_supply_create_bat_triggers(struct power_supply *psy)
+static int power_supply_create_status_triggers(struct power_supply *psy)
 {
 	int err = 0;
 
+	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_STATUS))
+		return 0;
+
 	power_supply_register_led_trigger(psy, "%s-charging-or-full",
-					  &psy->trig, &err);
+					  &psy->charging_or_full_trig, &err);
 	power_supply_register_led_trigger(psy, "%s-charging",
 					  &psy->charging_trig, &err);
 	power_supply_register_led_trigger(psy, "%s-full",
@@ -158,15 +150,11 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
 					  &psy->charging_blink_full_solid_trig, &err);
 	power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
 					  &psy->charging_orange_full_green_trig, &err);
-	if (err)
-		power_supply_remove_bat_triggers(psy);
 
 	return err;
 }
 
-/* Generated power specific LEDs triggers. */
-
-static void power_supply_update_gen_leds(struct power_supply *psy)
+static void power_supply_update_online_leds(struct power_supply *psy)
 {
 	union power_supply_propval online;
 
@@ -175,43 +163,53 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
 
-	if (online.intval)
-		led_trigger_event(psy->trig, LED_FULL);
-	else
-		led_trigger_event(psy->trig, LED_OFF);
+	led_trigger_event(psy->online_trig, online.intval ? LED_FULL : LED_OFF);
 }
 
-static int power_supply_create_gen_triggers(struct power_supply *psy)
+static int power_supply_create_online_trigger(struct power_supply *psy)
 {
-	return power_supply_register_led_trigger(psy, "%s-online", &psy->trig, NULL);
-}
+	int err = 0;
 
-static void power_supply_remove_gen_triggers(struct power_supply *psy)
-{
-	power_supply_unregister_led_trigger(psy->trig);
-}
+	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_ONLINE))
+		return 0;
 
-/* Choice what triggers to create&update. */
+	power_supply_register_led_trigger(psy, "%s-online", &psy->online_trig,
+					  &err);
+
+	return err;
+}
 
 void power_supply_update_leds(struct power_supply *psy)
 {
-	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
-		power_supply_update_bat_leds(psy);
-	else
-		power_supply_update_gen_leds(psy);
+	power_supply_update_online_leds(psy);
+	power_supply_update_status_leds(psy);
 }
 
 int power_supply_create_triggers(struct power_supply *psy)
 {
-	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
-		return power_supply_create_bat_triggers(psy);
-	return power_supply_create_gen_triggers(psy);
+	int err;
+
+	err = power_supply_create_online_trigger(psy);
+	if (err)
+		goto err_remove;
+
+	err = power_supply_create_status_triggers(psy);
+	if (err)
+		goto err_remove;
+
+	return 0;
+
+err_remove:
+	power_supply_remove_triggers(psy);
+	return err;
 }
 
 void power_supply_remove_triggers(struct power_supply *psy)
 {
-	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
-		power_supply_remove_bat_triggers(psy);
-	else
-		power_supply_remove_gen_triggers(psy);
+	power_supply_unregister_led_trigger(psy->online_trig);
+	power_supply_unregister_led_trigger(psy->charging_or_full_trig);
+	power_supply_unregister_led_trigger(psy->charging_trig);
+	power_supply_unregister_led_trigger(psy->full_trig);
+	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
+	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a0..68b65682b14d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -346,7 +346,8 @@ struct power_supply {
 #endif
 
 #ifdef CONFIG_LEDS_TRIGGERS
-	struct led_trigger *trig;
+	struct led_trigger *charging_or_full_trig;
+	struct led_trigger *online_trig;
 	struct led_trigger *charging_trig;
 	struct led_trigger *full_trig;
 	struct led_trigger *charging_blink_full_solid_trig;

-- 
2.54.0

