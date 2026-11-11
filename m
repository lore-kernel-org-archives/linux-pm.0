Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430594;
	b=e38ZUsSiEGAJvOiwm/+eBJDBv/0hYqbMQ5qkQMW9W/aypcfn+2hKfA+xZdIHS6ERaPOB
	 UVPabX3ZhOM8RCmWkkh0WxnIuzU2ZmuYInIXFWCFAV4AOONM4KnvL3fUllTOUpLYU0Gek
	 EsZFfi2YnzcDK+o2sqafgwWzRm4TJay1VFLemSme6miLaSfNYUzBusyKWTgzvW1fCmiJy
	 4B6HWa8BFjHRxyQhDbgfNumV/99Qks0PFnD0IHSrrM0FJbNiEMrRVcXvn0aSH4vXPOHJy
	 RDHuNAiMC3A0mn2T9OTHiliU5iulHVXl50+gls5eW+CRE4GstiVwSfeYxdEfONsp80w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RWGPS5KCwq3L9cW50zOJQer3a1hvbPza6g0viy0ickQ=;
	b=sjM12Cn9gHH6Csjto4KDtMgvcCX9CH3LXohLHBArckmuLwTgVNZY119xyi1ldE3t9lQC
	 ut4xpPmocpfA3+UPiVGJEvol7U/YBhfEMBLOj4bP3D3YEOzydph7gj6qVeqynWxO+jAtZ
	 ymc+vmYoN3H+jBTSLqJdRXMhYyWiWkKKD1B/qqj5YS//gEOzqWL5unelM+BovIi3pu8ht
	 g1sDqIRJIpBnd8BiwIXUn9m1fKgW6/8lKHfRfGowC0J8Je2L/wifnvdTABDOSvhCw8fJm
	 0fv+cUVKGlnqE4tgkyhXk5NAfxtwvIQ3RWftNQgafLPUf9WdqXQwnH/NugtFUk2AA7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYhnKk3j;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F5606A327
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 415F5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYhnKk3j
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so2573372fac.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794430593; x=1795035393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RWGPS5KCwq3L9cW50zOJQer3a1hvbPza6g0viy0ickQ=;
        b=qYhnKk3jTD4+XSMj79lh2vZy7Yqo35Uit+PG0MA3AnTj2Q+1u8lqAtYzUngMJL6M6L
         ha2LxV2FAr7Zj68wjNhTmZ/ycqkF4WGaRF2V4Vpc6VJ7/VCFUSp2LgpHbYBuPYSVGDFx
         800+bEyzHQ72IS4QgpyrKWhSi8sHHLbeogu+Ks99eIuMu+P1V/ijxeh6Q7tKSdUJtdTa
         EyCsI65NJpxAMaWjfS4x93NsMa6wyB7PbCtBsqCs59k2JHVkMfcry4Jf3XOHniguafpV
         KEQgyx/8r2cY4yStdXPgZJJFGxO/mAcusX77vNejhthHkThRJcsgFYHxokiKdDIH1H//
         W4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430593; x=1795035393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RWGPS5KCwq3L9cW50zOJQer3a1hvbPza6g0viy0ickQ=;
        b=kDfpS2iQOMaiLtLhxr9L8uObetjqcF5V3j7luXZRFJJd7Ve7evpLGNtb0JPhXbBZcX
         zz+lyXUJoMoripA1B4bmuiGdohRh+Ki+2qdEDqZBxvDy+MFhj9fmlGaFg6iylcrI5LZz
         kZcxovdgl9ZA/DNJbfJg73rWgecmpxHOcC+kGk6/vhJ5NTP6meOGFmKu9a4Q6kUCmg45
         9aud9ZrHNTCPqQY6YNP2hK3LolqvYj0XxkN8b1k7DZofnE+qccqZ7WHGZrugxoMHmRg3
         xXeK7aHkjGYttCb3G6Pc8FAPOaGX2H2g3VRkTUFQe2ZoIxPTkkah2wHhx/z99bdjJkmz
         LxjA==
X-Forwarded-Encrypted: i=1; AL+hErHwu9UikNmZW79vV+AsQIA+wz54QuPA0cWTN00HgBzwf7x2f/h5/nQb7Xu8ndNBQHOYobIxJWC++g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/BTWshlGZKXg65hZeyC2wfoFsN6Hyv3VFo41Bi9x6f0Rpga9hS
	Xu2Ze3mH9WcYaerNA5xjfVLqPinr5bfIygjTNwPN8PqszUmEsqWmoNSXPxr6oXzC
X-Gm-Gg: AYBFou1JpqC1l1hl0QABHMFUpjU9PrjyjlE0YPCJwIvwwvUgmmZog4ZBGTtEViKlDb5
	ouCeG2UX1s5OIIFeRPKflNlPvgEnJX8km801U/agqyfKbLfcjWDnQuqNrXn4iE8FnG5Kou5qk3L
	BXoC2AZpqjW15hBsU49uqiuCjRAGygiLhvfEryPjplNRlb7bsJp29GwTGs4rxHKLTbloT92ThK+
	bXNy52+h56DTEaUfOs45KmxlQMjUP7nxVNbcN5VL46QH+5cmSXAtdSY5228HwnXZpHC63EXQy4z
	d4w9kQEDFP/QxxJ3GR2mmhClZ8nB/Q12ZrS7/FIvqW/OHUJVRv1fZ/XwN2uqNNJ5+XUchBqWF++
	ShUK0jLbbIfN8Ru2OOBzD+4VF4ybHMmeqXOCCegOwffOVNGCfcM0UU6o+qwesW9a8XN2OXjwvwe
	OQyjlSosiwueOKjCP8b0d+yoSZng5JP9LEZWiqLyX4AePwzD0BBdZFt2hFhtk5EbpLJldDYrybw
	cTe0JW07X5FsyZk++fKLhaS/cr62p4eMJClA0MKXJv+8C+QIcKWzaUJaLyFEm3lwEcNcpfZJG4a
	TJ8WedFW/XNT97rzicBLqTCAliS7tg==
X-Received: by 2002:a05:6808:2507:b0:4f6:6041:f0a2 with SMTP id 5614622812f47-56b96def35emr3452223b6e.27.1794430592642;
        Wed, 11 Nov 2026 12:56:32 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm6564231b6e.11.2026.11.11.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:56:32 -0800 (PST)
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
Subject: [PATCH V4 1/7] power: supply: rk817-charger: correct spelling of coulomb
Date: Wed, 11 Nov 2026 14:56:21 -0600
Message-ID: <20261111205627.56652-2-macroalpha82@gmail.com>
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

