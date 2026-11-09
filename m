Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236322;
	b=A+NT0tOVAoCVaw2Y0cw7eONgo8/OAkv3NJH+xYR8um8peuPilBbJXfGybWJnio/FuZlA
	 vJjSaSSF9srcL2Xh8oE1ap/0cnyLBCbrAY/AaajA5AGV4G/PEiy98BLNDZuFtPThF/0sy
	 beDyMvP8XnXIOkOKeSXBvQ0KlzQfl75jxnsN571YMA1cz+/I15JN7Q54Sj8HUEAjBNAHc
	 Nq2wyGZG8+X4Mlu2I9Ci/iNK+6YF/hBJLkf7mr6bjD4IePVrgvouBl5T855APCNKqr/+G
	 W88GoR8/iuD7srYWBuJ7PJL+oFmTLwPMleV1FK+pDJI94cfG+eH/s66nxvoomaSctgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qGWgS1kK7bTN+UKMspP8Lj57f8piI162PVpn3s78g9w=;
	b=mFLsIhD4VsvJsdTnc0nOTGyynoM4ZpFQlVhY1N211quY/UgwBXL743TJoHHOrbkvul2Z
	 dqUpaxDtdW31oJmGjStrxIVRelthVdJutCZL4IOioeyMZq3oQgtNKzrlcNsbrBApebSSI
	 ODjNMO2Y5CqnlBaJE0KGiQKBYlvSJ7/lSjpZpZbTMB4F6O40YDWWFXADvdA6M6v4Q3VcX
	 XzFtpUUqxMe1I4prnUxAX1F6oAfc3JBjltzQH7h3pWpd+DjafBrRe9FZPxgkON5+JlAgJ
	 4c7VhqqFYpGZVxa1GxG/ZbSiYB4H4ruHdEWJ5S3be+PVdfjX1FPnM3CM/BCgFmcDx2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hDvcH3nI;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B21606A322
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00B21606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hDvcH3nI
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-55e02e89f78so242672b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236321; x=1794841121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGWgS1kK7bTN+UKMspP8Lj57f8piI162PVpn3s78g9w=;
        b=hDvcH3nIIjCWo9HjMsANVey5i425zlj+OUxGKudcwVlpTCs3+6nBG6xrHNnih78HIN
         boIEmLJVQzdNVuB4HVhassKK/BNnQdocEgj3qicEXPc265PvoiTyut4qoPpiKuw5qE3k
         eEmX0BjnSOW9lZVMcdDhnQNocR6SG86UAgo8/Mro40N5u4XxH+IlhxQG8R8IUO55UXTN
         10J9WOVIhygmKcZpRmUqa/a3EoM03Pnn39hQGg9x+Epr1A+8d11Gl3v4LVm/kcjTVlzt
         Za0L7kqVTj1qwG0tp9idUJ9lv1+r02AUM762Kxc0tb8BP+AN+yDD8CvbPWuQHB7RSuJi
         RGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236321; x=1794841121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGWgS1kK7bTN+UKMspP8Lj57f8piI162PVpn3s78g9w=;
        b=ESivQq1TTStC/we+SIXUgvV5jKnmzQ/YqCb7E70By4tZ2xfE7EXhJkykhDHFJMNU80
         O6UdLH3CEE6enzOXDxW7Ry6M0//VrU24/E06cyWRL0/RoyjTX+RciQn93IRy1JdTqb1z
         3Rgmjnt1gBUIkexSHrBmdlZUPnL3iOJJKuSO44KW6wvAxJcGlOj358viYB7hdnlteXDy
         Yf+zqm4AH/vR0np8CtjTVySnbLNgTsdsyLgBtMS/xcpGLUe25JeymMPHCNqNTHHV92MP
         ryHUsJPVJ279ZuI2eAOBTQl587Xd83266mWmwDmyYAkX03YvREe6JlWeRGt2qfTCHVNN
         ZBwg==
X-Forwarded-Encrypted: i=1; AL+hErHhv6V4aQ3Urib41DwIQbUbhAhAEFnqOwsTaUnVpnZefiuSBoRIvEeubFdnreo9ZjDSluXco38jhA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kzNnFGuv5J/35l0EYk0HtJrQ5rJ76bG+wnOn4FoaoWzrqBEsn
	opUq4UxZytgjc9cqxFy0nQ+qQHZeK/0LCdyZbx+GjXKsPC81EPtjGNSY
X-Gm-Gg: AYBFou3ms8tHt3xZvqcMxRUB3VLYQcdCuk6vKNFAK2JI0k58BUXABt6SsAsazAJDZU8
	433Hogs0EnnOfOKh+4kq+KFkyYHDbis8L778oG2Iarab5TBaEIbxo5YDC1ju47t8hZMcv1uP72E
	+omHtm0MWM+j0VnYmhOWZpqcR2MuxCPutDhlBMEkMSXtm4wkYD6+1rbXMg2FbXr1jY/llLwTNWU
	0+QFLXukr1aZvBTEZfxqrXUE4q0iObP1Db+Vz7n9nclMA4XRcLAf482D13i8s2IwHEQ/A8NfW8S
	bCrxZOPs0nHs+jXPr4K2TtPN1OKw6K5qwSpbgtagF7awKZv0gsw4Jrsewk59JeluCQzwesaue1o
	QQvnGmhGHBqleem93yzYwxLQ0fhPxTqzMZ2cFGoaCS/dvDS00RlIbAyr1J8C1heaAUyBg5MNhcE
	EwvBnWdCJ9pIUts9n1aSz6w9+38/LfuqWLcZs/YOQwQvJFNdDW1ek3DKFJecGdQ+h51vyVYQbjU
	gt2Yhn6PC9ttOzdHPltySdZZO4NqqAvAJZXHoTnz0DrihOH90mNIksxEAZZ0ZsqCKnUY8zfe0fv
	aDQfOLgjkiCAKxQMMsALEPTPkVJmjQ==
X-Received: by 2002:a05:6808:2211:b0:551:eea6:9397 with SMTP id 5614622812f47-5681463f7b5mr2639979b6e.59.1794236321012;
        Mon, 09 Nov 2026 06:58:41 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm4667618b6e.16.2026.11.09.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:58:40 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jacob Cook <jacobmcook1984@gmail.com>
Subject: [PATCH V3 2/7] power: supply: rk817-charger: Fix NVRAM SoC value
Date: Mon,  9 Nov 2026 08:58:28 -0600
Message-ID: <20261109145833.1363319-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109145833.1363319-1-macroalpha82@gmail.com>
References: <20261109145833.1363319-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

The NVRAM value is stored as a value between 0 (0%) and 100000 (100%),
but the bounds checking checks and truncates with a max of 10000,
causing a value of 100% to get read as 10%.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Suggested-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 674622398efa..39c945622c4d 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -728,7 +728,7 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 
 	/*
 	 * Read the nvram for state of charge. Sanity check for values greater
-	 * than 100 (10000) or less than 0, because other things (BSP kernels,
+	 * than 100 (100000) or less than 0, because other things (BSP kernels,
 	 * U-Boot, or even i2cset) can write to this register. If the value is
 	 * off it should get corrected automatically when the voltage drops to
 	 * the min (soc is 0) or when the battery is full (soc is 100).
@@ -738,8 +738,8 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 	if (ret < 0)
 		return ret;
 	charger->soc = get_unaligned_le24(bulk_reg);
-	if (charger->soc > 10000)
-		charger->soc = 10000;
+	if (charger->soc > 100000)
+		charger->soc = 100000;
 	if (charger->soc < 0)
 		charger->soc = 0;
 
-- 
2.53.0

