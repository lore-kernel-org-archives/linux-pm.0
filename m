Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B21D5174;
	Thu, 25 Jun 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407272; cv=none; b=O7dSKs6eaLT2yje65huYfysaFwDPqRP77qlFFHaU0kMaa4KGhFcxLqqviHaEv/AMtuPIPuiSKRybbKYo/hnfzsvlIz8Z2CO1wn/6Ej3hBTTllJqLowdev6Ru6a6o2sXmvtyraa6u20SpRRypdaK//nRz+CqiTqdTCjBY2KBKppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407272; c=relaxed/simple;
	bh=3OrnZFBPbVV5Sb9axsd5lLcxx/AJ2uGLIK/sIYxvTAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+NmxNz/5Tj35hcjUpBfy2fKW+n4/z32OAXgYY7YvGgQ2sBzJNK2amE54YaNkxoDGj2QyWV5333okJ42eAQUndyW2ax5TX+G1024wUt1nJGNqH3UZZbBrvRhzqyYFQLMpkVbAlCCnLkMS/609mz2q7U0vddctd2ahFEyC7E2eqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=Q49NvJLI; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="Q49NvJLI"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gmQGp3yBjz9tgB;
	Thu, 25 Jun 2026 19:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1782407266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B91AhuTtQGkYT5URvzYhx2Ce7ga49uf4NQCIrdgzwrU=;
	b=Q49NvJLI7kUJ+AYyzrRniCSzpEMic1aK411+weooz951R595E+FwD8zHM7HHEiDMLIyMzO
	1yDJCYzKJDSYznUhUGoFme5y3vVN3mcEmO2xAnJ6/p8xTC7Ob2ZJ44NW8P3DMJMVch7jUl
	G8f91uK6heaH7SeG0wWzVCXeKzOJPLv7me+wfHIIxAZp1/0dSr7M48IzeZMdiYaaRCA/Yn
	eAu/qqLjAYTUuB03L4RiAOovhjp4TP5esLOybFJxjwurIz8xaGLXa4I6j73kcS8eUbhRYr
	NshtoBnRn6/JA46ymM4g+MSot9XyJOVYwsY6m3KXKDeELOvMkdUooKzmAiod3w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 25 Jun 2026 19:07:35 +0200
Subject: [PATCH 2/2] power: supply: leds: add a not-charging trigger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-std-power-supply-triggers-v1-2-d80db570d329@beckhoff.com>
References: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
In-Reply-To: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782407261; l=2421;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=QPl08tNHBYaAsAMerAoV4E+unXMqWwAmJOunNP7YlaI=;
 b=XAfHCNZ+xVIeLYHuStSBlENHeruAKMywKOs14jNsXVp/yY8EHHk5U5qXvDkiqQO1sNtxXT/+z
 PKLM13zhNMvDL0ZiRXHpSpbyWsswnwhpy4sHe8kC7l1rGsSEbdzl4x8
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4gmQGp3yBjz9tgB

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

We intend to use this with a gpio-charger ups device that reports
charging or not-charging based on a gpio to set a "power failure" led.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/power/supply/power_supply_leds.c | 7 +++++++
 include/linux/power_supply.h             | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index 538cc0440e53..c82a3628765c 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -131,6 +131,10 @@ static void power_supply_update_status_leds(struct power_supply *psy)
 			LED_OFF);
 		break;
 	}
+
+	led_trigger_event(psy->not_charging_trig,
+			  status.intval == POWER_SUPPLY_STATUS_NOT_CHARGING ?
+			  LED_FULL : LED_OFF);
 }
 
 static int power_supply_create_status_triggers(struct power_supply *psy)
@@ -150,6 +154,8 @@ static int power_supply_create_status_triggers(struct power_supply *psy)
 					  &psy->charging_blink_full_solid_trig, &err);
 	power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
 					  &psy->charging_orange_full_green_trig, &err);
+	power_supply_register_led_trigger(psy, "%s-not-charging",
+					  &psy->not_charging_trig, &err);
 
 	return err;
 }
@@ -209,6 +215,7 @@ void power_supply_remove_triggers(struct power_supply *psy)
 	power_supply_unregister_led_trigger(psy->online_trig);
 	power_supply_unregister_led_trigger(psy->charging_or_full_trig);
 	power_supply_unregister_led_trigger(psy->charging_trig);
+	power_supply_unregister_led_trigger(psy->not_charging_trig);
 	power_supply_unregister_led_trigger(psy->full_trig);
 	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
 	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 68b65682b14d..9052610e3910 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -349,6 +349,7 @@ struct power_supply {
 	struct led_trigger *charging_or_full_trig;
 	struct led_trigger *online_trig;
 	struct led_trigger *charging_trig;
+	struct led_trigger *not_charging_trig;
 	struct led_trigger *full_trig;
 	struct led_trigger *charging_blink_full_solid_trig;
 	struct led_trigger *charging_orange_full_green_trig;

-- 
2.54.0

