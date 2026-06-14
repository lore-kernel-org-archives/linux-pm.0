Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81E23D2B1
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781396120; cv=none; b=h2J/qAZ2g+nUxAchvJtOvEuZVs2iHdu/5RC+eVA/IqNNUzJ80pUt1rLqhgG7revXRBoQdzHwj6mFzi8UNwK64InY8s06CPPLl7QJDB/AqKAMffoBzSMvrhaqcM7GDGhnW3uD871PICyMyoxE5VoZlv818O89LIONli2bbGnSWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781396120; c=relaxed/simple;
	bh=Pj+C8pUwwWVRJegU5jsK8XKHgnSgNejqKj/GqWErzXA=;
	h=Message-ID:From:Date:Subject:To:Cc; b=Yi84j6Mr5xbq16+w2FATZ269LY7BGFT1eJSQKpaP5A842kxxH3rQvXpxsWkabgIMumsHmmRx+4ydneNo4SrSds96eEjt4cv4bsxklpBycJlPYVaqOg5qVqKGAnz3wfPTZi9PvN+ukcIIljPGFksFBbO5Ly1AuaTaNXbwFtkV92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS6H67dJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS6H67dJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf18c30bb2so16665955ad.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 17:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781396119; x=1782000919; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HX3ZYLkpoP4OKdcJqiss02RhOC7aeNFTtkhTsIn3N8=;
        b=BS6H67dJSdUr3Q/83vOMAGDSjN4Y7qcSm4B86mb8wAbXbkhLeipWm9qrpDa2V3doB4
         q/vdczjK/hkP6h++VeTrWPmJK+05+AsEQQymn/jvuZ3rbVwYI8Rf/9Fqx5GWaaCT17OU
         80ZApjVNQ588oSOS1PSl9jo3CuZaFPaIyBX6H0vbsqNWeWLnkcVPYM8AaSlK8U1KsXZk
         3V3LuO3AomDkwTfjfivGySz5akilRhPbU8+Cs8Nl4u6x0nJnIFk7lFRxUG4ItbhqQe0o
         hCAKneTPt1DETQVpvX50zvR40p9f4heWV3U4ywtIlb/2G3AI4bHIim/GMf6qr/cxQpHf
         PCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781396119; x=1782000919;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HX3ZYLkpoP4OKdcJqiss02RhOC7aeNFTtkhTsIn3N8=;
        b=BVuC4UkQ0bmEGQooMFIkDnTNCyMg4jVaFGxoecMFKugEE5LjoM8Hhnu44TBAXk3ZB/
         YIfQcmXBNTIXkfy3xLhr7j5nYML3PlnRCAHr4947N1dq463kWuzjskO31t+i9yGFrJy4
         wMyoNt2DTSf2+TH8SCbHgktjavnlDawPh0d8ScMp56Y2OskOswGv3mTgNlC91eVnhNtx
         /L5hYbuSNGdBV6ltL/SiMN3J0e/RE7tVZCFyga2pwC+HsKukLjDeQkAsaiEI/7CPrijK
         m56d9WWplp5XODU9cPZ8q5OjWjCIvYlk/o56otV3AgoXMr9zmmuOWR7hiAswF/duD/Z7
         hZWg==
X-Gm-Message-State: AOJu0Yx1M2UBXPqBeT7Wyw53dofGsjuMjgv+3S+dfJq9nXWy032Fv5Su
	hil+jU9BSBJ8+kNN4+58GsxKOVu7t9hQXcuTtZoVk9pY2Nod8VYJcbYgFxpY7vychlg=
X-Gm-Gg: Acq92OEzaz0VpL85bk7vWh9StDlJx6T6N6dMiddHBUvOnwKn2ooa+7UYLQ1PTmGPOWa
	Eo1mdelLdBLbH9mVK5VEJsimC2603JpOqHLJwNrYFgCs5BCGDf9Q5JOd4d/IADNoGbPbvD0AYv7
	LUKiLR7NUVCz4iVcdUtQmsrCypSzKtSWlkltA4ahb/h059U/6jlz4bo2DjcuJ4aJhhowGpl29na
	UgclJFOXfOTqkPEXwNe5xFq24KHRiqe0SMRIpYW0gmiwsYb+Df/2Di5lRfJCqYkcJngfjD0AXBV
	o78meEvfdVMZ36eU9zlzWs2W7w9mtYuAAtrWH42PQ/3p9qG9evNX0qqB44rWIbqLAlG1b+jJT6e
	Neo3D04FBIatgLH+s+7+h00lYDZw2hwrSYpRTQ+3rvpsYi4NozQKrKBKhEBH0hJL3wwW0AY9wtv
	JAU0mEuZaDuznrjvIz
X-Received: by 2002:a17:902:f610:b0:2c1:88a1:983c with SMTP id d9443c01a7336-2c6642a7bafmr56205255ad.28.1781396119131;
        Sat, 13 Jun 2026 17:15:19 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4330782b2sm63552385ad.67.2026.06.13.17.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 17:15:18 -0700 (PDT)
Message-ID: <6a2df296.6b2684af.263065.8200@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sun, 14 Jun 2026 08:14:11 +0800
Subject: [PATCH] thermal/drivers/airoha: Fix low trip clamp using wrong
 variable
To: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Christian Marangi <ansuelsmth@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

In airoha_thermal_set_trips(), the low trip validation incorrectly
clamps 'high' instead of 'low':

  low = clamp_t(int, high, RAW_TO_TEMP(priv, 0), ...);

This causes TEMPOFFSETL to receive the clamped high-temperature value
instead of the requested low-temperature value, making the low-temperature
alert threshold identical to the high-temperature threshold. As a result,
low-temperature interrupts can never fire independently.

Fix by replacing 'high' with 'low' in the clamp expression, matching
the symmetric pattern used for the high trip on line 264.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
Signed-off-by: Wayen <win847@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88..439aa011b7 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -273,7 +273,7 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 
 	if (low != -INT_MAX) {
 		/* Validate low and clamp it to a supported value */
-		low = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
+		low = clamp_t(int, low, RAW_TO_TEMP(priv, 0),
 			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
 
 		/* We offset the low temp of 1°C to trigger correct event */
-- 
2.51.0


