Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430599;
	b=ehaWz67yUu/LHu1ibwkRHWAsvYqDS2m/6Jui1S4MKUNjYsE7G4F7Aq/UfoJIxYboSC45
	 NjTlAKZfz+ymsNqKmBjQNZ3e9S2mxEnHSqe5dFtihomi1GWp+jlNcpwtBQAvctQOrSvax
	 wQdaaAWDDW7zD78eMAf/G8MgC2R/SJ0Mo3PC2eh1WMsE7iFzA03ZR1JKDDnKOEEzofHhm
	 tOWgnZEcBONZciyFZESzbIwAlGXDvJhRwv01z+BI2YrlS+Rtu7nDBULinZ01SyJ/l9bl7
	 ehdjbmV7jVnaLEN5mZhZ1cZuHTjrlegmB8d5vdLvogZABPwkJf5WbWwf7Fj8FR1QkBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kZH7ulLlOmLBHaQyYUqZ+qwps27nudFGjZP/GZkheHs=;
	b=zvxZk46VXDkn4IHBVoVNJVgLsap9VsMEt5Z8oYoTwkfNg+JQbcO/YrA7wh3tvmOnRkTk
	 /oR9ezjC6TZvznLL2IlRVNGuHUNeD7wcuhaHsvl+A3/3XhfOn3tsvMkvKGtS3NHpNfYQj
	 9cKf/nSO1/us/GbovZrJZ1HcXexYjEeGSOA2UDQmfRkA2J8dJjBqCuDN18McMciceTUvA
	 GPMxMho/b7fzpFnt8WPryIel42endYFzSmmzrjRVDj2rY9qJRsBjdRmZBzKcpSc17EQEA
	 QgXH5KKQyidujlmpQJrwpgIDsBndXZQF92IKNXXRmkWv4M5T8mLaRPktxlxh2onzO7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LEq3Q9Du;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12492606A886
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12492606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LEq3Q9Du
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-451a49abd8aso3408172fac.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794430597; x=1795035397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZH7ulLlOmLBHaQyYUqZ+qwps27nudFGjZP/GZkheHs=;
        b=LEq3Q9DuZHKMdCGLsPceVmNhFAY4QaXtNjuJ1J8MdeaYJzCziY6XnZts3J6q/GvWpz
         F6Ckw/nxph3n/03N3r90OLnZsQRxIbNzYpRQP1QJB3gveHHuNFf2hNi0e261SjEFvuZW
         cm3pnSIMU2fE4xa6ldqYNaacsoYjB53fGFb11LicwK7JiYlsulSLRqb5aXRx+1qtkbqp
         EKRCi3HFxwPLCCOhfyOg0O4YtAiXUL+bPeM9miEIqhcqB6BxuOHGj0edcWKuJZlh2IYc
         VbVRrzo2pUfmR0sULDu1OmomF77Dsj2e2j4m+dYi2nHYvh40KuA481Sxr7xOcnKmwUgo
         xJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430597; x=1795035397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZH7ulLlOmLBHaQyYUqZ+qwps27nudFGjZP/GZkheHs=;
        b=v3VLYNDUe+Mq7k4RdUVW70W/DAE9mmvk6J8Fgo/eKIA0Nja3e2EoluaszhubCUOH+x
         oeyjQyjZtzADUi0BvOgaU/djkT/CX0UuqWY4EFO5bksAOUWzW9ZO/zzx9LsjA7h+yaS9
         qmENbeJdn9PCsuJias8lLmWZX8JQ5X2DJ1P2lLfOaS22bUQ/1gr2lHe/ZirSp+KXBofv
         p0zYOdplwKqdWSNHdtuu6EYFr0WwIhXU7K+7N1R2UGi2KoO+LKYVYywoLOaWd8j5be5C
         a7qtbGSBdUkKfOCDVmH8ja9xrdjaCZqBupb7ffUW293gTkonp97j3ActaFaI2fWJBeAb
         4YWQ==
X-Forwarded-Encrypted: i=1; AL+hErFmzhmx8wjgQzxbRJJ2sHlnMxAcr4iHGXI3IOywmSz6AtOh6P2kQwFvlIlGs07ePcopyThNOwpi3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9JWjXcmSI4sr6IHuBqdt7+UwgxqIg/ac7yLMppjUdasikb5F4O
	fsaQxrYYy8DZikGn0CJPtuWMpRiCPyM0XPk+xaygngbpymn9J05E4Cfl
X-Gm-Gg: AYBFou2PBGPEjnzqFJV8ShyTl1IjEGp4+XvWJSNW/Vm0cj6oWQ7n6ImvPlFZv8MTAZj
	AHd0QMfLgRMg094ZYifBzWWwIY5EXN7bD5CKCZXy6nQVnxfkyN7E0zew7/JcOmUD9hrnVB2qZ9H
	8d8KNHdscHVn4hQ1rv5ze89DNgC3MiaowImt8ZOe5MLUdMxL3ZAH64E80D31WB6l7c9phTXu2W3
	b/rAagz1uWOMh94l+zDkM/kKz5w5LV5q/JCSVAuemDdMjw3voZMPDxrBw19XaGMhbdLo46bQ+4A
	N6Hk0x5VXmUDWPJttvhXVyJaDpzGhILQjufJ5Ln7Exx/FpHUPZSAHseifA3ZIh62NdsAWO+ZHe5
	Dum/IxcY+X+Zd5j4mL1FGANa7m9Fo16GO91Ng+DyNdA8M3z5ZOMZ2rw4pcada1aNOO9294C5cqh
	jcatFLawwUIpXrpmV0oZ0/yr7Eje0uuUSOXTu1FjESOF2hV9ZL1an8vo6CJfXFRm3NUMbETZsFZ
	hAunHsBWzKayIZZE1FdnH9iYfkNut5Q6pHF6ztlXr4EZ+ghagSCez8sNIBcXJjjY3siaC4AC2vV
	uIKo68p+yW9VgJpr9kifjVR4ZTAexg==
X-Received: by 2002:a05:6808:5198:b0:4f4:9314:af39 with SMTP id 5614622812f47-56b96bd3b81mr2711691b6e.28.1794430596927;
        Wed, 11 Nov 2026 12:56:36 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm6564231b6e.11.2026.11.11.12.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:56:36 -0800 (PST)
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
Subject: [PATCH V4 6/7] power: supply: rk817-charger: Clear SYS_CAN_SD reg by default
Date: Wed, 11 Nov 2026 14:56:26 -0600
Message-ID: <20261111205627.56652-7-macroalpha82@gmail.com>
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
index d334941ade5c..9a8d14691f9a 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1187,6 +1187,15 @@ static int rk817_battery_init(struct rk817_charger *charger,
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

