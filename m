Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E15421EE7
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971843; cv=none; b=hBaVm3KLbFHz6fXVkLcJ/NVpEFJG2StHaujE1vzFEMYkmeQmd6Kv1lKREgHKY00v4PR+YC+URVhjs4ITS61Izb51+gqc8QT5p6x7RTjsy/C7xlrLd7Vy44E1BynUawhbUUjEglEAz69PZISca6WgT20a5diEwtkyR1nRLBue5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971843; c=relaxed/simple;
	bh=0GDlOYezmKEXCru71ex6Z77WQ5tS0GByeoQbXgUi37g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJTCni6TQSSkJA5FZGBwS6opZXTjSpzvnF+VhJKKMx83gIUxqLsq7IX+z9oGfI0S0XW/+6ToXTo2Nzg/6g1x1yYKggzon6v8ASnMl30G+s1AcRjzE4qFRGA7cS7VAOV1b4G2RvMoqnCQLz+yUIqx04tQwqr05QqC1IwU1uuTwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=IOblLjR7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="IOblLjR7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f454be5bso197485e9.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971840; x=1775576640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=IOblLjR7HQd71W849/IK9hJ6liawmOg+zs3cacx0vsxLrWpHxEKTJP3Q1VlgwEddBQ
         57cCJEJYHr+qT0/HV5drJuRhCrWHKVY0H+a4hWazNcQP26VgW6RYhR4vTnIZYKVb0RrM
         NqMM8TV5ELdLF8ujsONhClD9tQaWKuJNd/3AI1YB0prpOnjlirEZ+7GfYipWSAIh+Nyv
         c3PXxjTi7YTiiTUKUD5uSQpYHDs84t2RI5O4bk7QiiJ+Xo5YuADf2Qt37HXDpAEEJR5N
         1+2ZOL61/G5DGRa9EPbX8roNIT/khWZP621RxIylfqNt1XRgL4xOLKVh5nKxQ+sEgODR
         fv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971840; x=1775576640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1uQzW3+bjNeF/wEPgSsxYt2kbdgf5x20O5xEAeMiek=;
        b=m9vQ5OKSgTV0GAL9SiYz0L3FjQVw8+43ZNYthDo4jkNhOWq+KFUM0Ac5U3kGxCxxjh
         N+2onqCHY9Z+ffdImrSpvFXwZdzXCIbpjuCOO1yt301JCsnc7Je3bGxNsBe8h6wGX/9E
         FyBJn0gdc5T6VnZ6tYw9/yJoWmVZb/EBm94SeOFEPrUpqh3EZeR2DemilWXN43u10B2k
         MCqV+wxIRkSclBkaKywIDm0CfHCDHJCczcDVpUqDf+EGLyYLQxJhHOiGNB6aNr5fjPQd
         OjSnbwatGYx4d+NubpaOvUCUVR/dm4mOL/IQa2Yko5CNaIjKXaJnki4Y11dk7yd/BQIi
         Z8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvsuyormAaiI4IHF+ANXGwFGVF3NU9TjFWZBVOQi/rtVRcyq6snNjYilAcOP5852GJKMhGqJEtbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDtncftV3wmZTbNSCzK2v25jk5ACVfLPM/BuDNEVAdQ2ZPoAp
	VK+aN5zKoK3I25rZShjIkVpa1ADt3iCLiBIKXJgWYxpcQbGPF6NPregqDZ5o7VzHXoI=
X-Gm-Gg: ATEYQzxQsCr4bjKwb4HKTxBvEeXGNC/ZKeKidOOLXV2EBDITDpNQx96EoBaJHVqkDiq
	F2RHBDS7m8sj8WACBfK034FEHLNfewoiCj9wepcKUy3DJ5PpOmMlpZWBgPbEv0RIQiB+57tdIcC
	x37Ur8eNuHdPmiP766r9QArkficxjGZYqNtP/hjCUfgJZQf6TFOmFSklVV7YIenUVvWfDvhRB6F
	csKdBq0x6SSRmWRSyLKX9hKLEgKRIRWT6CFZyLzzH4QxMcrxHPVUL920Vh2ve5BPeVACOW/CdtH
	wETumrHC789fICDW2BL6pDgAq36r3YaxavL+N73CmEcJro82p9FdX8tOilPYSiLfpRaKAurnbPn
	IfkiwYH1ED1rK7+iZj2sbjSaw5B4IoQuhytHPMw6C3iO7ywQXvIXSenlmNpeg/7IzljqNIdyP0I
	izmds/V75Up4+Q5oO//+a2VtmSQQaQa37TAbf8c0d4L3Vuv1u6WVK0BN3SzgreJ4xJoQqcx779u
	TR0VQ==
X-Received: by 2002:a05:600c:8907:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4887818678emr52899635e9.1.1774971840282;
        Tue, 31 Mar 2026 08:44:00 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:44:00 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:42 +0400
Subject: [PATCH v6 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-5-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr0+sjLgRVHOB6OerPmLpvscZ0m3erZk50a32q+Xl
 yo03Nwxs2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICpjgln+M0aXljvxlI0N3xyguz3uHsTJTN+HJ7//cK3usm3Qg++kY5gZLiS+zs
 /qOGy11x7lmXyqpdNzdx0xS7I9GmwvF58e7LsHm4A
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

