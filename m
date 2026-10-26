Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036924;
	b=URlsQJ97FtHnee824ISNzr5+7Lk4hOJJbyHuEbWQzXolRt9iEht7I9dOkzb2qt721yj4
	 WVINfLPOHFeN4G7JlZZdETlpQPxjYHOX4qLqzR9ggUI/dlj/Eex4HcloPJNyGZD+lcko1
	 iPUAphg5ag9xhvx2duS53oqgGE7BIR9QIrGWIYCkT4Aof+rPaA3iRX7xVOfzi8T02GHZ0
	 6e/Y56d14DU6Mhjm4jZPvYfyuHCzg/S6yaLZC/udxEC5k5GLuHed0J0m8olkfSotN+gbn
	 p/4ZkLFH2TLstm3EG/dryGfXRVa5TMLbSaC439fjuB7p1SjwNNR6fhFWxzMq9mCVHjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N9zgC4CWhJeh+seFqtnSsLa173CrHxMnNgtBBhqSpwE=;
	b=smllS398W7LP/JOCs9tkwDuqFBIKtCZL1bYUfDlUtZqfFCtm4wwO21iDUtBtLmPTVH7r
	 AtEJLHQarHfxbuU/uuGQ0PhigKQbkmUay8Zds+PlMchhMcqQ/JLNJbYXlOnK/pJwZ4kbJ
	 qc5DRqUXIEhi+5zTRF0JL19mYDcgcZ/BDggBeWH1Gj1qopL0IPCcC8DIIizoTUh3tWPJd
	 YrWXnA7dIJjTlot7LnAwJ7wn6PON77WB+JJwTi29UlhxWH+QBvDKZtUWHurvg+m0FLdlK
	 GgywC6kDdi1SbNKSpBPLrEY6hiq7b4s/arqK1LwY4v9T2YfDBIpdQmAZkZemyYmzHjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gxF6lqeT;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF5606A331
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 17:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FF5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gxF6lqeT
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4911df1e196so1629212fac.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036922; x=1793641722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9zgC4CWhJeh+seFqtnSsLa173CrHxMnNgtBBhqSpwE=;
        b=gxF6lqeT4gVf/xUNIUhq3UUvwoXlNR25sMn5zwwYBwbrBUnnnXOmGYJg9VyCzTArUd
         CdZ/15/j48lSxCW9snXHOITpJzAs1hfC2eMc+3TUbE4Wi5IEq0bE1j4wmGEvTwdxiiWS
         hEiikpsMWT5UlNT/SIgHFqI4Hr+aB2miIGH012NARK2kkMh6uezWhi9ViNyE0sh+HZTm
         ujfchaSzBCL7Lh8YZeNxodcABuGBEIHZX4QcYNiMxJRWX0kY5b74nAASA0ZOwH6Y2ns4
         MCvPaSMprRjpACBJbt+L+75jKwkmx22yiQKb3uSY5+DWGvg83xadQV/iw+aSI2Qbkfbu
         yjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036922; x=1793641722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9zgC4CWhJeh+seFqtnSsLa173CrHxMnNgtBBhqSpwE=;
        b=dJQ+763tjEA/c9VQXqhTQVVGq+nE5SBPI2K68WrV+aFwf2zzKDlu4NBfvOK+0QRewM
         PpM5u3y8jdq7nklSe8GHGAWptnFVXTT8V2TSCUR1dhM+AJ6/daoxOHORE0J8r4LpmuEh
         H96qIyhXNK14nVtyk7S3UjUA3ZM0HG3LK+wtiQP7PJG2Yn5t9C4sVU7af8b+cFfCEPoI
         JrLwtBE1ERlcBYji3l/X8wlrggWcA4EWv8U20X81HKxcHnkwpXPnzgl98kKBddONJGP5
         pD8IMqkaGGufcIT9QsZf6nviEExaxPOiUB9U7KwNFILRBiZxSKuibd4I7Bkce1kkXq/1
         dwww==
X-Gm-Message-State: AFq9FYKK+BFDIVypnH2LGJVfsI2d4zZrWEoT2T/t1Z2L0ecWiJqb1l/p
	a0uAySxp111mV5cCfPxD6sSHSmeTWirrGrDJQm25A9kRSEa1z7ZqD0eFOmzSQPTm
