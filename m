Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6541B365
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971851; cv=none; b=KPAdqJmsj5sYVfcBWPxNH0R/LzBOKONXpRSuvL/jpQFuNfbC+mHc+ORfRhFQEam+IY9fTchGf2ywWSFZVOLS8jRWlEDtDBnIr6/K2Elc4AgC8n4osPOUisjafi9/8AV8suakMUtXhNSDg3hoYtqLg+oJp4R39cs/pT/JjTJFSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971851; c=relaxed/simple;
	bh=xDe5OwkC59HG0l6E9h1OwEErzx9ysv39/KByzvSAFgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kj3PvIDKVqfqyepEABllDrxA0Kwsc6Os1yD6DvBraKyvHqy8QGdPnkntE8mFZWqgVQKp+u//qImyxVWdjyQ/oEsorUix8NJj005s7/3vD1cpDeqecIxHQOi6D83nGW1DcAOOsauGhRHN5ZH4LhUq7iqLPB99PkpO3woCvjaThCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=gcjGgUu7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="gcjGgUu7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so49702495e9.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971848; x=1775576648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AEOePYJtU4kn4mkWQfK7NUJrP7JZP+VFvVN1gskxyo=;
        b=gcjGgUu74+HcPcTyOi3RpUvw/uvDG5hgfiTvbEBW3FkGnfQC8Z0bvbVWKznNHCWcp/
         mNVMv2jw/NMQnTstZx4XUNbHOhQ8HmX1YsMFKpVPO0zqvX3ol1IB4+R27W9AOiI/sWqD
         BMHSVN2pEDHxPhQKmbl3OHvJkuWIo6wsorK0zohlaOI7WdfMmxFIDExYmLtSksAouujC
         2VmsN2XsMlyvLCqN/0U6m9tSLG6IN+sC/62UKhzJM39k+clUYDgn8RDdZ88GMyDLQZHw
         0NFlNv2pLef3v0BxY14icfsxwNETSgZrSAud41M2TUC2nJ24HC706IHpW8ODhANlvzD1
         wUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971848; x=1775576648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3AEOePYJtU4kn4mkWQfK7NUJrP7JZP+VFvVN1gskxyo=;
        b=erBWhCgEeFQThpfkEYoGoriPyYSTlxHovTYaROp3JTaT5tc2557sXTZ3TvEsrppZd1
         QNr94GgCkShoeSlzQKl/JWOzCRjUmOTTHihtylUVEGkov2ZgHvZQ/aUHlyu2RyyWqdi+
         qOiYBHkGNHn5T/+oou3H+HY6bAnIoMXPPBnb3ipVPLHn4CLpAkPFpnU4Zph6hBXmtXD6
         G/QjVkTtN11lOyr26eGbtVvFExSEL/MDRK9QvGZQptSMFZGu42seIWOdngRgmIOzQMyV
         KjWrADvyTCHc5LwOj6ciM+R98XhGwURz1wDqm2oqK10ReKBdi/JLEyw8M4Xh7mjtLY+S
         ptfA==
X-Forwarded-Encrypted: i=1; AJvYcCWT8LBQwTkZSrfJ9JLJpDhmjFIyk/heTJSGCmwxrdbv1wJQCkHw65SpjIXGITMwB9RkIKo6zxLwSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMzUjQWz55RZ6Dt75YYox9nanl7zwIRi3S9srFJbr7rpFZcWT
	8T6De7od5hV0j3Ux/iTQjQrw+9FpktnEb42EZhmJW8kixyeYmgu1goeg7WIwfcTBz6M=
X-Gm-Gg: ATEYQzzObaomtExcIIYwvUEpVPTiB7pv09CwXJ3gc1FwXVir1q7PI/W9yby2jJ+w6V6
	CxyJrSNJumh6a9Tjf9acjIS2WJwdnaVbLYB3aLCLoR5Uw+CGhK5z8YOKgfxtUdopU8FQ8G85YVM
	50ZyensKMUttAnuuPzYxmJbJhLmq34iE6OQ0TseZrGR9ySJHAHTLl2oNW4mECDUsRkgyEIlGsjX
	a0PqygaSzjcNDP97BOwiq62BfYujwaWfb601O7WOGQQonByyyrOJu1lFESS6ErqnO+eyv1rzE4g
	MJ8y4/2slDmqX8azeTP4+iIGvANsNRy0+0LIalzBwW/DEqXWFSfviIQ25ofSxoBFaVOUsw4TcVH
	vM+WU8IhFqorWVu4QfZ6lrArSEsdOsM5Tu40tsF0Xhvcqn/uBIrlR0jtWToXtKf2SxYiFk0wt4q
	slQddUB/Yakj6ECtFAUtgTg/a8OBfhMshi2rSDd24ZmlxDk3C0+mQ0H3glCdeATGvwPQ/wn1FSi
	OtwHg==
