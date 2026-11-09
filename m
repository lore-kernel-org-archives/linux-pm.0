Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236325;
	b=QQbtkLMK6TuifDzVoDE1ZWzt5ExjsrOCiEXOYAEM1V8JkCdqNGSp+MG1c52O8M4uGrG8
	 u4Flbs9i3JndQjbxgMdH/HYkBc+1MsrYGvkj4R+a5zoRe0qH/x2Nlt9JSznQRENnRmTa2
	 jSuXDEDK89kiumRJkDs70WvzWB9lGLngAh+vN3+t9D+TFjddetfnUgk8VS+fvGwGMwvDU
	 0kLLGN/p5C1WE/29FaIusvr13dEDqZvpwLkaKtCAPZ+vZvKVqU4OkQh4HRNfAWhVIwlwA
	 qYxd+G0pPvCsJwLTWox35Rh70NrImd+4fJ3g0R9kWww29/rctajpe7cTilbwyATVwiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6y/oCXeZA/xU4FFB9st6cAy7P1KGmFoThXo49p+Yf0I=;
	b=evjk9HLe2LjkEfmlWljBregkSOjsocmTsvtzp3xCPYJ9U2yD+bzeYGO9ACqZi5wckOkW
	 oLdt+IEKX5AeHgBl3jxRYFTes0Wx+udnr57WzTGUyEFzTs9bPuGYhDvOl7WfN2lfZYBMm
	 tln/HTW3cZvm67+3iV8y8M6qanM3wo/fSX+m0bL5TgQ4z76mVCu7c5SaKzm5dwvnORpEN
	 AKIpWmh1PATxToTMptbnRXhPgxqfKQ/ZL9YatRCzjBQv0WMYLQgK/JJlAIuXsDsiwurre
	 aGuudLgru9Zlh1T8U+io1iK3TlcU5F1KcMno91CIth80k6a3xIvgt78GeyA4SIKbwpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMYgabQK;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882D606EE81
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5882D606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMYgabQK
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-5641f26ce05so344630b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236324; x=1794841124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6y/oCXeZA/xU4FFB9st6cAy7P1KGmFoThXo49p+Yf0I=;
        b=wMYgabQKKs5X0Rm375Eh/mEraIP6z1oiaECaxpyECAj0rlkvkzw9+7gsW03SzroXIV
         +7WapH/WkbCnHNBwISOyxb2+Y9ExynuyxIVY9NUU0tJqtc2m3TR+ZnG5tTgq5hnobhch
         ei87ZWt/GD8tnPcbeOM5Z+DjFYJ/RO1f7vhKVln9Wc7v/7PaI0kmMnWmrzbNO2jt7YFf
         2mTXwnsyMhhi1TxA6dJjnAFbUc4ncAuNIHrZ3SfnNTxXksorn5mNwILpKYNrt8egKJWg
         tOqVwMnncyCf3XlMgYmTaKXzEAtYL3tXaVQIB1dVpfzB312ZH9JeKz4CxnsSS7nJJa5E
         mzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236324; x=1794841124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6y/oCXeZA/xU4FFB9st6cAy7P1KGmFoThXo49p+Yf0I=;
        b=eQyvxqzgKAEl3hWikV9bjNXho9FA4n03vwdCHi8P57ZUnDBsaqoUjWNvcX3S4uHVPf
         7ROr/l5ShjybrJXUdaDl3iEetRIbzsrrxuX/Q0+0C6++PxRRmgHGy1beYUPBbND+nnAg
         lOiRNXKwLH279iYMPi6MQufh+fM2v3fGYwxYBInOk5ijiKkFbdyOMtp1etJtLngeUvI7
         CJVd/nqGX0OG+lOBJcqA432jR9+VPYB600w9vyxKMWXIvLIvjBdVNtC69D0Ucr2SZRu+
         7Up1Y8h5bnx3yFyD5rozpV8gUy4qOhet6By0K/v6BbulfTsseGYFdqfL1AKkoHKpVXU0
         nmPw==
