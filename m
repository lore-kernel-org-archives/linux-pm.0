Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F13B5318
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049924; cv=none; b=aXMy+rXmwlRtenthcrEXiPoZw0xYNoBFOglrtJojEFmA8xQ95vX84BDdgiY0g1mRebhccjfVLSPQAIZPT/WBZ7iK/gb2fbUv2XJUuENzTAZLefN4fmFXBNxz3kDI8aem0Doq10AToGYm4VbH/V9ZYIPC9flU956MfQpvoBSYwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049924; c=relaxed/simple;
	bh=323qMUJIQ21IoGnpMHx27wupmT9kn4NzAo/kbXFUOlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWsMqeSOqI5SIZ3UkjIbS729IHh1Lzp+7oFlDA307f9u1y6+QmQKXcTnzRT4wQIAb1FLmFogQHjf8Mz5kQtj3iMz6uE7iy43pyo9C/1KzHjwxGyn5itIImdEbS7e0zcgqdLpjH9K3yKVjyIvF7yBwHwK8LdPGdHYNLergwqI8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=iFIZLZ2u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="iFIZLZ2u"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so6232986f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780049921; x=1780654721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9NXRsV9sPrBZFsCsyMuwjoRwkmQe5Wv67hF0qF5DRA=;
        b=iFIZLZ2u6z32+8LCXV/3tyUsx8o/Lzpk7itbcakAPbaB+kdYTnk4z5MbMqJj4ksoNU
         XLiVxeR8oIaeuxk0R/kuum/DmyOd5UgjRiUw05r5kmeXI8IbvpwNgzziITnBgm+VT5wy
         N3Zjqup+gz3FQkA0/+W8znHMUnGCMYSz52KSKHA/7ImCr5N3ENK7yVW9U1vDaG/dsQhO
         KGqh+zmdI2jspCbpqehcx9TqQy68b8/xxw7fkPXP5HaFwFCg5Vnqlpx5eNU7Td/NjtUF
         eTIiEUpFENENjM0b0IncloSZZXQBXmxtLEm16PYDGsL/NXKR4xgIEpqJMnaGq7Xwd9vM
         OYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049921; x=1780654721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9NXRsV9sPrBZFsCsyMuwjoRwkmQe5Wv67hF0qF5DRA=;
        b=BcpOUcTrP2LHE5r6+9cSDKGHTm33G7pEgPDdfu4ZPnwcFtm/zmRKHPT3YSItZDNVrD
         3kQK3851AW0UqIwNRblm6krnKCifORwiClfOkdHtnoZoFl0OhyL5wJ/3Sfmk2oUjbxwQ
         kCJquHmMzwj3iNsoZ6NEg8wdaqnFiHUp4VSmeNdTtMQD+gLhrli/fC6ARUHHykYVZqLZ
         ToC2w5DlPSEhMEr4wL4DLCVZDAgeR+00B8sgYQdzar3k5vppSRUKpKwjvHBO+2Nk4W9W
         4vyvHLdMUqlz+w+iDa+R4UbcUzc7YU0O3T2095Nm6PkgXv69vaTuWvPHRoJBILWl73dC
         TJTA==
X-Forwarded-Encrypted: i=1; AFNElJ8U5uO5uZytZ/urQqz5bJkCRkYGgLKBbzfAV+SK1E2OmrYHK9tcNp060gZ21pcyWdLuLWn+dk90ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5K10/1feyGWERefNdclNuzMYuMiXOcP4Ma/zZmu26vFUQlft
	7T3HRq3CTFXgv1hmS6WgFKKCOlm9g8EtWIUY+4XHOyac08QzXiIsYmGlZ0Poowtdmhg=
X-Gm-Gg: Acq92OG3RmA3ZsvNBRj8Xjxztv7wKiN8drH9lr7CJsKaPRLRZTIYwg6o3NLH4cZXkUB
	CrYzRtUnspAlWqYZaZd8io+X1vUyyZNgu3e/MQMT4BYCDE7sWSmuoNBLLmGrZSrtJxI1eMHIGH7
	iy2YkXjVoaIq6a9GPFFtt8q1eOeQK/aL7TCg3Gr4MH+fjsY2LxMoc/40CJumGtodeNHa2xRW/x/
	Tsz310p4j3Byws4i2iMZCgjz0kXxvujWjPMHsFayjnQ0zLzrwAfBfb2fjSMAD/2F8e5OhVklly0
	F/raIPt7SOyGS8KS990w9noz1ST6i8B/kv74gMh/nw2EslYa4RydbDeabK6DxiXiLc0pqebufPv
	A78sj4vE6ER+sE4Ca8TKC4jlOQGKAv0a5xJGnGx1smQMIlYIhOpX+58xvZm2otP5TvfmHRBQY+A
	s1UzlcuMSnQFip7yHyxfXF9A/56tj1uuNrWJD1+4Nvqmm28ISy+Dcjeo9QTgwP4p1UeHrFiNGck
	jPoCMqGmvleCV6SMIo6ygw6Nw==
X-Received: by 2002:a05:6000:2284:b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-45ef1466de5mr4374672f8f.27.1780049921499;
        Fri, 29 May 2026 03:18:41 -0700 (PDT)
Received: from localhost (p200300f65f47db043f932d8b97293bf6.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3f93:2d8b:9729:3bf6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45ef3587072sm2449900f8f.34.2026.05.29.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:18:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] power: supply: max14577: Drop driver data in of and platform device id arrays
Date: Fri, 29 May 2026 12:18:17 +0200
Message-ID:  <62e1b01a6591dd59406a78f2bbca619d734a9150.1780048925.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=323qMUJIQ21IoGnpMHx27wupmT9kn4NzAo/kbXFUOlQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGWft9x7hHlAehyilh7uD/rAAXEaa8EKkWqXn4 QW1RqN9zVeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahln7QAKCRCPgPtYfRL+ Tg99B/0S+8W779/ooWUNVzN4LjJgKvHeSQmrxU6k5bLegwovFExNertpxO8+4lIYDVXzkyApErq Qnn+gaQzoZedi5WAhVyx+rSliTSU5jxSQ3Z4/g69Shvv72Z/bQbcAxP+PRqwPrRJpZ/Q0vd7UdB 62MsCIYnmSKqkvlWFHYUfl1FOWj490u6yzk5ZS+R624nA51uwMd09VW4tQtTQwHQ3YCmfJnDamN QPXk0CmbmkSNhZRTJSmkscyR7ztwt+FXXvnFLoPEFClrtEtpHyIsNm7xJN4VfAglBKc6dnCaA2X 1qD0eI0fHA3DYIE6+xGVl1CTkuMl0x5feOSXNNPFaopwrs6H
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These values are not used, the relevant distinction happens in the mfd
parent driver. So they can be dropped.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/power/supply/max14577_charger.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 63077d38ea30..a15d94942184 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -613,18 +613,16 @@ static void max14577_charger_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max14577_charger_id[] = {
-	{ "max14577-charger", MAXIM_DEVICE_TYPE_MAX14577, },
-	{ "max77836-charger", MAXIM_DEVICE_TYPE_MAX77836, },
+	{ .name = "max14577-charger" },
+	{ .name = "max77836-charger" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, max14577_charger_id);
 
 static const struct of_device_id of_max14577_charger_dt_match[] = {
-	{ .compatible = "maxim,max14577-charger",
-	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
-	{ .compatible = "maxim,max77836-charger",
-	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
-	{ },
+	{ .compatible = "maxim,max14577-charger" },
+	{ .compatible = "maxim,max77836-charger" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_max14577_charger_dt_match);
 
-- 
2.47.3

