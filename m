Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236323;
	b=kEr8o7ZrLGEkvGdPfOt29TaQ47nQqXEvXO6jA0/IokB5RUUhUGFl8AyDbP1/F1qFXP6r
	 Hm952ppxrdi3tHBf99QEMX82/p+BAA12lLG9RZiczTaFivbHt9Xcaaox52ukozGlTonKZ
	 mIbiq70uyuFH9xAoD6AkSyQF2GoqR8RgSQM3U//nqb6ekEHTqugtLBrB4cg/dxWdrDDLA
	 NF2q1XLu+JFsVqzBsT+Z0kdvm2elTmOqkgo/i8jtB4VF+hJj0TBzRZ7vesSZi54h1lK1U
	 CVOQjQG41VIpHpBSW2vX/0PgjIOIvF88Ns8MOHoMfXQJbvtj4zXnHPLipVYEdmuG1qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lvwOfzLc6z0XT7JDSFybwf/dtG+Oy9O6aFTtJV96gfk=;
	b=XPBVeHV6EeYLV7h30fsInz5XaUnmgcUW2KGbFRWACgiHi3EymDXanfIIZZjk3ibwd3kh
	 MfsdQrlvpwiU35sD9K/kIbWBi6ZwwTGnxHHf42Asbar5ICOFoLVHjCpFRIhkK6gd9Wi0L
	 6sYlhFhRlesn/WIwTM3Am9vMh3mm9UKev+tAt+cqyodqU2HpWIO4Z0NzoMxpksBZ+mlk/
	 D/PF1653yj9Ba7XBlz6sS6jxhys0iCal5xKou6dQUHlBhYgmXF01zePKJQDYc8MSyyLGv
	 FloL8DmvcGbE+HSZ+Wc/a6g/bLAXvfJJBGrmgeIh3gYYXmhyFkq3Y1Bd7QE3+CQW78w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sh9za5mc;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D6606A326
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sh9za5mc
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8439fe796ebso580642a34.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236322; x=1794841122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvwOfzLc6z0XT7JDSFybwf/dtG+Oy9O6aFTtJV96gfk=;
        b=sh9za5mc5Tv06+esieacrQk3ReQmeEcBmSQrRnR9avmlxBnT2Dpbyjj6Ux88o37zzB
         WRLapzAhX2VQ4E5mJGuatCPLUZkd4oRkMUnQ5KD0xXR39rU3TQgFv8ePeboLMphZW0I6
         hNd4tUBrc0OpKi70nsr/hcJnnsPp5xnlejnwijLVjsb7fy2t4ZZ6wyu1+03c5Tp25Qoi
         nb+NARliQiNTdfU1Anwd300X868/ikrNTDbHl+qmxcHpomanaBttOiKW5irpwjFIEg4N
         DufJUnZFIo8c9Ym8pAoXOvyTexb2yAf0Tj2eEWrTBSiQ/+tbPly++6zausxI3/pnXf9R
         6NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236322; x=1794841122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvwOfzLc6z0XT7JDSFybwf/dtG+Oy9O6aFTtJV96gfk=;
        b=2CZeYI3xnTATC3rJEA9Z3EVSkViFs0iz4kAvIMVi2/T9U8D3ZvJd9LXzylLRttNB9F
         Nqd/KX0T+H6r5QoxpIk98tdu7hfj1UC4LkFehxn6c+6Q28nOdTsJYDUJkmfm8sKMYkik
         q+hUiOVssBMAADoWEzwf1KkVDAthQqCUsODroOpPuq4QPLexyKVhpInS8m78CkcTvTsX
         yR9eu+jlm/HDw+0aWSUnJWB8C+tEYQpPfybXyPAPDI/NXFtU1ZDkD4xJFNdNi4qA4YwO
         GefEoQJhVEPl2lncGPuHjv2PWZ0hZNKnhokudfvuDaLsG6s7CWvaAv8yYss+0kfmUitI
         5XWA==
X-Forwarded-Encrypted: i=1; AL+hErFlXBSOShAGBwEriS9ODtAGFtToK55WNxxV+8p7VbDR7xEGRflB98UV/dHzO5Hlm2NN2eyLdsnI9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Lv2QBbaVamuiTgWxHyeMgRlYThx6Da0fw6vCr4wHIfwXJW1Q/
	9q2Iu/MPW4aw9faTnQI6ola29EPiaeh0InFPAIKlZibSlRYVjs6q79BS
X-Gm-Gg: AYBFou2GT8DUQJ1kwgj1Fz8g87xtZyEadMiToxaJCvNhw1HpC0UrgBqW2hbArvHZF5+
	oqF7neDysQK64Ycae1IPg9bUj8fFRRRrK3etQ1E2E/modoMWql2FrzEr5/9lhgON5WJEZQDHS9d
	2Gd5bryOeoGzu2qpdgrejedi2sCkf8q09jZIPqCv74qW/KvwAXHpjILpXhkE2LizgSvyuwrfUn9
	+p3LBSb43bRyEX4UMRFRRPryEsLIEkBBgzW/Spx4ekqIzXwfkdSjyMJDNIVyFhAe+xn60F4gnx6
	ChFexNMVkW58OTDsGF14qfw5DWu45c/DKCetk1cLMH9S0/jY67ZoX9EYmiJoUrdm+udq5VflyB/
	DF1L6dQq8lUkwrB5XjnMciBiQhkBylSoFLz2gud9Et6jT5tKv4YOAytGbWyycs9m8jIufisK9BB
	5kuw3W7MkaNcjHJmdwZ9e9gK326R7nLvVRc7f6uCNCCv0rv/ITCU2MLhw07EQtWUE4YCyOe7HWr
	zHeXhjsAVzteyIx1st+7a0LsWlzgJu/ugJAzcv9qvCFEli0JJsH5b6TJO6RKaLSE1awlgEdltVE
	bOyC8m7+ntsDchBF5YmcyXwG4NTBHg==
X-Received: by 2002:a05:6808:4f49:b0:4e8:f740:f03a with SMTP id 5614622812f47-56814379845mr3502958b6e.27.1794236321610;
        Mon, 09 Nov 2026 06:58:41 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm4667618b6e.16.2026.11.09.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:58:41 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 3/7] power: supply: rk817-charger: simplify re-initializing coulomb counter
Date: Mon,  9 Nov 2026 08:58:29 -0600
Message-ID: <20261109145833.1363319-4-macroalpha82@gmail.com>
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

There are multiple places we re-initialize the coulomb counter. Create
a function to do this to make the code easier to read.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 44 +++++++++++++++-------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 39c945622c4d..8843871948b9 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -167,6 +167,20 @@ static int rk817_chg_cur_from_reg(u8 reg)
 	}
 }
 
+static int rk817_initialize_coulumb_counter(struct rk817_charger *charger,
+					    u32 charge_ua)
+{
+	int tmp = CHARGE_TO_ADC(charge_ua, charger->res_div);
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
+		ret = rk817_initialize_coulumb_counter(charger, charger->fcc_mah);
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
+			ret = rk817_initialize_coulumb_counter(charger, charger->fcc_mah);
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
+	ret = rk817_initialize_coulumb_counter(charger, boot_charge_mah);
+	if (ret)
 		return ret;
 
 	/* Set QMAX value to max design capacity. */
-- 
2.53.0

