Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF73B1EFC
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793321; cv=none; b=OOwZ0QdsUu6QlyYW6mV9qZQDCb/YeV84JaFOSK/lmaL/giMBFO1QdhDkL+a6nvTIYJvInfHVDDDNOdnf1r3Mhhnd+Hx1RSDrh1YgfRRDIi07IY5p419FpdzjhWXAzxqKjSWOdC4GZVkjzCEMcrFLHBjqdzfUcWl85PbtvuEDZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793321; c=relaxed/simple;
	bh=Syd1CsliuYmu+ANgqBVu0Kp8guejtms1xDp6WywGR3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gv4b+nVnsBja7F8U0xxfgTak7qSGu2GA+5NSRltj7GyH1OIXcmOniipUqge+sHymRcAd7Sbin1DbEfkGKoac+m2H8Zldrd16WFS8m24CjkuOpmngu4rjk6rsZtj/Azn88M0neITSWkl5j7nwNYnHiXt+T0N7SJrqgQXwe85HJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=heKGsHU/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="heKGsHU/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so35940095e9.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788793318; x=1789398118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPjbELwZRYUgyLIzGjZcllHabaclbxb6J9sI4fKFQHE=;
        b=heKGsHU/GofJUtxJbwsvdiLcBKii74cvb90HHHPpJfKT9GPwVhwlgkBX3UEBDxiEXd
         vugL4ug3CsEwbTyBvioEf5198TYUus6txz0UHVB4fep2b2padSpEysLy4+ZLrzZn9+oE
         tbYjyUrndhW0VnInI3xqNLfMjsvVArwg2j6mNYamIJxRlEHTG/wa3svc5AYUcaHeQgvG
         2ffxpnXxfkbzNIL0d6PJT68/x0AHDXVer7/B4VXcpGoTvuwyYBmXZmlRFCto0t/cw3n5
         +d8FS/P0eaQSc7sO27rFhu0+KCmDWCeYp5r7dJzPe9eTeq3kwrFFWAi+XLhAAFg3/fEC
         OGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793318; x=1789398118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPjbELwZRYUgyLIzGjZcllHabaclbxb6J9sI4fKFQHE=;
        b=mkXU+tPTVcsBvGPz76+5bbmeZP4R6FO86iVn167ErrxTfQz5vGfiHv+aXm3l2opnb2
         dCcxPm2SePNaBZX7DLRYVWIUfCdugz9tDuUo6M4hWlCvIDIa6WZJbdC5avJMGw4hNt8C
         tdx3Y60A7jfy+trlyAvxy1R4zw39FfnfSHB3El117KHist9fKK+MNS8evwoqjHsMU33+
         DyWFndBAeym7OPrban6dTttjKZmhHBAIAYDtjwzt0e+YO+oFnCUr9qvkkcD3xx6hX6nx
         6fxCtal6Y1kIomybVfycBZB05Cd3pCfG7gPqrxEiZsAo4B2nXzqS9d2gQ799MQRWBL7t
         DK1g==
X-Forwarded-Encrypted: i=1; AKwUvBzvcozDbl/BG45DCvUK9vHLxZCzMSWMfPVwQjVDc+ebooUqPLUyLwkWpWuuaBNrPQ6D/1k53mubxQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n7TDwKQMBMeHmVcsKLeBgwbBckd2iq2szqjyXBPMtGaAgn3vCl
	BsLUjfVtdd7lg71fpU5ItQurINq2jmOYpQWZOOziBvrsjfokWjkQELpxq5J3u0Zv+OQ=
X-Gm-Gg: AYBFou2GcT6MZoficeoWtXd0ge/RfHI6klplAijybkTNMg9ysryhXtWkn3xzWKN48Gk
	koV7m7HxUpOg94nw60SulSxmHpWxaz6tdOk8ytEkmr0hVIs5L8yfpZe3497KDWEyYeeeGTf6Phk
	+TEam3XP6W4RojdUTmEfGexA7EXxfkMbe49YHNWfKR9/01f1EsUK2LkiqJ2oQcvMZbxPcBWwa8p
	5oHgd0OOSXhMCLXIPBLfQ3xK7veHBsn6szSDPNb3Qkrs8q3bxeXJDQZdZnQT9gMiWD0gCvFZc0E
	Eatxhn0nHmOqr8vwN1HHOWw+/aBh0o9dn0I+BPwy8RMfWiuQzdzHtKaosN0DZ0yMYG14VBBKMHS
	cbAQxQ7BuiKj6wErb3y5hWeUyIJUaiXMsIyMAvOktDQV/QlDIqb0BTt11MbCkQZjmLwzJ1ACzFB
	zAUfxstAm6h4HS3P8zgfcJFKFCDDQEuxL7ACPY654F+vEAwoo/dBbt066DfczApJ79LhCdMcrD9
	VjX3Mm8KBF4l4gJIynJYNlqcW1IZBJooDJkAmyp
X-Received: by 2002:a05:600c:860b:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49cf7fe62e9mr480695025e9.1.1788793317919;
        Mon, 07 Sep 2026 08:01:57 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm262992705e9.14.2026.09.07.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:01:57 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 07 Sep 2026 19:01:43 +0400
Subject: [PATCH 3/5] power: supply: bq257xx: Don't ignore errors from
 bq257xx_get_state()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bq257xx-init-v1-3-1a08b29e1a68@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Syd1CsliuYmu+ANgqBVu0Kp8guejtms1xDp6WywGR3Q=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNu3hH9mL2fIv7z426a7cwddof+Pl9oml6+YRI16V90
 7bwMcwz6ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqA94w/FPhE4/6X324IXDx8R43qyc+S82nKcxWm5fz+MIjty2J3toM/12knh0
 z2/d937zTmvGXltsm3GR4y/p+W6Ku4elrq5hWOjEAAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The callback function bq257xx_get_state() can return an error code when
its regmap access fails, but its caller bq257xx_external_power_changed()
was ignoring those.

Return early on errors and propagate the error code to the caller.

Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index b735bb02a8e0..355c59f0bbfb 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -1053,7 +1053,9 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
 	int ret;
 	int imax = pdata->iindpm_max;
 
-	pdata->chip->bq257xx_get_state(pdata);
+	ret = pdata->chip->bq257xx_get_state(pdata);
+	if (ret)
+		return;
 
 	pdata->supplied = power_supply_am_i_supplied(pdata->charger);
 	if (pdata->supplied < 0)

-- 
2.54.0

