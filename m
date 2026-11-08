Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149173;
	b=d3gZnosMfRI5zGMn6mzRQP58u7kJ++tmLi6xE/dNWB1PORmKY9TA4mAmHQK7x+1rfHkI
	 yijvgmsls/FGQs5VNhYOpMvwJiIj9lmR1ITftnQr+4aIufOg7tb/9cmulmkroQXb6SfeW
	 HLS1RjaHEkVhQEh7n859oh7ONbehnadR7ZNeEjHJn5HxnskdwfuN5t9NWQqIOf6V5tLhi
	 Y0SJPI76u7GJC1ElN5ziiiFexoOSm+uRDbsjPJqqdWCE+YQBJKDRjPVa+d7eHoxvLFG/L
	 NYO+S4K/o5IkDWlUgVziymjUrVzQ/ifyJyTvb1InvhfIHKOwuZXKUzCR46kGJNqsFnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149173;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7v88RxTHzZk8rIHyWA5xKvmrSHFtutYKfdxnJwgX7Cc=;
	b=W0N8PMYAvW6R/BSc7epC4ewbPH8Ys5+Xpbdr4pWxMhlpP8OjfqTqgzyeVfHabHrp88S1
	 1WiXQRlytR5QzwV8Q+nYkO9CCSwSDIcs/vj77qyQql8AogL1u5REwYUmL/VtlEw4LjC80
	 kdrsJqX6teuhc872mU4DggF86VTgANbl4gVuHe7Pqpj95comoqmeg+NKcuN1k/Y7axh4e
	 FcqpPAKNlAS9fT9bFg4QUTBuogCHr0ZG87jUwYlNOELWUDM4gtiNUF77QE/7WzrErjd12
	 J1S9uohkA7VuYK9oS+LSm1jDyHeEDYoohpM3ZylECzTuR2fsITqZugAEpuL91igkUaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=oYswFuFT;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230E606A322
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E230E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=oYswFuFT
Received: from localhost.localdomain (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMwhb4cfrz1DR34;
	Sun,  8 Nov 2026 15:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794149167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7v88RxTHzZk8rIHyWA5xKvmrSHFtutYKfdxnJwgX7Cc=;
	b=oYswFuFTH3h8ohFtqSPv/lVZxdc8KzjTYfN6Fdfa6/i9Irkr7ej0LbDYdqQgSVhT7P8FIb
	K1QBkIMxvwheKU7fBEPv0KR1wfWjTlWbhOl5kPu8dsiKlAnshrZ/C2U0MVIWiLCBPk4Hni
	Xol8rttq62PHbHol13KbCDdlcnXKMu4psMxcZKh14QOdqOq2GTXIDpCxgnEdMzfQez8H9p
	o+k7FUgHJ9gdeU9mmyNjwQPmA5sF+SRewBK0gajXwQLWdZq6orovPeUcknIfV+u8xSm5n8
	f1h1dvIrqR+ylEI2RVQl72OXBpuUKXxKzF8i0QhWQXParOko+rGnfiepZM/dhg==
From: Hugo Karlsson <huggek@klattorp.se>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	matheus@castello.eng.br,
	Hugo Karlsson <huggek@klattorp.se>
Subject: [PATCH 2/3] power: supply: max17040: derive status from an online supplier
Date: Sun,  8 Nov 2026 15:45:47 +0100
Message-ID: <20261108144548.190622-3-huggek@klattorp.se>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261108144548.190622-1-huggek@klattorp.se>
References: <20261108144548.190622-1-huggek@klattorp.se>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX1704x gauges cannot tell whether the cell is charging, so
POWER_SUPPLY_PROP_STATUS is taken from a supplier. A supplier that only
reports input power, such as a gpio-charger without a charge-status
GPIO, has no STATUS property, and the battery then reports
POWER_SUPPLY_STATUS_UNKNOWN even though the core knows whether it is
being supplied.

This is the case on the Geekworm X1202/X1206 UPS boards for the
Raspberry Pi 5, which pair a MAX1704x gauge with a GPIO that signals input
power.

When no supplier reports a status, fall back to
power_supply_am_i_supplied(): report Discharging when no supplier is
online, Full when one is online and the gauge reads 100 %, and Charging
otherwise. Keep Unknown when the battery has no supplier at all.

Also notify userspace when a supplier changes, so the status follows
the charger being plugged in or removed without waiting for the next
SOC change.

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Hugo Karlsson <huggek@klattorp.se>
---
 drivers/power/supply/max17040_battery.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 4cb26eca56..d93c3daebb 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -228,6 +228,26 @@ static int max17040_get_online(struct max17040_chip *chip)
 	return 1;
 }
 
+/*
+ * Used when no supplier reports a status, e.g. a gpio-charger that only
+ * signals input power: derive the status from whether a supplier is online.
+ */
+static int max17040_get_supplied_status(struct power_supply *psy,
+					struct max17040_chip *chip)
+{
+	int ret;
+
+	ret = power_supply_am_i_supplied(psy);
+	if (ret < 0)
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+	if (!ret)
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+	if (max17040_get_soc(chip) >= 100)
+		return POWER_SUPPLY_STATUS_FULL;
+
+	return POWER_SUPPLY_STATUS_CHARGING;
+}
+
 static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
@@ -423,7 +443,7 @@ static int max17040_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		ret = power_supply_get_property_from_supplier(psy, psp, val);
 		if (ret == -ENODEV)
-			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			val->intval = max17040_get_supplied_status(psy, chip);
 		else if (ret)
 			return ret;
 		break;
@@ -467,6 +487,7 @@ static const struct power_supply_desc max17040_battery_desc = {
 	.get_property		= max17040_get_property,
 	.set_property		= max17040_set_property,
 	.property_is_writeable  = max17040_prop_writeable,
+	.external_power_changed	= power_supply_changed,
 	.properties		= max17040_battery_props,
 	.num_properties		= ARRAY_SIZE(max17040_battery_props),
 };
-- 
2.55.0.windows.5

