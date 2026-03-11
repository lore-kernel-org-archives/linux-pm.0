Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DB3E0229
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230195; cv=none; b=h9pBe5twGes5uLrP4MwXrJcO5DqfgWDTX74//dHcyLKKyEO3IoBAwkC/fb/JNPw5C1fTs4WCVAIXcKbwlQAisWwm+t3GVOBzZ5uu2EdLcKgyFn0T6bLOb4WwdtqHN9Ae+Y6RyxYeMaaE0ocUhyQ3nEdPjUym9LoekgKNhb4aN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230195; c=relaxed/simple;
	bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8jI90obFhM8OFUqfWoU+wLOO5Le8sw/aHemh3nm/krsGI2t3ZGKpdtqjqA6FIuf3gCuMJmigr444AO7fFVPnjxAcdegKVByo8He95cd5eOviDlAC1ZrzLaPMv/hTCaogmT7Fq/rQf1KM5MOQPlxmOkf8AT8vXfUolzLx+ErFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=j/snTdrG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="j/snTdrG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48534e9076fso27617955e9.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230192; x=1773834992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=j/snTdrG27oLf/uCezauuFlD49o9fNjd0IndTm/3x/L1kqWEAKsp019S6PsHtLmQpu
         T24b2Ixz7rtaE15Nn6T7dYUJrYIUi4SnzeUvhVb7R2OguQNx1JD19I9w0FnH+7MKDmRF
         wzC7CwscL+wrR26vifi9uEKV4Jgffn5cader64cmHZjpYS+aG01Gq+xPL4syDk8C9FCJ
         Zk7In3/1nfOYZOb0mDBM7o9W3JhBmqhugdVlcCppiHbu+wn2D/AmK2KG1r4+TR2pcKpZ
         TD60OoPVFsBgV2SGKIyN9/i+VZvV13GF0DnNAo+2zL3Bf+vafYiTb3vfErvJQEnb4Xry
         5b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230192; x=1773834992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=PBvNq3/k+2+915MTp0oH/accq3+yrPHX1C6QUh1q3y741oYvk2rFRea/OAp3xAeDW7
         cLcptYoi0b0wy+JWnYYoVQisQiCg0t/2x5EZE2nlS3xkiecpNS56Gl5dY1gig1jqcPHJ
         uQ0zlUyC5RVukb1z0e0vrZqiLp8kzCmZtcf70ZeBaM4szLzbkpBkSakcnxBPVxxmePiV
         yjbPmpMjyxEdQfrV7kbEVHiZi9LAZb5z8+WSGasMLE8C2FpE7MQ7xpvkA9NDGIMDKjc1
         i/eMFFR/LptcFcmktOuBckH1+IHWKFMsWtobRTlAJfD2P8T7WgoRp4GLZ2WvZ4sRJ4bm
         h/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWFyDyB7v4l1kdIwt1tTm5vyntEGzzPM8RjN9n2RkhY15L2LqFnPdC9RryBayL+TGCGSATBo7SggQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpzKyWm0pLZwEm0i+JuMifvGKDkMhZp4sbf7ZJ38yS5FH9ywYM
	t9j0zSwgzfF5e/89yVIgdfUxI/jH/lcT+0VD+KISMyrT/dfisb1C1uaIyv4UsZbnHv0=
X-Gm-Gg: ATEYQzz6zENnGOe0P7TEJZMhdc3GzYILvLjRbos+2v0YzxJGgMZaWP22rNnoHExjTB+
	Y4lCiUYh97PDwm/JhwrmMnZmstS23S/O5CcWKPv9CpIaah+AOaGyD6OFs4ujy/qVhrw00DdajbY
	7PqVJhj3KrZfJTp6jTjG8/cIh4DyiNNi0YoHCmzWIDehC6Ep5q4iCps11gUL1OEggUhubjLGQm7
	NMqliY8JlJdv1WjR8F4enScT36f4WQEw84X3LAzV08XKd2vD+i9iakRaLFbeWJ96hMQutM7iS48
	znXynD7hJkJ7d+SWZZQPQ8VpWSDutR2g/seFGMmvq047LNAfYe4iPATaNvIe624eE432WWIHHD4
	36s8XQUTb9HCR1VfXsejAI/kBBD15uDEHk+Y40piJp7E089j0LwtD4mKJjyu/WugeunxIqrFCDm
	KW5TC/7vJ0n8agZEV6hzyQUODDNcHTKfkcYYfmJp9YwvZe1zJXasRuC3MyALwftZhVoPDlxLZTa
	eOxLg==
X-Received: by 2002:a05:600c:1f10:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-4854b0a5471mr41617415e9.1.1773230192293;
        Wed, 11 Mar 2026 04:56:32 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:32 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:18 +0400
Subject: [PATCH v4 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-5-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEgWT/ucbxX14DGrGb/3Ad1dh87rCMvdO63tkLm+/
 u6bw0FRHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEy1EDfDf2eTRTziSYc4pghLXi6PuOqjy7lq5U2Vr8Ip4p4ZP3+mHGdkOOWaoP1
 7berHE98NUw8vnXvhqEMGU+Z3Q34l02MZbMte8AMA
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

