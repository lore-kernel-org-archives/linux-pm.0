Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44F4A1DF9
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050796; cv=none; b=LVclppbytGD7Bqt4NuV3LGADMhwRx8h7HcXeS1iqnYYCd6fczRjkUJa8R0KEmxTd4RHkM7R8bMbrS49Zutb7Vm90kuVO36c8jx+TmIsfnljxvW8YhjIEYVpmutFdrz5o5ua/yqj4xJmkqr9KxZPpl99N5CAXg6AH5F6tI0KeZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050796; c=relaxed/simple;
	bh=puqbhfoUN1h0hVmNuH0sDEYWMQDzUtBnG/jCV80xhEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAui3J0LrKksGu6mAHgciOFxSvuwHdu1mdDJXxu18h2qDdKLf9ApTuAgniUQDM03AOFtcH1ejKha3RoaO8tuWzdgRE2bVEmpfbevuGr1c0E15hXYPGwTKEAGrMTAAI/VVyFGo6uXgZpckvO7yXpcxE+wM98q+TDpmQiaTYQnDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Wm/8Jmrh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Wm/8Jmrh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so13102805e9.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789050793; x=1789655593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZ2NMqgSdO9GLsjUUfKBwt+Y9+3g0pO5mWSs9o4+92M=;
        b=Wm/8JmrhdvJk3BWYTKYMEB5YwRuh6fn5Rsl0VISU3ufLj+UcqAAXMQctR7qSQrjM5n
         K2utvo5XrD7DqzJbjJslJkmQmFB9kcz0ceiKgGz1Bxoj0DP/8oi7HvS5pePS2Ep7yafP
         cbP588TV/dnz723v7TAa8o7yCRIVpje1V0hx4KOhGiq3dQw8gcyRweD6Yb+JJHPEIkoO
         +R+4T5ZRwjd0m/hVvDG4pSnVT2VCLbto1tp5io1Kw40RKYRFRYTsnooRI1UwOl1Vh9jn
         tmU94FORTUFD3CedyDWSVk8Y18mJPsSAd2i32kNFmyj2LP8qHMX9fkJVtEKDE0yyuoM0
         nfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050793; x=1789655593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZ2NMqgSdO9GLsjUUfKBwt+Y9+3g0pO5mWSs9o4+92M=;
        b=TcRLGdKsuhcupAx5m7oSnQadhQ9iB7iXTs3CGVqOkoyH0laTaIdeUzWo0n2Or1dgFz
         +3fI+qV68KIw+izjcamYH5ZaoyEsfP4Dod8ekVgNvp1/KnBKl6Toyzky79CoF3mOgkHx
         yJjP0N3o2uBTHAlvqB3UI8888Ja8LJ8WlITuOyyuhDb8UZdAx+7IIKVPkijS9t0Bp83F
         QT/8kk7vqxEJjfiQUXLqiGHVR/d3VygQkAHi6blHbz7q0UgGjIgWdB9/bgrONILPciOh
         dpBkkkjd9TbM54L3lg0h7jHqa5l2UZZjEEYmJYSEeCbc2Jku+rL9MaJ3nxRXKWVlgO7C
         +lyg==
X-Forwarded-Encrypted: i=1; AKwUvBymC9lPOyttpG93tMzRUMybND1F0R+4E1GcD994W2J+FJoYHOAPSdVgODucKkzkY4WeBVaMNiSDqQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kgaIdsNmEGyuaynWVpCJpJeMNi0MlPi6ffxbyRxtdGhTC+id72
	v+FuBvkceOaAUWusuD1Q+PPMULwvYJQDjUvCF3bQK14tHhj5/0z3nComPcB9LohbWzrErxecrdP
	tstwoDUM=
X-Gm-Gg: AYBFou3NT1Ze4gM9KocEc+cSf1g+CrKlQnAVWSG9nO+qo+ZwqvWiw7CiLVQ06QLXZKf
	i/4rRbn65y393A73phnCy7mHlQ0boHYwfBzdgcDQJK9IzaCSTckkG1pqQ0aUHG9sS3J45AD7hq0
	rslGlddV/+UxxeVXapr7ogFqQP5JcruB1yQ37m13X6sxQi1fjpPK7iXhUueoO0907V4BoAV8RIc
	3pMMEnulPLxxo5b46NKNGcv4KMNrVArb9PTgB1c+LZu1ZlgX9w0nWHoKvhybEcK26tz6JM8R8v7
	sLaoZ5fhDCA85r43nlKuoNIoPtC6E6sr+NDvvWc332y5PwroSaGjn2dYxx82kIlL0wkoI2oPU8X
	7+aGXDrcuJfO8YRS9+dN+8Y/ZFvaNEWiGMJv8I+4i2MLC4zfPX7V/higdl1TmqO4qsJPheyfMBL
	BQ8mS5M+BresmTmpuzFTiszzm1fEzj5bhlBtPs9iLz3vghzKoxwfgjKEsLO4l3TudOzCkCEg+C2
	meDWTfoKVH640cpSKa/AkTkUOiDhXL8YCrns2eH5cUQDiiSwEAQ1Q==
X-Received: by 2002:a05:600c:4f8e:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d1f22755amr233708505e9.5.1789050792624;
        Thu, 10 Sep 2026 07:33:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5fbda49asm12537135e9.3.2026.09.10.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:33:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 10 Sep 2026 18:32:59 +0400
Subject: [PATCH v3 2/3] power: supply: bq257xx: Use psy directly instead of
 driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bq257xx-init-v3-2-4e219a1a04a5@flipper.net>
References: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
In-Reply-To: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=alchark@flipper.net;
 h=from:subject:message-id; bh=puqbhfoUN1h0hVmNuH0sDEYWMQDzUtBnG/jCV80xhEI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQt2j8nJC4k4PQ5w/aiTh7JPDVJvzm5AQGlflNqCm7kz
 GzK1t3YMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFR/msDwT1fLynGRz26NPIaqLd68X4/ubWR90ZWzifkju/khh0sLKxn+h2YxSp4
 skMrXF84KOGIt2KSUIBTdJ+v5dMPsz/379gmyAgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

bq257xx_external_power_changed() is handed the power supply it is called
for, but passes pdata->charger to power_supply_am_i_supplied(). Those are
not equivalent during probe or teardown, and a supplier's changed_work can
reach power_supply_external_power_changed() when pdata->charger doesn't
point anywhere meaningful (e.g. freed memory during teardown).

Use the psy argument, which is valid whenever the callback runs.

Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index b735bb02a8e0..ab3519454193 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -1055,7 +1055,7 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
 
 	pdata->chip->bq257xx_get_state(pdata);
 
-	pdata->supplied = power_supply_am_i_supplied(pdata->charger);
+	pdata->supplied = power_supply_am_i_supplied(psy);
 	if (pdata->supplied < 0)
 		return;
 

-- 
2.55.0

