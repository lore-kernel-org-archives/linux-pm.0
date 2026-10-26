Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030495;
	b=4pqjZ5u8ITqCko7PDsNqvkA+XlaRVoD0h642F7d/iMQSN6EpVbOLfO3qwA3zHbROC2XR
	 8wk5MTwINTIcQPLDIdAnEm91pDo5dAIue5nSObCOZCHe9A8phSkD3HV4x1P0tD9S5hJ6B
	 pmYLqiMNPeR/uIdiRduyIg7Qudmh/34DobxECeRVR0CmMA+TKEJWDCyO26mE2Y4cZob7P
	 Ebau/ZvQ4zK1ctVwGQpmLOXER52ImhQ2wdVOQ544eolS0dNCPbcS/s2a3RQHJV0hJSB4X
	 cc92+xKtHPgOvhJlGjVJble7A+BLPqBXcbDej7khVV2g9ACdZRAkzwEkwLFBg8h+hUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uVxW16mpXXGmdLmnlhGkMZ8vb/cT1vcxPz/t91VG3GA=;
	b=bzBtttXTkhUwXQarFZzMdTZasMfa4phEAgQ0LCZ30glA57d1WPLrVGA5kvTS+z6tMVxp
	 LRfSXciy25tghzsFfdYmERr/0gl0sAOOCrz2+MlI2l1i/sjqpNtx01pzTrE4pUZc4HBFJ
	 sTNYIb7t+Ks7F2ZlxI8kjl/j0isLm5VniKQx18MShRquj5d5TGRgK87askKn7RjLrVefY
	 1C1dZAw0NvB4aZo/Id4ggwLfSbkooTyAqlGVhFNJ2lzO1kHh0KNA7402W8cBp1MkW7vgI
	 N52P5zmkuZznoi7MoFZBUruAAerD+O5K5rxP51e451RO3eUXKj3KGYhk+ruDP4MRL8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dKuwiBtA;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA16606A330
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA16606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dKuwiBtA
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4326803b54so167020866b.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030493; x=1793635293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVxW16mpXXGmdLmnlhGkMZ8vb/cT1vcxPz/t91VG3GA=;
        b=dKuwiBtAhp7V4crTsQUnIcckkqMCIAl7G9TcxSolZPJvcCLHncBZj+KrSLJ/L2OQCw
         5TZD7o5PrIH4mE4SI5e94fqSF7UyBgG7fjGByocApjIkeIYJXkhz5cM490QzJKoVQAk6
         UTGoEtGTisqVCLdN+2mBOJ0tSIFwvtQbzb0VtgCqKTv5IzxR3oREk1K+4MwK9uVf2Yp7
         DDmIoXeKXRNsedlkqmDrIyupwlUNiWN77QVDJZ/VNsHR1tAeps7RgnTETJAMgDEm7msq
         39DiQQ5PIAW3fYuXr/fz2FTHB9nTNyVMA/dXysazNcgi6ZVvriFeHyju1EfY+jSkl8mb
         paqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030493; x=1793635293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVxW16mpXXGmdLmnlhGkMZ8vb/cT1vcxPz/t91VG3GA=;
        b=DQpqrPpjegv8wZVgvysWsk2DmN9SBZkAKlZU0kXpSoXzvq/N0fDaQbo5NnIEFqSww3
         4JcXguzbVSST4NC0F5r2KSNneRqQHQeSkQvP5PXluRXmLZxVnuKm7yQ0XuKE6jVmA+EG
         xILGJI6Z4VNTKrRS+d3apWwYbSUB9cyUMkxEuDkJY8i/p2KYuOs0KM2l+HQ31icnzzOj
         brCgx7qQJ/pgmLXpV0Nf813FxRd5Z1cEw3kctNJQ+eklLWLGVCI7UyF0Fw+qzKIHBy9M
         8DEE8Czshj+Q10mwHWY7LoZuAQbzixxUnXiCyH2ghAeyuHgTZF/RpOywuRRPi3FUlrzS
         f0Ag==
X-Forwarded-Encrypted: i=1; AKwUvBxdTq2E0SIp5J5WeCX6oHuIWb4862zZ16xunwahgyAqSYep3idJXIyJRuEsm/yi2wJFJH1UoZHHUA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvsiqcrttXwKB1jtl3QIvFaUit85vMZUGPZ2E7zq9r2rq/9gCK
	j+QX9/2w8f6+bTJXW+FZlBhcSV5K0mLtIKB808DSLrght/yFmKZcaVP0PTSM51QYHig=
X-Gm-Gg: AYBFou24+4Avi6VBdor+JnuxR4uZkgAVVZ2LRl1XGae8jETThiwQzF9dxXJgwCe1tS9
	/mYpi/HsHhJLk60Pjb27RlQLvqwHixsyAteq/evBMyFQSKvqK95Z2gyC230dQCuhTFbz5c4OKja
	0jynjpHOeFEshd+ndJt4v/UGKhkxkl7vJWUH2/nfc58dav3ntyNckYidQtOFUDMqWv3DBlEWJ7U
	8vsDQFYV6K7RXqXryDfnlCXqRla74aC/scM9T5WO7GA8PshsR+tj3xXHKRLzdBFKAtBgrPyxSE8
	q3loMZcBdVYmpzLBjr/lKfcPmkQC2R2+tvooL5upP3BTBsfGUBRc1091n4dg8Az/+h6rVGoJw97
	rX4RaUL9agEFtd/lhi2yg1Yh7MgSjSBMXb/31ptiPiwG96qjf7JI0hFIECuqMZ2kcMylaEyLUVv
	SUwzD0sMVbpTMWp/U/Bi7iZ2BaVAEZ12P1pM1ag49CAMCx5POWLfgFyLqIjtSq7HX8t8Jb1ZK8L
	dZZ0Tz0+vX0O49jmCjaR3jOAnmyltGrT4UtZ9pECb703FVzFcNdRBKZ+5rMZ58cwvbw2u2dO3lb
	7QIMq/ibhqbIADrLxb9lPqB3dBTGbzsrEwP/
X-Received: by 2002:a17:907:e93:b0:c46:ca2b:84bd with SMTP id a640c23a62f3a-c46ca2b8958mr640208666b.30.1793030493521;
        Mon, 26 Oct 2026 09:01:33 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:32 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:30 +0000
Subject: [PATCH 13/15] thermal/drivers/samsung: acpm-tmu: Disable regmap
 locking for MMIO INTPEND reads
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
Message-Id: <20261026-acpm-tmu-fixes-v1-13-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=900;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=n9oiBAiToV2j4imluH0Dini5o5jk9l5YDFDeRG4d+9Q=;
 b=7egW4kVv7aVKyCi0S0idVb5FBWfiO3hOv7yz0j+W9TmYVCqptWD0mnRVo2uyEHV17etYiyvBh
 TCUuH84NV5KD7i/ZAuGk68LaJMqn+KLQISgMVlqRMXgTK286SThIUKP
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The regmap in acpm-tmu is only used for full-width 32-bit relaxed MMIO
reads of the INTPEND registers, with no read-modify-write operations or
regmap cache. Set .disable_locking = true in gs101_regmap_config to
avoid unnecessary regmap lock overhead on every INTPEND register read.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/acpm-tmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 2324efcffb84..fd491b4f305d 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -127,6 +127,7 @@ static const struct regmap_config gs101_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.use_relaxed_mmio = true,
+	.disable_locking = true,
 	.max_register = GS101_REG_INTPEND(15),
 };
 

-- 
2.56.0.257.gf7497c7d27-goog

