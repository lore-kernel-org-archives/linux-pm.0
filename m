Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A6318EEF
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111503; cv=none; b=Im8xbvtPh9ndiSV3Z6jKV3WCBnoFc6m11tIW874gf5orL/5zBEwb4JF31B01Bkn51yri4eHEtrxZfmP+DMuurLMD5R2L2ffQtYEAK9xs2gCdvecon7OX43ykbO5GytZyrMj4QJslQa2QjM5+OE/rVnYePe4KDo67fT/oNguRgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111503; c=relaxed/simple;
	bh=lSJZAVOIGRRjZDHP74fEsn8JPurwxlVbyJ+3JsP+JrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rX9HpMRq4OrLhUfs7A8f1oetJYrFLz3auTGAoHJSBTB7p7A5L7n7o2Rx+Bz4sEKc/USLBTLvtHTOB72RNPB2MpAGaLRDSOHnSAvWot5pDI8G7X/HoE9iB6OEkn/02WbnxpX4GIPr2nAhZm2niCgqjEfl5V4/97dHLjqQp1gEgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eudkCm8O; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eudkCm8O"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8fd976e90cso108283766b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111500; x=1772716300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okHhXV7tE4rEJ4xtM8jTlPpMycDWeme/AEi2JC9Gktg=;
        b=eudkCm8OhhHcko4F2htjd0SaU6gNs5UK9zc9irI0FM1DV7AZNIiHreOdw8B2p3cogW
         9HlQfudTVP3xkYOSmg7hzaPK37mHfUARZlq7Jg5Kadr1gOnX3KbyPIjdVd8YlQjfcp85
         +1wI5+qsao0+qExsLFAEehwbUruTHAGx+DVjq5hf5tZjrUCAzyy25+jSduG5U3R+f/kB
         cNzuazjEtnRAgquJa7ToSUmrUV6kEhOrZrrisjmDBK/XygH50MhCwiXtADISMmn+SgI7
         wDQMRk9uXxdxsYYE3lnwMsyJ1rEj/R2SQMO+vJGytGShplSLFzbhECyteRT105LupMaY
         LLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111500; x=1772716300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=okHhXV7tE4rEJ4xtM8jTlPpMycDWeme/AEi2JC9Gktg=;
        b=tdsK2umuVKyHU1p2MnIlspaWfVgE8D5c8vNotTD6DIORKx8IiuTt+7dP8yHUjGysda
         0VtW+QbV3jDaM3gi38EYRrGIGrjweBAGaDihiX2T13Bh1lIQZ1spxmII8KeCk25Ye4GR
         BTURnbC5FyTWxM/f7FRTuksAoD5+YiEoygivFdlxyKgfH5wkZ+4nviNRz3BjJI7yH/po
         IW7GQgu/CSZifROOwZtwb1cVswYNF4DZCVo69E+J+tff8Diwx8BkBSY7oLAfDfTFizRN
         W/Xt+GUtqeqZ9lcTftqV5JlQPE4CDLg4yM8jaYnM7QVYsFSMNzEjC00F4aGREUw33B6P
         AK9w==
X-Forwarded-Encrypted: i=1; AJvYcCVgIXewr7WrQg+46CWp9cFgIj4u965p8rTfa14PzfrvU9+UuuO/XbFGBuwcJXA5GoOjh0iSbtvM4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpYwKVFpr3f+lmDuDa1oqJsV+t1UyF5olU5rmYCrrGYS62+EG
	AjbNfN5h2F/q3X48zyyVF8tCwciQbxOByCb8c69ZmjA5fxhc2Q86862TRlwsz6p1TPQ=
X-Gm-Gg: ATEYQzzzozLVOoDtjpsr8ez/WJ2F8PruVkXO8L7aKw0YQabbmAlKa7zEVHNIh7GSgYS
	18+7oSR9sGWiMez0n+xiw5408nKcNXlFyQb/VPU3pcGgjxhdTGy5fU1Qugv6S2cnhR99lzNc7Gs
	EZ0ChmNzSCCh6ZTAhP070zcQUS9s5hb2BIu2AiP55kkn+uazD6bqD7EWt7zjI+lTSEMGJPZUALT
	QDWE9pQY8F4v1GGKQLWO8Yl7QC+3ofuNEAeNQkGBE/Mw82PbMl7ke7Z59lmqHg9P5RAM9dAzqpe
	72Mnx2b7RET/uMKVI7Fv6DB2Y6kMMlQdk9vZ5TWIRuauFH5UJlKt9TVZ2GwK5YxqjIkqOzYwiRF
	RPS+ZyGlxvVCbkac32H3h2w1vUBUQHlGIX5aEyVzZ/A8NMj0QCkEeElfEVDPmXoxRdgyi/J2KMF
	cG5AatIghNTrx8eXbhlrm3tkO+VYRparEiZXS9kYIxe9gh3ToJhI0QO87PZrktB/v33J4ko52Vk
	FaHoT33vS3vSPw8bQ==
X-Received: by 2002:a17:907:3d92:b0:b8f:7014:8438 with SMTP id a640c23a62f3a-b908194a87cmr1253974466b.7.1772111499667;
        Thu, 26 Feb 2026 05:11:39 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:39 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:38 +0000
Subject: [PATCH 04/11] power: supply: max17042: fix a comment typo (then ->
 than)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-4-ff0a08a70a9f@linaro.org>
References: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
In-Reply-To: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

Fix this trivial typo where than should be used instead of then.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index acea176101fa..07759d4fdc37 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -131,7 +131,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 	 * FullCAP to match RepCap when it detects end of charging.
 	 *
 	 * When this cycle the battery gets charged to a higher (calculated)
-	 * capacity then the previous cycle then FullCAP will get updated
+	 * capacity than the previous cycle then FullCAP will get updated
 	 * continuously once end-of-charge detection kicks in, so allow the
 	 * 2 to differ a bit.
 	 */

-- 
2.53.0.414.gf7e9f6c205-goog

