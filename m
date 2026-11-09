Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217322;
	b=U+rUOygHFteFdG85ia4fzB8W7fFt7dV1ueOvBBq3nYcG/4W1BzqVmOXqVWljvnwwDb3G
	 qe4A9MQU+g45BofdGwh8JguE0l5t9KZAACVOkQE4Dijf9fqt9Mddg/rO9Not6Wx9Vd9+I
	 wYOcKOC+8PFcXexXIDAWHnwuK33nuVGAN6WwUL5gPM1hRnF7O1p/kSO11FFtfqmdc5uiG
	 nDpUlnj+yscgA6FyurFnI5A6GVIzG0iJu4Ziha8nfe2a+vraM2Q/vaawkp1nxauqOzcBQ
	 3xbvvyINH0uDGBAnxcacXQ1fONOmvNXWWp1OatcBuEY/HqXfQ6p7XAWTSqimlSJaJTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=VT/zo9JcAtk0rbqrKOPs9YxznKVRxb2WxMsneu8EByM=;
	b=ztfsH1S3dQFU0J+g74p02e76+nRSneRVOriDnZ/yTbG7VFjQkmCM4w23toYSCR/NgzwO
	 DGFYOFN0riFzPiy001/Of8JCURshh8Y/4qng26TiK2TH/H1QsQ1rOKf+43UILXVbGCY05
	 smgW/6JcLfsoE2y1khXfMCSuq+bSMZqqwY3/5IWlxequBcW/XZPz8BB8qTe8gl5mqNoqr
	 QqhtwU99oA15UevScHuiOneXsoxFezlDT542BokcJqI3IDErEhfV0IWQKQayfX9bxmNZw
	 LR5Sd1FvJ2WbQpr5UsW0O4CDcwRxj5n6xSXKWgcaKHNC/DG/2QQzHMYSg+RLRJ/2k7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=jwJWJpYG;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1C606D825
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 09:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD1C606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=jwJWJpYG
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-497614c95f0so155773f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 01:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794217320; x=1794822120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VT/zo9JcAtk0rbqrKOPs9YxznKVRxb2WxMsneu8EByM=;
        b=jwJWJpYG53W3bYNAMjjnfAHNEopoiPfqGyHAI24dyaZQLuAXG/R0aWT62L7iE4Xa+l
         nWuO1sGeg0D2G3nth8+R38WlTxdcOvd6mvfGIzMulOxmvp7AoazK5iluv2N3oUOZ/1Dz
         LVIuHoEKRz4PPldNoDNglzCZ985xc9uoyEI2GQT/QHjpy00HhmmNLf3u1OOEa96NNl/Z
         79wzRaz1EcbQ/uJtFl/1uOw/AYqFsdf9/EvwYYdhplVoG1uaz73zyGe7a7aiTGmheFPT
         Z2V1uJjmro20ysyMeFGTlEFfIrEjM0J4KZ7Bx6jqPQfBKH9jj0cv0/VpjXq/STAlG0U9
         AqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217320; x=1794822120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VT/zo9JcAtk0rbqrKOPs9YxznKVRxb2WxMsneu8EByM=;
        b=ND/k4UfUNutl398pkfc3SzFfLSvuOFxraOAfMX7ZLdW8uXX9L1n320zlwfYGCJ81RC
         pCKnAgSGtjYhMVXlZ5BzeA9O4hqUvMC0MwdnEVA1DSd8C7LXMJMNTE+XZCfxgdoKIIs+
         VdgY+1bFnbRO5AJciHLS1gMCuKisqRWGdrm3NbgS00NamnLP3mIwbS8ahuxZ0hAibgOs
         8Mew/7FHd7MhyV9wqorcaEfrR8DBcHPLZuL3+aGtqvmpS5oGhCgSASkUquXcTrhcM2t3
         NLgWdk9AN5dt33K5FaLAYt5C3zbcZRb8Ubxu3/CfzlsIIwu3/45pnFbiSC/7JUjc4z3U
         bmjw==
X-Gm-Message-State: APuU4Z90pGySLRPg8nHe3Vnj9riWywAy9XUArTgHdwMCdg7HwMb+xwq6
	lnWGV5jWtZ4VP/45tXw4zSMn1TgLVBzaV7HAP8knsDw3ysnjxeSuQGkNus6eZpkWw4M=
