Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630389;
	b=PwGMyzJUX0uEK0zdPn3co2MPjwqNC3BUQQ5PXTJFqKHDuH0lTQ3/sN9ZL2guKppUMW4z
	 3sOq7+Qb96M96P3jVqas3vtgSSUzO0CGrLD4VhNdmfCYWjPtSlN1Oj3gWPsqcwbNQcSC3
	 te1jAPbDGbx64DpmsTAtUOqzM78eDLTUraCPx44GAaivLDIT+OhZfYts019cIrlFqr1ya
	 mqT/sIMazg1bEWdftFLRc1w/sgaP9nZ8KsmO7b3P45+On3nyAjiVCf/MvWzE7JGn5t3w3
	 21ItVWQXroDOHCCAyTbFw9ucdavenAokvIraDbzqJtGs2qC5lTkgAathDcVWhy6etkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=no08TYy9z5N15Gfih7t9dZs8POOT+RS2X8Q3gds+d0o=;
	b=fmCPGzv5etk6ralwWexjurffdZsW4m9hCV/1ompnXnpaLgzfi3lB2/ZtvPebqg5zABRJ
	 OnTAB4kAdD1oLZAQtTbHlkzHURPMv3Kvnre9pokavkP6bXfKGG/YLW17xLMtapLOYjZ4I
	 X/O+AtBod9YtQCCENflzvQBuJTjksZNNo4VPnIgc5TEXmg0rZsI3hmPoM7B7FVsbZS97i
	 H68/1QsCtXiItrnNMkiltZ+l/qRy3Kwdd/QXsHexJumG4k+SSRsm3Y33DfxyWF1iP63v1
	 tjLtOAEeZyY/xS59/Hu2Hg0uzMrtPBwDxaqg3PSXosUjPTXP73OISl0c1GxP/wg1zaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoFSztjt;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C44606A596
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 14:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31C44606A596
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoFSztjt
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6f5a0893610so2572200eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630388; x=1794235188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=no08TYy9z5N15Gfih7t9dZs8POOT+RS2X8Q3gds+d0o=;
        b=qoFSztjtckOxmybHvQh6V8Dy5/5vb5jbuK1WDtrs69PHfpldxSBHz2n8SX7bXLr7qZ
         fVOfYdaIz87RjuHUvIyb/OjV7CNZoAWGOrehX6ofsfLfjc/IPRCH3sp7QYhWxCd0CHYd
         ZapK3oT7QJBviYaNOlByyUSNik2ez3CfBfCOiKihH/PFzvL6bbezA1V4t55PdFSRBsII
         6mXlw1n2wD1lp2zOCEpELiPa88M7CJ9+3R9OWzJ+LvKNJ7HRRmYTlKUWb+hRyB1EPgXI
         AecGWlwPHv4UuZUewLQ8SmoKsZAQ0mJ3p4jKJZEZ1iuiS4LpQhJmf7iMHscy5jL10hIe
         EoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630388; x=1794235188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=no08TYy9z5N15Gfih7t9dZs8POOT+RS2X8Q3gds+d0o=;
        b=Y06V8Sq94h5gl2ovxSoixAiO+9a+T/n9IXKefSurOPJ37SsOeFa9O/wUB9RPbrz6sE
         iC2ICEXcVXOW5FtR+upgVGqAsd5zIg1TUlS/47VaTT/UvfLX+je3rq5Dk4pA2NC50Ymb
         5DU52ML+d3vUqMn1H0aBMIGwajO67fqJDzuamY79nNKS6seUVhv3P9wQxQ8/4nf/0dOE
         8piXqDtAc2Ct8O+82C2OzkfhbJzDszTWV+8AiS/TlmvYUfS0mJWZA1wNBpiVWHecP9Vp
         V2a7uI5UnwExhn5RykBJs6omJ5MFJGhOfMFNL+00zsEc3FP+8Zuxv+Z74Z7D1fyfE3DF
         PdRw==
X-Gm-Message-State: AFq9FYIy1C81ezqzrZnaM8x9pXq0ZZ6GuOv+9yi01DEbFomcrgCi9L+Z
	pPGyQdBMKVq9aYSTX0RJcj025uhmTR7aCUxS6Ao5ALGretCn0D7kZ4YL
X-Gm-Gg: AYBFou06Z56kdVK2nDmRxSWrcNx8wkfkGZXQsxDtyD4h6bWkYDoCouQX8T53f4ylQBG
	0wKat78E+B9gAMo1mZqBv9njXbHqJx4MFTeNyXTd6bi68pWhOoSB91gwwWPRy9sFNhr0vV5/4H0
	IAkpyucaFiGtbmRKNKrYfdAyS5EvjkRQsk3/QSFipgqxNk8CCL32TEWL4Q5VoSgZZngw9eLhUGc
	05c3Uq13YDJ7zIZJ4I+SwW7SGpmeWFnwnDZ79jo01CDSzdcRkyxNW6G21J+zUD5qa2o5YUVCuNp
	gK+x/sp4XfiYdJwlvp/A9wXkxDt39OfoPm5bZL9NAQzewSC8597w3DcdR5viDK4gfVKgTXJAseh
	htAk820ZilP3UOCWbnIEhQeUWGONZq0smzUpuXMUZEsEnY9hWnlVdGRl1cYaVI5qQcJfqg4P1Ab
	mtv/Skch6bEetk6ZQN7PAV65YgjP+kn63p1XFVmGgZV3aJAoeklHb1w3gDH6dstaPYm/AngmBQZ
	nXijlfn34H6UPlSrycjr06rU6V3OsNqeTqQl2PiTj3QmwQge8htrSKJwGbGmSPwWST3nmW39cS9
	ZocowIu1hzzzcMjtgaRQk3YzeQ1HJQ==
X-Received: by 2002:a05:6820:1343:b0:6f9:59ee:cfb7 with SMTP id 006d021491bc7-714f29880c0mr5282986eaf.23.1793630388011;
        Mon, 02 Nov 2026 06:39:48 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b875sm9516327a34.5.2026.11.02.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:39:47 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jacob Cook <jacobmcook1984@gmail.com>
Subject: [PATCH V2 1/4] power: supply: rk817-charger: Fix NVRAM SoC Value
Date: Mon,  2 Nov 2026 08:39:39 -0600
Message-ID: <20261102143942.305293-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102143942.305293-1-macroalpha82@gmail.com>
References: <20261102143942.305293-1-macroalpha82@gmail.com>
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

The NVRAM value is stored as a value between 0 (0%) and 100000 (100%),
but the bounds checking checks and truncates with a max of 10000,
causing a value of 100% to get read as 10%.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Suggested-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 5558b182a1a6..86da0462fb59 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -728,7 +728,7 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 
 	/*
 	 * Read the nvram for state of charge. Sanity check for values greater
-	 * than 100 (10000) or less than 0, because other things (BSP kernels,
+	 * than 100 (100000) or less than 0, because other things (BSP kernels,
 	 * U-Boot, or even i2cset) can write to this register. If the value is
 	 * off it should get corrected automatically when the voltage drops to
 	 * the min (soc is 0) or when the battery is full (soc is 100).
@@ -738,8 +738,8 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 	if (ret < 0)
 		return ret;
 	charger->soc = get_unaligned_le24(bulk_reg);
-	if (charger->soc > 10000)
-		charger->soc = 10000;
+	if (charger->soc > 100000)
+		charger->soc = 100000;
 	if (charger->soc < 0)
 		charger->soc = 0;
 
-- 
2.53.0