X-Gm-Gg: AYBFou2V+CvNA+Dbzo/v0oPAKZDNMRmo/aQQPM+cTG8g3vl/dBy3DPcDrP1sTxTtIlW
	pjMYGgyRiQh8oC9YdFknSQ7UXZADc1XI+m5SEQZXHDiYK68T8yGUS50fVOsvtBMtodR4+nbN8WR
	V1DOdH400js+dwHTSV8D4LlpC9+fQe7SUP/Iq9g20pUwuC73EWK2Ujn5FsrMhuQYJaoFJt+791Q
	PuRjdD8RyN5cMcO3Vvs2rbFXxq5gdV23HIOjvlNrjY9h1mUAnsnAomTHtaEO5W8px2HOYBJulWV
	Q0vND93z4a27L5EP90Gu3/B7oH3YPPDN+8iEEXFyx7V357pTr70IH4Com9fzXB8Dq4BqldULlGl
	y9LW8a2kSXWYck7d/ReyYN+SYdhnQ6Mia+aggA56qez/Q+VjQIHBWW7rfHFuXBUEphU4xd5MWyL
	cD7S+q1GGbvc12FkdnSg5S6oMK3aBUtVXQXbUA12LN0NKH61jvZSnrOHjS1AkaDrhr+KsaLhnSL
	O/O+mLx5y0hmP4pfVVn93+BRp8mXKvNa15cRnk9DrI5JI8u/OSbnzPSzOpJnQ2iJRJPTcVwyUe6
	+8Od1cXLDPt/Ah7Z0fCW/agBbbfqbQ==
X-Received: by 2002:a05:6870:4ccc:b0:4a7:9509:a937 with SMTP id 586e51a60fabf-4a83f63d5d7mr4284004fac.56.1793036922304;
        Mon, 26 Oct 2026 10:48:42 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89e33sm5034753fac.1.2026.10.26.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:48:41 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	maccraft123mc@gmail.com,
	zhangqing@rock-chips.com,
	zyw@rock-chips.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Zetarancio <zetarancio@users.noreply.github.com>
Subject: [PATCH 5/5] power: supply: rk817-charger: Clear SYS_CAN_SD register by default
Date: Mon, 26 Oct 2026 12:48:34 -0500
Message-ID: <20261026174834.1652309-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174834.1652309-1-macroalpha82@gmail.com>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
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

The BSP driver for the rk817 charger by default sets the SYS_CAN_SD
register unless a specific attribute is set in the device tree. This
register tells the PMIC that the system voltage can be shut down in
battery off mode.

Though the BSP sets this value by default, it also has a device tree
value to override it.

When this value is not set, it can result in a persistent power
drain while the device is off, as observed by users.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Suggested-by: Zetarancio <zetarancio@users.noreply.github.com>
---
 drivers/power/supply/rk817_charger.c | 9 +++++++++
 include/linux/mfd/rk808.h            | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index b6714d8e4fed..6971f572c68d 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1148,6 +1148,15 @@ static int rk817_battery_init(struct rk817_charger *charger,
 	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN, RK817_USB_ILIM_EN,
 			  (0x01 << 3));
 
+	/*
+	 * Shutdown the system voltage in bat_off mode, unless
+	 * gate-function-disable is set.
+	 */
+	if (!device_property_read_bool(charger->dev,
+				       "rockchip,gate-function-disable"))
+		regmap_clear_bits(rk808->regmap,
+				  RK817_PMIC_CHRG_TERM, RK817_SYS_CAN_SD);
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 72419d311626..2bc58de53d82 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -1297,6 +1297,7 @@ enum rk809_reg_id {
 #define RK817_USB_ILIM_EN		(0x01 << 3)
 #define RK817_USB_ILIM_SEL		(0x07 << 0)
 #define RK817_PMIC_CHRG_TERM		0xe6
+#define RK817_SYS_CAN_SD		(0x01 << 7)
 #define RK817_CHRG_TERM_ANA_DIG		(0x01 << 2)
 #define RK817_CHRG_TERM_ANA_SEL		(0x03 << 0)
 #define RK817_CHRG_EN			(0x01 << 6)
-- 
2.53.0

