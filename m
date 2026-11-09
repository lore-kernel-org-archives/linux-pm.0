Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236321;
	b=ItaZ27zfiwdfUQPoXKWm3mhpvo0gSCLXho4JifWFzrdx7HaRm9w0o0EGVzGsxJInW/If
	 hymwVtMbI5Eg4pBTY3M9L1yYrwhHZKI5dGuireAy7EkgS3+fyTZkPwf9UjONnXz2tSUv5
	 lET70geAm3RM3HmmW7+3XBU3i863iFjcgtS2Jj8w3d1LCeJ8a1aG7dlzIRszYTg1xXZMK
	 ofM+L9MeZ/132wOu0GxJSyvT+8jnv/kDWDdBJapVqu6WWVJNZm4o0jHNUDQBkli4/ulfi
	 0PDfLCgY6sGBsVlcCElZMZTYHGfOk7rOkTGODmkgqEgtImnTSSs6636Y0vW2xPc1GSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RWGPS5KCwq3L9cW50zOJQer3a1hvbPza6g0viy0ickQ=;
	b=tlo3Y+SqXKvMA4WS9pGXBpaEOWCVSkgDeFMgtpkeJh5mG/YpjnFvA49xHl7zqcBRcI1d
	 l+ED6CMAlKHgPd6IL+DTB8syBpEdMROkTHafSMPdm94j6jhTnVgJ4e9Fugm3XhsoCqA2m
	 zD4u28RUKX66s/78BdoLqdVLG+ec69mozcE00/u1ydhdXyMOnRA25+0nS+82pGCNqnxPx
	 CqJi8R4/X8o2sy/GY410c3cidtzdng8eXHDY9S5sv3rI953rfZcicA/BUH/DfNiS8j5QN
	 ZrKwhL6gFIffwlile/T/VPvw9zMorisRzmNVrZZ9iuMnwf1CMv/idfWqzK+GfHNVuWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kqCGhERz;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4632606A326
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4632606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kqCGhERz
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4ada9579947so530997fac.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236320; x=1794841120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RWGPS5KCwq3L9cW50zOJQer3a1hvbPza6g0viy0ickQ=;
        b=kqCGhERz5b7kaCdMZ+pRONeVpjU9WeyZUso/5J/wSwcuw08ts3bQy8pFaCNqKFaBrX
         KRv+kjYF/+fptDA2BQh0mcobvgiI0TTkMMMh3pd9Qi5/s0aLhE8Yh9SXoet4A3xAdyzv
         n8+tyRcLexkrOpSJE/6VV7ikrvf/J2bU5fCCbpKqeJaTydloNYhKHop04R3Jvipzexcx
         BtBS6h1pz5d4JoTpFOKc8cCXQC8qe67yQeGyC7JJXvC1FjU6vVkMzopUIgLjmYGJZb5k
         TQAZ6BILes//O0eh3iyTgewubedohSOR2h5sFo6q+78Ud0yH0DCpPYFX706uxgIRUBKW
         uxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236320; x=1794841120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RWGPS5KCwq3L9cW50zOJQer3a1hvbPza6g0viy0ickQ=;
        b=saQ059grdUdz6nX1cE/TjbS3nZVmQJ3ZmsWyffkXYCcApGvgsh5NZqLLJidoYpcjy2
         2UoWPpFvDx0P2PqRXl3J7P0nr0u3uojqSIkyUpUco3bJ92MheY7jbTFUGnFcoCZF5y95
         Pqx47SqQ/Y/tb6mJaYf8KRPVTXoysVBn3mTHHYcnK4dqjM0RGPoa275111G/dtKg26dq
         rIWC92W78h+fNeNFSVBoP57CPF8Pu9xFTluGARQumfmlSCYRxM2a6P2JIb4l9W/6uXqI
         FVi1IoDTi3dc4fN+vH7huUDWclFdO7l8sjJBN7ONdgQFWLcd+o6TQ3oaplgl24YvQW0/
         amAw==
X-Forwarded-Encrypted: i=1; AL+hErEsBOZxEWf4Lh+/Ccfv4iX25zIqXJ5X5CjSR6TGaTGRvp1aFgiMO3tmsS/8roma+RrQ7p8oIcxAPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ygDr7IF3YeSt/X4QrUdhtScao0E2bMlEsinUKOitomIJr8qgY
	gk6ZYapebxc1Y2KLG1f0weoLMrjJ14HgrlzI5SpfDqndFepPBE5+nF2s