X-Gm-Gg: AYBFou313DVgKQRNfVY9vjqQj7Dre2NrG/VPVP9Klrv/wengCM1G3CGSc6Snya/yfGQ
	ZEdXDQKX4XHatXwxBYT/MNFMi4k25ZSTnEqdt1A/tE7alfgWjPFz2aLHsWHJIrTo62rOVIXkHkB
	KBbuooSPa72svPSaVzF3upJGYoYWAe9+MYTYnzQlQDE5VVffj5Ip4QSPL/ZRVUGRfduh56GAZUQ
	ey36WYXLBjYhHOOLtJ4uVetddof37qyI2pSSUSujdv3v944ig1wop0pibPuCJFxEaArs1B/4AgB
	IA9eZiTpizYCxFmwcSfXlu9e8H1fUTZMsFqKU9l/BRglTsq5Lql/J8hczViBwcqWE1+y+Yt2O0D
	EjK2uVCfany9a7LAz6ADCcwPwC59cXDMovqnM3S0SDIst6P/xiix0Gax4JrhMGCRT1SZqeQEABW
	B1RVPsKj+NtEptcay/9G6LE52YpFfkIK4y1KOXrrHEcY5SlqDNO75DeOYq0ZfWKG0EJQg0WyMFn
	bxpfiWjteCBjDH0UbDVABsRY0SMwI6+Ff9cbnnuuL6HCoKowcay6MpOMcXLdS7ArBZF8rB+GN2A
	TG4J5jv05P5Cu7fUYJ1c0T/GbaChv9xqJs3X9v1uRz+e/55KO/DYZDErdfuHhBC+ykH6xIE2QeA
	CQ/GwxV2u
X-Received: by 2002:a05:6000:40cc:b0:491:8462:20b6 with SMTP id ffacd0b85a97d-49583b0bb95mr7229716f8f.38.1794217320053;
        Mon, 09 Nov 2026 01:42:00 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-496150c6e90sm7278409f8f.2.2026.11.09.01.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:41:59 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 09 Nov 2026 13:41:50 +0400
Subject: [PATCH 3/3] power: supply: samsung-sdi-battery: Set the charging
 temperature range
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-battery-charge-temp-range-v1-3-a967abd8b80c@flipper.net>
References: <20261109-battery-charge-temp-range-v1-0-a967abd8b80c@flipper.net>
In-Reply-To: <20261109-battery-charge-temp-range-v1-0-a967abd8b80c@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153; i=alchark@flipper.net;
 h=from:subject:message-id; bh=V8yoLBrj8mD8VVaKSjnQMeP0OJ8ZemjP5irT6VMLt1s=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9nBr/fPfb15KlzZO16yduUD768jeXhcjnVj5DpgRJL
 hMNxScvOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqpy2MDDdCOaqtnSM+/X/1XYypuTEjYN7OXY+Zjot2zZ7+qJ7j/QmGvxJuK24
 sPvOnbdXWZyGLJvPtfDJ39661LZ3XriRvnCNpvY0BAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Give each battery a charging range equal to its operating range, as the
firmware parsing does when charge-temp-range-celsius is absent, since
these static descriptions skip that parsing: keep their behaviour
unchanged.

Leave any correction of these limits to a separate change, but note
that they follow the charge-block thresholds of the matching vendor
kernels, which count in tenths of a degree: the -50C and -30C lower
limits look like a unit slip in the original import, as -50 there
means -5C.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/samsung-sdi-battery.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index 33565002ee27..da283735df3b 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -659,6 +659,8 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.temp_alert_min = 0,
 			.temp_alert_max = 40,
 			.temp_max = 60,
+			.temp_charge_min = -50,
+			.temp_charge_max = 60,
 			.resist_table = samsung_temp2res,
 			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
 			/* If you have tables for more temperatures, add them */
@@ -703,6 +705,8 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.temp_alert_min = 0,
 			.temp_alert_max = 40,
 			.temp_max = 47,
+			.temp_charge_min = -30,
+			.temp_charge_max = 47,
 			.resist_table = samsung_temp2res,
 			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
 			/* If you have tables for more temperatures, add them */
@@ -747,6 +751,8 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.temp_alert_min = 0,
 			.temp_alert_max = 43,
 			.temp_max = 49,
+			.temp_charge_min = -50,
+			.temp_charge_max = 49,
 			.resist_table = samsung_temp2res,
 			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
 			/* If you have tables for more temperatures, add them */
@@ -790,6 +796,8 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.temp_alert_min = 0,
 			.temp_alert_max = 40,
 			.temp_max = 60,
+			.temp_charge_min = -50,
+			.temp_charge_max = 60,
 			.resist_table = samsung_temp2res,
 			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
 			/* If you have tables for more temperatures, add them */
@@ -835,6 +843,8 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.temp_alert_min = 0,
 			.temp_alert_max = 40,
 			.temp_max = 60,
+			.temp_charge_min = -5,
+			.temp_charge_max = 60,
 			.resist_table = samsung_temp2res,
 			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
 			/* If you have tables for more temperatures, add them */
@@ -879,6 +889,8 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 			.temp_alert_min = 0,
 			.temp_alert_max = 40,
 			.temp_max = 60,
+			.temp_charge_min = -5,
+			.temp_charge_max = 60,
 			.resist_table = samsung_temp2res,
 			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
 			/* If you have tables for more temperatures, add them */

-- 
2.56.0

