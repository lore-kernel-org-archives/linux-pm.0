Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35B4FDE55
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793323; cv=none; b=S1+7R2KLqOZ5aQL9xEyAqfOOcNUbQMj3ifyuax8ULINqZt/A0uCBnS2MBvUy8/i1UCHQaZyLBPVar4XQpi/B5/6dBdIrsesjYxO/5+smVJ1nKXN/VtgMu/dyPH6GJy3oAwfJT0nFr6R3RoAEFg4OKoHik3Afda7DGi7MODiaQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793323; c=relaxed/simple;
	bh=/Lj1bzOltbe0TShD0ZkZdsIYxLxj5M1uJ4RcZYV70+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFv2KIHIOt8DzZDgba45iYu0nr8dFv4XtNsr6qEHWaESZFFkV4DStEmvs2OjDnqfhVUG3bM5lgP925QWMcTgvJD1+D4hqbE2uHRK7A3L16DVi76H8Ck6RNI84oVQCQ6cDjPotsaIizI4Oy33h44QXvx4BjK9AI4GjVusEIsME8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=aXZHTEed; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="aXZHTEed"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso15213535e9.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788793320; x=1789398120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELIdnmZ186QZy3GeHErz5sisEfjYu32lHLlVPnyugFw=;
        b=aXZHTEed04Re1d8cB2ZCRcY75cIJ6nlxnqHHtxOoP7em1W6t8+cVAkx4ejrEn9KXee
         jk2tkHOzbjyo1pjAeQv6gzlpBRst41UEsFonCcooRZ4YRy7mpazaTvv4HGfwCTY/fDh/
         dNvW02SaYxQmlH9P5pE1Sepk3p19YlSYdiIRBhS/tbXPnXfXZFH9kMC8TAzqJ00pSB4Y
         gGcytUzWkNNrYl5aQseY59hGmwhNWpJGUC5j773LqCiF4568Y7P8NKAv6WauvWxkJyu/
         nwaGxPtr4G+PPoCX/C874FuoKqLw2cSii30uh+l261tD/wy3zeRna/jM23SF89UenG2K
         k2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793320; x=1789398120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ELIdnmZ186QZy3GeHErz5sisEfjYu32lHLlVPnyugFw=;
        b=mvpDtNQ5fef0amkCBAQYO3gaISHoUYOAxk08fvs8rwCAxr7p6e7r2IBy+TdQxRGtnn
         VS1DCoVbOpdM8Yd9XsjHZfDNZd2WyTSBW+HYktFbHB5lQ0B7NsgtyEt/9I8mDndt1Cou
         XFSK67OGtzqWg14HvBctNR2HH46PDnp9dRYf6MVkNHSUzY42+VDmgwzS7CJzS1y3v8l5
         WcW046MoX0SWOHHCQvR6B31zNdDfAz2YRBQHY1n7SP9yfgnanQcfqo4XB7d72atVqcht
         NmCMKB2JcVksXmuuSU3yqd6ZpRtHkzGnKHSiDn24mPppdEYTz9Wjl9PnSwyKrufnC909
         Pfkw==
X-Forwarded-Encrypted: i=1; AKwUvBznsl18/Hyh2UhhllmACzXulawBjrhtXJLuKiDoYs8/H6I7OUwDTiqwTWhNcuTTg1qoEANJ0lQqZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++loo9A0RllCGSWIMYyBlR+QDx+p6+YFzcNT4t25Q1SDHNbQV/J1
	KWXRPggflUf9c6Zrb80R/9yxZ0tXey2v9kX/FKFy3hCdLsUtVsz16aM2t9xnY026Bw6/S7JGhq1
	obnl0
X-Gm-Gg: AYBFou2oxFVaNW7+EQPd9tNxR5SH4GGYFMH7AoilOhz2POAXWJYiY5/lV3kEsSiehfC
	96D67zTmiSuUd/cZAkMilwp+1Gg0f2OiPS43j2tNYJHfvq4K9Tzkv/mYgfXWYR3Ct53/3BzjorD
	twnEvV/yH0NgtofbeoQVRVDuhhSa7QEYDWynVwCRgdprYUDWfEyLO3TRRkiTyjDyhlcEhO/nMKK
	+EYYtqwIUxk3eS+EoxyapjS+l+fz1crxz/hhyQFkpOj9B6degopZd/N2waIRxhI7AKond4xOXit
	kHhF3IqCc+7qPu/61r0FVULxpj9XJFKu5YIWrjd7Tz6gR66QQPnffEqiZxictLRMh93YAvk4bQG
	rqN4ze6WVUcvZXKXnDwS255+uZNG5qxB/feZp/f5JpLJfZmXJpx+ap0aorviu2T26rwqWnburpY
	8bG0Iuyx6P9bTeESgOlY37edSf/RYaDLfVIW0pmUb7bAktn8V5PAOtvNFAXsu2JD0WSzoImGiPk
	3GvzXtaKkKmfUBW0ZSUzwShyqm9kXnP/TjYdsDY
X-Received: by 2002:a05:600c:34c9:b0:49c:f729:d757 with SMTP id 5b1f17b1804b1-49cf824f757mr233492835e9.11.1788793320085;
        Mon, 07 Sep 2026 08:02:00 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm262992705e9.14.2026.09.07.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:01:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 07 Sep 2026 19:01:44 +0400
Subject: [PATCH 4/5] power: supply: bq257xx: Use psy directly instead of
 driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bq257xx-init-v1-4-1a08b29e1a68@flipper.net>
References: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
In-Reply-To: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=alchark@flipper.net;
 h=from:subject:message-id; bh=/Lj1bzOltbe0TShD0ZkZdsIYxLxj5M1uJ4RcZYV70+g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNu3jn2Nc7fM5/J89eXTJh/uQb3y6U1bstmyLNc6lAv
 CvPokRuasdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTXfaD4X/Otd6I3cs03FpXnbFWctA30jhQUXXT8bPfLdNHbLnJPjMY/kfXpvV
 pTfGojKh8YyLU0MB7O/nlPAW7rQaHbtr6Mq/yZQYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Improve consistency in the bq257xx_external_power_changed() function by
using the psy pointer directly instead of dereferencing the driver data.
This makes all power_supply_*() calls follow the same pattern instead of
power_supply_am_i_supplied() standing out for no reason.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 355c59f0bbfb..8a645859460b 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -1057,7 +1057,7 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
 	if (ret)
 		return;
 
-	pdata->supplied = power_supply_am_i_supplied(pdata->charger);
+	pdata->supplied = power_supply_am_i_supplied(psy);
 	if (pdata->supplied < 0)
 		return;
 

-- 
2.54.0

