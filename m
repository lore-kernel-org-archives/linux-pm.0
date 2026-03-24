Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2F3EFD2D
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352319; cv=none; b=UlnCeJGo6d9cm+XScbN6Jl10CZ3MoqXopknfI+PM2BqK0VX8wFRN7l3xcQ82SgAJHBbS1PZ2iWO78dN3jkkyfnb+rLab2XR+WjgxLbrmia26Lr8Rn1v/1iz0IomEQvtcS3UhBIJRPaPrkMoo4kaid3ZEMesBoyOV09rXzdUSTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352319; c=relaxed/simple;
	bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QT/qWNzV8JxziEml0TRDRld2tuJsP8Mw4uyOxIgzdfaIUwdnHGVvQbH+EQgwlI9gZWPYw8FScRuWcYM+9E12SlL/vfKD6/7wz0CGMriXxJmeaJydIiVxiVi+GED35UyVjP9Isx0bEooqX+bLH5Wy2dHPBqCR3eCh0n4cpLIJSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=jMczJ74f; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="jMczJ74f"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b4fd681c2so1008196f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352316; x=1774957116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=jMczJ74f+p4Oa2Xl9eCmCm+k+OyS0x73hIZG1wfmP9dexw91n6Q4UQojcvn8q8x9BS
         yPndZW+lCvh19+8phFYkA43uYe4xhTnU5VzIXE6ieZEGMnkxQclMsIgita0rofjLE53x
         OQoCseDmpaRVXomJTqTTNjS4X9Eq3O99YX37lyTC4MjkLb4QEr4MvW/t9jTacIGiSXTL
         iOhwqZvAGxBkxIxo7hPSArFTvfu+m1MFAkDlo48ehA2M2rDbMU7Kdk6VSBxlbCmlaeuO
         QSUQPHwZTFU0/UzY6G7gVKeg0M9BKMTY4jcOHkYC9T+iFh2ugqaqAknRh7QIzspmVIcU
         3Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352316; x=1774957116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=ntRLdu4bSQKlRKBIRwWVVi3wNmwyBcn9O5CeLoYRgVzkeT8WdseM/3kxHRLkkuFblV
         E/ZdJsef7cZOVl88FaYTl8emo5VuEGbHF6s3uNtl7AcUH4TqUVd6FQa8vjIjumrj5obt
         bsolfW96saE/ejGSVfiqs67GBK1+g5dX/Apco2D4Voj0jpDXqCG66qibQyt1Fl4hIgGO
         xUDt0onNyj0t0rbK1ucvL6mNQRvROV53seY39Tvk355OjbCobs7Yjd1HpL2HsX0YIE8S
         6PnO+P4b9Ejy7dX4i4j78YfBJhbnwQSdsCVedNpV9ARkDA6ocu7EUCmH+8bngU35w0u2
         M5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWn/ktqq+YEcsVjcUjT1DUM9tfkf0CUmeO1EEpB8KCEMU2dL274Rlrr9eLDptWMfHQL6NHpxiaBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlspMg3oMV3zgQmTbnQiZzgyw0W2eXjFmRbTM9e/9HVCaKcJCS
	CwzWb6tgIgETmQwWRq0vn2ut1eSLrongLD9ft/HMMnsTn8pApfS3RbXCOvNZMuN2gqE=
X-Gm-Gg: ATEYQzwJk2k84pgy8/eqTUA7x3+EFQJgrhZw2zoZv2NxzYGLV32MGtMgR/KozpevDYS
	BIVy0WPu3ASNdNylpcXe5s2i7BXJ1Sc486InjVPoGB+9kb0wez8w3idT50dUVpNfp9oYBy/jjLB
	wtEsf/2NnuBK+NKRssufGHL4iwuOA1hbZfCn5S5gSMxenvinuLHFX6aO6wfYNVt0TycSKkcUt6V
	nErHrSEHXAkpXv4hVdhaSSKYbXFsPvGHUzy+mEwa9sEsEyZhFyDQTVoOp0FrcjVFLkaqP1ush7o
	ryarW+tl71Bxcf3wPzYnBCLrzctEZ44IUbf+bhHsmWw+0CM6vdxWGBw/YZnSFlfNKqaeXNjZkv6
	czTuqU1EtLjT+vgvA/dDTCPhrkQZVSvCYK8EpUb2ya/EPQyl/UKH6sKxGyqowrdV09TneULEbrX
	HhYo5hNZe/O36mxKjGdEEES2hM8nFTKDXRd0NR5B90VEvpeYe+INz9ITby6XlCY2SrSoA82ToiO
	HyVlTkX5teLG03W
X-Received: by 2002:a05:600c:8707:b0:487:338:b4df with SMTP id 5b1f17b1804b1-4870338b5d9mr166015045e9.15.1774352316223;
        Tue, 24 Mar 2026 04:38:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:35 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:10 +0400
Subject: [PATCH v5 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-5-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl/7QnLhoeT0m79ifgX1brk/cd7ONeq7DRZmddc2t
 Px9d4nvYMdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ioY6xjxMDFKQBTfbWA4Q/PDdWI70vfPcuWmeP/5HqS3YPrLy5+XT3BXWdv5LpwxY2rGRmu+7m
 tLdlxpXbxwp4ZaX9eHGh8vlLFeaK2zxvGDL55309yAQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 02c7d8b61e82..7ca4ae610902 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -128,9 +128,8 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
  * @vsys: voltage value to set in uV.
  *
  * This function takes a requested minimum system voltage value, clamps
- * it between the minimum supported value by the charger and a user
- * defined minimum system value, and then writes the value to the
- * appropriate register.
+ * it between the user defined minimum system value and the maximum supported
+ * value by the charger, and then writes the value to the appropriate register.
  *
  * Return: Returns 0 on success or error if an error occurs.
  */
@@ -139,7 +138,7 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 	unsigned int reg;
 	int vsys_min = pdata->vsys_min;
 
-	vsys = clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
+	vsys = clamp(vsys, vsys_min, BQ25703_MINVSYS_MAX_UV);
 	reg = ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
 	reg = FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
 

-- 
2.52.0

