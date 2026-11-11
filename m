Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430597;
	b=e5ftnLWKZ0kc2hk8r9bmOS+Ay0TyOy+hcb0fmPi+0UQz39st6KBjPAKzXLCY32lIT3DW
	 PEiMHirlvJ6KIKrwfyG8B2ZEyxtYQfhpKWl7yy9JAhqSqE02MhEzX2WheZZZ2bqD0i4i6
	 7Y1egvthnpHTnR05ttHhdR7Csql36ftiCYSCOc8brm6Ilcy2J1HS5AWIQQQR2eeUT+HBA
	 QaoIlSquH92QABBTwSmmkTKQ2ZZ0Mzss122aNfHidhEiLgO/6ddzSFczEF1Franu1q+qF
	 uo26IoYNrrLRdvECU4Rrke8EqJQDHswyIOQenjayetlmni5i6y5AXsZ6VwAAA+AlGPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dfuuvi8PqCWBIxnlWDIfk4bUIBmycxlNRhh1kkQb58s=;
	b=V6XGREXYYiYCHBs6fy0l8xi18Sfa/3v5DXLESDJs4pzP242SstVqo6blcw8XFYYY9pM+
	 6eElYNqxy5CInlGmhD6PKK1DpYOg5ntnlRMYIVe26qeFpJilHigcTLEHWeu5Fq3Em3eEH
	 mPv7RSUKV6R+g4n/lxY7k+7qVbXSmY6eZLVT9s+CIS7f0eL65JCv8ccuYZKno6mlXrxWY
	 7FnX/MwubqyAZFAlUMKp6JXGYGyVQbH9UfrmktawjkqwZPdOd74jNmSoQVRh5xGYMaJpU
	 Gld8DKBFEem72Gl2ynBUfxiDN2ARspVCxUVaxiLLNwne+MEmGSk6rtdC1wJPoEe2Pyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mBtmkbgL;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E3606A321
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347E3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mBtmkbgL
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451a49abd8aso3408163fac.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794430596; x=1795035396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dfuuvi8PqCWBIxnlWDIfk4bUIBmycxlNRhh1kkQb58s=;
        b=mBtmkbgLlRzehWHeYlD30YrqG+1bRgm1+bbb8QmpSdb9M/7wOvLk+IXsQuXkFiTfKw
         KgjsBf3rAps4EnEhwsx4N6PlkbDX9MVtNdd+2ljZQUcscFJ1AsMknJ3VqNK73qB4yvJq
         QLnjW8RkHz3hMkA45kJIwQ1jANimmfNtXHoBLfQuWRcIj3TpEH+l4ACJ6Pne1sj2/VXB
         9hdi1Cg7/8s/5veaIKa6woRZCSJytgMilgU9dwexjwL4S8iLHimim2gstPtgTm09Rr4U
         wiOgcbhEubf2QJ8ZcnBQHYFRtNkFTWyzIViVfJ2CFn/Vbg90GlvRemN4C5A5EP7QPlAU
         e9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430596; x=1795035396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dfuuvi8PqCWBIxnlWDIfk4bUIBmycxlNRhh1kkQb58s=;
        b=Ttrrkc9/vqv4/uEMls/9wlC9qtCkO64x6kw6OaQ35cUymlZDC7JG7FeG2+7ixFOO1F
         W0ICFYFakOIB1dVA44BSFK2cF23Tgfq9ww8DwBY77W0uxjhCZS/mpgCEgC+20FCMk8lL
         d3KhbqAncHmK0U3Z8gf/i6DTjxjFS+2JOZWa2O1Nzs4eq8n4ozV9qwLVOzzTMo3haj1b
         hmse4z0ObgyK8v1/mvOOO19auFWPxh6dJVLoDwEY+7H6GF+WKm5tEO0RaCyYfKIVARNB
         9emLyXNflQApG9yQfS/dAPEO3arvmD99ve/e+9XVYEuhz+XJ3x5ClKWXikCAQu4uhCbX
         xmgQ==
X-Forwarded-Encrypted: i=1; AL+hErED9sOICwyFPcm+1+EMIz/pobT022LT3EpQpQsOesaSfsJ5u/GYDuZV1QQQ2pwK0fBgZQ9YZeLvDA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8o/GnFcydkitzdaX7KeQN/9Gs7EzANxJQESCy3Z4V0btZ/evp8
	qPJf3jzXby9gqDRV5hBQW83O3zJGRC2qGsqL7ELOLqxO7vLpH2mQlZJD