X-Received: by 2002:a05:600c:45d4:b0:488:79a3:f04c with SMTP id 5b1f17b1804b1-48879a3f26cmr61666005e9.27.1774971848032;
        Tue, 31 Mar 2026 08:44:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:44:07 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:45 +0400
Subject: [PATCH v6 08/11] power: supply: bq257xx: Add fields for 'charging'
 and 'overvoltage' states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-8-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=alchark@flipper.net;
 h=from:subject:message-id; bh=xDe5OwkC59HG0l6E9h1OwEErzx9ysv39/KByzvSAFgU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr3e/5L0mRfBFafkf65duuv2+rO7r1a57Cqo+xMje
 P/DIVZZn46JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQx1jHiIGLUwCmuuMfI8N5s3DZXKHF7Cc2LG3L2ik4P68hWvH/fc0otrNLlr6MSgxj+GfYW6f
 R2HZfVbKFQ4dV17zy5bMc26ULMs5tYok/MX2WDCsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The driver currently reports the 'charging' and 'overvoltage' states based
on a logical expression in the get_charger_property() wrapper function.
This doesn't scale well to other chip variants, which may have a different
number and type of hardware reported conditions which fall into these
broad power supply states.

Move the logic for determining 'charging' and 'overvoltage' states into
chip-specific accessors, which can be overridden by each variant as
needed.

This helps keep the get_charger_property() wrapper function chip-agnostic
while allowing for new chip variants to be added bringing their own logic.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 0765673728e4..9c082865e745 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -54,8 +54,10 @@ struct bq257xx_chip_info {
  * @bq: parent MFD device
  * @charger: power supply device
  * @online: charger input is present
+ * @charging: charger is actively charging the battery
  * @fast_charge: charger is in fast charge mode
  * @pre_charge: charger is in pre-charge mode
+ * @overvoltage: overvoltage fault detected
  * @ov_fault: charger reports over voltage fault
  * @batoc_fault: charger reports battery over current fault
  * @oc_fault: charger reports over current fault
@@ -71,8 +73,10 @@ struct bq257xx_chg {
 	struct bq257xx_device *bq;
 	struct power_supply *charger;
 	bool online;
+	bool charging;
 	bool fast_charge;
 	bool pre_charge;
+	bool overvoltage;
 	bool ov_fault;
 	bool batoc_fault;
 	bool oc_fault;
@@ -106,8 +110,10 @@ static int bq25703_get_state(struct bq257xx_chg *pdata)
 	pdata->online = reg & BQ25703_STS_AC_STAT;
 	pdata->fast_charge = reg & BQ25703_STS_IN_FCHRG;
 	pdata->pre_charge = reg & BQ25703_STS_IN_PCHRG;
+	pdata->charging = pdata->fast_charge || pdata->pre_charge;
 	pdata->ov_fault = reg & BQ25703_STS_FAULT_ACOV;
 	pdata->batoc_fault = reg & BQ25703_STS_FAULT_BATOC;
+	pdata->overvoltage = pdata->ov_fault || pdata->batoc_fault;
 	pdata->oc_fault = reg & BQ25703_STS_FAULT_ACOC;
 
 	return 0;
@@ -478,14 +484,14 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		if (!pdata->online)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else if (pdata->fast_charge || pdata->pre_charge)
+		else if (pdata->charging)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (pdata->ov_fault || pdata->batoc_fault)
+		if (pdata->overvoltage)
 			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		else if (pdata->oc_fault)
 			val->intval = POWER_SUPPLY_HEALTH_OVERCURRENT;

-- 
2.52.0