X-Forwarded-Encrypted: i=1; AL+hErHNEvzxQv76KBRFG2u4PWFwJ7PXyJF+lMnpGAf9Jyw3Re6c5RSZKbND+euR9dtdavDY+zJwhw4XhA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ajvuMZ/m8pNEAilb7VEy2MAic3HJj1rYsNw7b1s/CExlbQTmV
	/Vobh2Sd/eNeC693gwu1jwaBkzG+hR24htCLqIZw5vLyK58Qkq7NOgdS
X-Gm-Gg: AYBFou2bzBt0+XzhZqe7DanBN89/QeAWsg43raMG8v3Jxf5KQdXCDc4w5pdAXRXHPys
	vX0xRM9feDnMo3yoLE0vgQByNVVaXF1AGU3k0Y+ywI6gXxgJwYF4APfWnMBYDFcpduapZ3shTPH
	PvuyFuQSvN+svg+VSicNe5JIGUkWQEGdMeAodKdfR4zEclP0Oou4z6KraLIWoyrYydQC6oDiqgK
	prTGrCBWkQ8kR4urx7BJqUb3MTgp+zbdvQrOui/XnmY4XjBp/TgFF0RPeh44AtScF93kgzjTHYF
	8NzuhM3wZfXtYoCDK8ENxVq18lKin0fOEPXdEr3hzgPJ+KgyC6zciI4LuVKpwl+FdyZzYEvxIYg
	A2dDihg0AtItXHAjAwAyPYu1beiDwKBK6nWfZyRnMC3jyUEtPXexDE3KTIPZNcYnUr9TjrtCqOY
	m3RSvMes58NgKgWRWdxg4TYpUEB1Ds5wMqKfd7t7eAE6Rhz0TdMxBcBjvUGUvTbvF70YM/7rzMe
	XHPLcRQxD+PpXdiONt3nMwlS1dgB8Mzt5SY2iPx2T4jIoi/LF5nBaahTDZQfEvTILTr6QuKHEIx
	pLNRah64Y/txHdVI1mfVAjwPGaLKIQ==
X-Received: by 2002:a05:6808:bc5:b0:4c1:e6f4:f2c5 with SMTP id 5614622812f47-56814022c7cmr2987656b6e.2.1794236324258;
        Mon, 09 Nov 2026 06:58:44 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm4667618b6e.16.2026.11.09.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:58:43 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Zetarancio <zetarancio@users.noreply.github.com>
Subject: [PATCH V3 6/7] power: supply: rk817-charger: Clear SYS_CAN_SD reg by default
Date: Mon,  9 Nov 2026 08:58:32 -0600
Message-ID: <20261109145833.1363319-7-macroalpha82@gmail.com>
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

The BSP driver for the rk817 charger by default clears the SYS_CAN_SD.
This register tells the PMIC that the system voltage can be shut down in
battery off mode. Though the BSP driver also included a way to bypass
this behavior, no boards have been observed using the override.

When this register is not cleared, it can result in a persistent power
drain on certain devices while the device is off, as observed by users.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Suggested-by: Zetarancio <zetarancio@users.noreply.github.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 9 +++++++++
 include/linux/mfd/rk808.h            | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index ede89d84ab0e..0d1ec775304c 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1166,6 +1166,15 @@ static int rk817_battery_init(struct rk817_charger *charger,
 	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN, RK817_USB_ILIM_EN,
 			  (0x01 << 3));
 
+	/*
+	 * Do not shut down the system voltage in bat_off mode. The BSP driver
+	 * cleared this bit for all devices unless a specific device tree
+	 * parameter was used, however I have yet to see such parameter on any
+	 * device.
+	 */
+	regmap_clear_bits(rk808->regmap,
+			  RK817_PMIC_CHRG_TERM, RK817_SYS_CAN_SD);
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

