Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243414218B0
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971840; cv=none; b=ZB1MA0qE6G0Ufl3OBJ0pQOtNtYh7wgp+3ZMRG3KOUErN7tqPF/X5xJQFBrq68OwdRrRBXv1oZxcGvqhz3a23v5OFo83jIVFZxhFp9MyAQEV9kC04riWD2KnZ9IDPIlzP9l3LLw5EmJeZ1A/Q/XMU36g87x1mKTZcNBhiswMWjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971840; c=relaxed/simple;
	bh=Vj+thyx6im8c/60dw5piAk8vyroKtJcY1a74UdrGYxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwUw4Klfrk6u7zl3LQKAGDYp8ji8f3mXl+oSyeO9Xu0258E/QeaTiyTyD95IOvOprCjFS8rpStcyhIWUPT2/6P7r/3rRWTnBpvqMAYNF20dDZmvW7m+/m7WQpPYp/oF4u4tv7eaO4SMtaJmYmZlV2zOg3XhCFjKuzXEwm2qOrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=diS2wWQd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="diS2wWQd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso5075e9.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971837; x=1775576637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=diS2wWQdXlR0qqXVtr2OCyu/PeY5JO0EPhP/jxJl6b7pwAtOVf3K/IwehqpR8R/0s1
         7nrjoz+hLic/U8601qU5LL5dbJ54qS2lqbRGIXhmXBIabpQY7yHwcNvIQ9lwJHalCUny
         7bh1iawzoEuSuwSuLLwPoZ32CdXkb3A7HXQ1JbIkK5+wHBmyYpTV3ebxd6jZmSzN4uQE
         qu585xA5JD2f7mGVxqK70cGB5ct+wRnmDU16c0ZGE4kl12bn3VcuWsBimUt9GvE4oAsM
         nDwnRIN43a//CElr17L0MWhe6AmsLRv595KrPP5nM6cQmNVBmLbeHjoZwMMWYEcfFJD3
         +0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971837; x=1775576637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=Fyv5Pp8vl2W/Wy5bivubUP0xcZojMjuJ3DDaqVNmgwZFgrxCuVC2ZadveKWHe5HQ3d
         BA8tLy3ewnB2XfIaxS/UzQvTcPu4TRPYDwxFTIu4/ivkmO0N1sbI4Xdiygb12bieKBVf
         fxFCrPj/mYEmXFDo91MCPcOdPUIleyOSdhEpB9KYotCivYmPTJ19wDohqgVpnIugwmHV
         uX8fCszG/C70LG3XYCBq9OsJozsTq8uESDb9N+iHn9v1kq6kV6OU0aRENHZnhlCqguQI
         pvXLNx2VqvJe28JIHYHeOxjpmee4wr4o6O6q8t0nt6wumhJ2d4fLSMJf2c6Sp80Z5Wp3
         xhbA==
X-Forwarded-Encrypted: i=1; AJvYcCXbTy0kgfs2IwmaH7ePULrA1JDiNDNqKHRonJOoFrEhsfvl8RzLsrIgRsayF2mtTCxQ/rd9U5xpEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Fpv6w95EINuLWUoqPjih+XDh5+k8/AmOmcMX3T+dufdEZkCE
	KEQY7KSK/Q3VTgScsjO1a3F5d2Byz1ds1Uep/K5otrj8m5DtgsXqaoPbwysW00+QYtM=
X-Gm-Gg: ATEYQzx24Ev25siuRM4I2L+Q5j6PDhRAOjI6pTxmlZilh/ATPMCYNJco/xwyObZlEwX
	3+NKxInSKPjXVQCcsULmMzECczaG7GT0QjIMIQ+GrjZj38G5o9XTvjcmayZyHqFTAh9W6bA4PSU
	A4mnob5f8A6ie8Excutg0TR2gTQPV5liBd/ezZmGkl05SBfXK91ywjgcPs1A31ljlBdN0AZVIwe
	fVmqB3fPHjJTaDYzJka8xtxC+stbpvvEDY5m+GJFH1JMerH1pgrWcc+u2IwJtCf9z/KYbZydNrl
	elM+zI8xzOlQLOCBbuOiVumuAd16dQv5TGRgUDN4ECNqxLi+zB/OAQquIV/qZV6qZHVg3LPivcZ
	GuR18+BwBVnLHHAadP7w1cJyMP23GZZhQrS5ga570oNsvfpq16pc0JoHhM9H4qEu4/So+hYHipc
	opgUEBJ6l9q8JVlSI/itz4keBw9hFovPLsSOaCy1m51+IWzs+G4QIq81MT2cS8gTvCuyYfzm9Xr
	U9RRg==
X-Received: by 2002:a05:600c:1e0d:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488783ae683mr69431825e9.13.1774971837562;
        Tue, 31 Mar 2026 08:43:57 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:43:57 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:41 +0400
Subject: [PATCH v6 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-4-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Vj+thyx6im8c/60dw5piAk8vyroKtJcY1a74UdrGYxA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr1e2Xt63Dd3w51LWyon7VGuF8lcub6+W6nq06uPJ
 a0ZGRsiOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZhqYUeG/1GrrB2nL/uzzLOCwXJmM+f93I5qw+dTwxNuBL7+u8/u9nFGhuVFBoU
 3N86w3/fv+TLJavmg/A+iM3qPyC85ophdf+i5DDcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The bindings describe the OTG enable GPIO as optional, but the driver
gets upset if it's not provided in the device tree.

Make the driver accept the absence of the GPIO, and just use register
writes to handle OTG mode in that case, skipping the error message for
-ENOENT.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 674dae6109e9..0bb58ab4b8d4 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -126,6 +126,12 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 	of_node_put(subchild);
 
 	if (IS_ERR(pdata->otg_en_gpio)) {
+		if (PTR_ERR(pdata->otg_en_gpio) == -ENOENT) {
+			/* No GPIO, will only use register writes for OTG */
+			pdata->otg_en_gpio = NULL;
+			return;
+		}
+
 		dev_err(&pdev->dev, "Error getting enable gpio: %ld\n",
 			PTR_ERR(pdata->otg_en_gpio));
 		return;

-- 
2.52.0