X-Gm-Gg: AYBFou35KsULjqE7v+/440eXrmwwu7x1RByNmfk8SO+1w+KiqQdoSyOobB3EWGOEj9n
	hAt1DBQy9+i+2Gcq1jGdfpyb120cInfnYi6yxuVU8/Qv9/HKaajZtmTJoOR1Il3iPEGLZS2t85n
	U9Dk1RA388YBOgf3A77o4S1RvXyTH3k3K8UiwAexaKqGwsqgLVYRIzfYeJGDZJloXsECPmTtLUy
	OjPfWa6+avvOINTzNR5+pR1ZZIAowLOKO1KOBBP8uZffOiOFKOKQx0erMg3J7JpqJmaGrjERfAm
	z0QX0LjDsknoIaTsb1T5SYdvHSm1vmyLk+SRQC30VFoOArfSDoW9myjywhGrtiRn0uH+b+h1AY1
	EMKmzW7OlrTgwlyBuibU6G86h5OYMqzhc8e4YJCi86EDkkcTCH7it/Q/vPKj6/zA8M3R4ZWQ7eU
	H1jSN1gJwEnFKolJxsIRX6bpWinnCc/9AKNyF04cNbX6A8GFmluEXMedOkYLiIbnoNE/uNQ3xI7
	5JaPVIUAqUHeqAe8vDm35058fEKAEJw7bSZWjy4FAdBwcAr+jOqgMMti/1mxGKPfLPkmqwM+g3+
	+SvIwgSRWCVTVWIu18v4HXKG3Xkblg==
X-Received: by 2002:a05:6808:6605:b0:4bc:fbd4:2a43 with SMTP id 5614622812f47-568147560d4mr2872449b6e.41.1794236319604;
        Mon, 09 Nov 2026 06:58:39 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54ff0sm4667618b6e.16.2026.11.09.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:58:39 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jacob Cook <jacobmcook1984@gmail.com>
Subject: [PATCH V3 1/7] power: supply: rk817-charger: correct spelling of coulomb
Date: Mon,  9 Nov 2026 08:58:27 -0600
Message-ID: <20261109145833.1363319-2-macroalpha82@gmail.com>
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

Correct the spelling of the word "coulomb" throughout the driver.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Suggested-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 5558b182a1a6..674622398efa 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -83,7 +83,7 @@ struct rk817_charger {
 
 	/*
 	 * Calibrate the SOC on a fully charged battery, this way we can use
-	 * the calibrated SOC value to correct for columb counter drift.
+	 * the calibrated SOC value to correct for coulomb counter drift.
 	 */
 	bool soc_cal;
 
@@ -270,9 +270,9 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 
 	if (charger->charge_status == CHARGE_FINISH && (!charger->soc_cal)) {
 		/*
-		 * soc should be 100000 and columb counter should show the full
+		 * soc should be 100000 and coulomb counter should show the full
 		 * charge capacity. Note that if the device is unplugged for a
-		 * period of several days the columb counter will have a large
+		 * period of several days the coulomb counter will have a large
 		 * margin of error, so setting it back to the full charge on
 		 * a completed charge cycle should correct this (my device was
 		 * showing 33% battery after 3 days unplugged when it should
@@ -294,7 +294,7 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 	}
 
 	/*
-	 * The columb counter can drift up slightly, so we should correct for
+	 * The coulomb counter can drift up slightly, so we should correct for
 	 * it. But don't correct it until we're at 100% soc.
 	 */
 	if (charger->charge_status == CHARGE_FINISH && charger->soc_cal) {
@@ -307,16 +307,16 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 					       charger->res_div);
 
 		/*
-		 * Re-init columb counter with updated values to correct drift.
+		 * Re-init coulomb counter with updated values to correct drift.
 		 */
 		if (charge_now / 1000 > charger->fcc_mah) {
 			dev_dbg(charger->dev,
-				"Recalibrating columb counter to %d uah\n",
+				"Recalibrating coulomb counter to %d uah\n",
 				charge_now);
 			/*
 			 * Order of operations matters here to ensure we keep
 			 * enough precision until the last step to keep from
-			 * making needless updates to columb counter.
+			 * making needless updates to coulomb counter.
 			 */
 			charge_now_adc = CHARGE_TO_ADC(charger->fcc_mah,
 					 charger->res_div);
@@ -757,7 +757,7 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 	bool first_boot;
 
 	/*
-	 * Check if the battery is uninitalized. If it is, the columb counter
+	 * Check if the battery is uninitalized. If it is, the coulomb counter
 	 * needs to be set up.
 	 */
 	ret = regmap_read(rk808->regmap, RK817_GAS_GAUGE_GG_STS, &reg);
@@ -811,7 +811,7 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
 						    charger->res_div) / 1000;
 		/*
-		 * Check if the columb counter has been off for more than 30
+		 * Check if the coulomb counter has been off for more than 30
 		 * minutes as it tends to drift downward. If so, re-init soc
 		 * with the boot voltage instead. Note the unit values for the
 		 * OFF_CNT register appear to be in decaminutes and stops
@@ -840,7 +840,7 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 	}
 
 	/*
-	 * Now we have our full charge capacity and soc, init the columb
+	 * Now we have our full charge capacity and soc, init the coulomb
 	 * counter.
 	 */
 	boot_charge_mah = charger->soc * charger->fcc_mah / 100 / 1000;
-- 
2.53.0