X-Gm-Gg: AYBFou0Ak/WOUVecD+s9GDEWrXTfCNEQwqOh0yzluMSrXjL928Xow8VPByTMyUjcAlz
	0Dn35RugtkFWwf4DQFk2dHjfo7RMnhRyuulVFYIiAOWgKrDTJGHQV3iQzoX7Jwc0sKEeSJcPKXZ
	daMqeMPTv0GKouxsgm0hUtgBLXa4mWnD9Km8BVgcgX2nF91P7UCAclqMlMUVpJeHaQ1enFBRQ7N
	vh+eN6hisyDWUQI/sZY9jj358LIAZl+xuZ23aRnlsDBToeuqQwc+Gzgvp5UWQ2Jkc6DzjzqNrtC
	pawe2R6YSfVyBweoiVtNfGfTEEJuO+7rmYb54v7MchwV4QFA/5Xk1liwKR+Pht/gt8khMzM9d8W
	lr4Ceu10yIXbKfq15pwb16znFXdRdW0hwnZG9ZqBjXO5K3wZbTe9kuAkuBzzfhJxby1+Jwmgfns
	ddY+rFqbCZy9FWLjc48E02udRyQyz03fW1nq5jStV/SjsV6Dt5itv0C29dOt5JRzTpME6Id0i9I
	7Pe35NvUjjepogh+W1A50597gNYMMffFNPqrHKOcjWqp1WLR5tAGnHnfKcZNoHX6n6EPjpzeQrN
	gRQiJx9ZynAKTd2Oi9WaLozMRGXsLtw=
X-Received: by 2002:a05:6808:c12a:b0:4f4:4eef:52cc with SMTP id 5614622812f47-56b97717f4emr3116599b6e.43.1794430594226;
        Wed, 11 Nov 2026 12:56:34 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm6564231b6e.11.2026.11.11.12.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:56:33 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 3/7] power: supply: rk817-charger: simplify re-initializing coulomb counter
Date: Wed, 11 Nov 2026 14:56:23 -0600
Message-ID: <20261111205627.56652-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111205627.56652-1-macroalpha82@gmail.com>
References: <20261111205627.56652-1-macroalpha82@gmail.com>
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

There are multiple places we re-initialize the coulomb counter. Create
a function to do this to make the code easier to read.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 44 +++++++++++++++-------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 39c945622c4d..939d4fefff14 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -167,6 +167,20 @@ static int rk817_chg_cur_from_reg(u8 reg)
 	}
 }
 
+static int rk817_initialize_coulomb_counter(struct rk817_charger *charger,
+					    u32 charge_mah)
+{
+	int tmp = CHARGE_TO_ADC(charge_mah, charger->res_div);
+	u8 bulk_reg[4];
+	int ret;
+
+	put_unaligned_be32(tmp, bulk_reg);
+	ret = regmap_bulk_write(charger->rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
+				bulk_reg, 4);
+
+	return ret;
+}
+
 static void rk817_bat_calib_vol(struct rk817_charger *charger)
 {
 	uint32_t vcalib0 = 0;
@@ -242,6 +256,7 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 	struct rk808 *rk808 = charger->rk808;
 	int charge_now, charge_now_adc;
 	u8 bulk_reg[4];
+	int ret;
 
 	/* Don't do anything if there's no battery. */
 	if (!charger->battery_present)
@@ -281,11 +296,9 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 		 */
 
 		charger->soc = 100000;
-		charge_now_adc = CHARGE_TO_ADC(charger->fcc_mah,
-					       charger->res_div);
-		put_unaligned_be32(charge_now_adc, bulk_reg);
-		regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
-				  bulk_reg, 4);
+		ret = rk817_initialize_coulomb_counter(charger, charger->fcc_mah);
+		if (ret)
+			return ret;
 
 		charger->soc_cal = 1;
 		dev_dbg(charger->dev,
@@ -313,17 +326,9 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 			dev_dbg(charger->dev,
 				"Recalibrating coulomb counter to %d uah\n",
 				charge_now);
-			/*
-			 * Order of operations matters here to ensure we keep
-			 * enough precision until the last step to keep from
-			 * making needless updates to coulomb counter.
-			 */
-			charge_now_adc = CHARGE_TO_ADC(charger->fcc_mah,
-					 charger->res_div);
-			put_unaligned_be32(charge_now_adc, bulk_reg);
-			regmap_bulk_write(rk808->regmap,
-					  RK817_GAS_GAUGE_Q_INIT_H3,
-					  bulk_reg, 4);
+			ret = rk817_initialize_coulomb_counter(charger, charger->fcc_mah);
+			if (ret)
+				return ret;
 		}
 	}
 
@@ -846,11 +851,8 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 	boot_charge_mah = charger->soc * charger->fcc_mah / 100 / 1000;
 	if (boot_charge_mah > charger->fcc_mah)
 		boot_charge_mah = charger->fcc_mah;
-	tmp = CHARGE_TO_ADC(boot_charge_mah, charger->res_div);
-	put_unaligned_be32(tmp, bulk_reg);
-	ret = regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
-			  bulk_reg, 4);
-	if (ret < 0)
+	ret = rk817_initialize_coulomb_counter(charger, boot_charge_mah);
+	if (ret)
 		return ret;
 
 	/* Set QMAX value to max design capacity. */
-- 
2.53.0

