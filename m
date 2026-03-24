Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941C3F0764
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352322; cv=none; b=DhVirAW1D6E2cnXktHAoVxGOFLRoqhhniJJc4nODPMRfdUiY24Nyl87KbsNFIFD/MgcGXTcfZCvsYwspgq2K759+G6qNx/I4z5oawGuizyPotNhPkCaC9ym96Oc5PaKUKDgGH+imCxhaJTaj9Cv/xVAPeavhkXs3cATH1dwE8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352322; c=relaxed/simple;
	bh=HoUkMd3aj0s9m5BRWarIKv4NrOIfktIuX7B1xZTtvpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSqiYiuuh4ynKwDklbVffUxQq+IaG9ji3K3MnlrIYhdPN/L7TI9mLxcXrNvgXXxXcktj+L18BzJc3VyNG5fLp9fdShrBW42xWM91doDe8KRRYs4KOiGt/DclHCiKTyX/J9Fr+SkPtjHJ6hgWZsBedFXUB/cJrw4bpJErteNVvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=pjZgSKYz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="pjZgSKYz"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso8801825e9.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352319; x=1774957119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv4k2NFngBv6AeWEv4O9srLSbI6EPVNmV51Qs0A5klE=;
        b=pjZgSKYzVnh+C4v0m/ChASHalFS64W+sGcD8ZcT5YHHdMOhYrWBYiytW9ZoNCTVYGq
         0kVd4cpW1kP7cYeoqCtb+4UBrV9sJP3u6Tybab8dowIh/AsFAJxWNg62zC7JWgw/b5sv
         xBef/PdBhbYXb8UsCc55Qq2Qfet/E3BBxybh0NRGnpNZsSxntihHjYZt3UsyaAR2CNW9
         5+rL5oYnZkdZNi20cnIOCNlxbQQjRdSMxHCFoeZ+d/sX4VTgczUpjo0/m7QNskqX3J2r
         MsqzPvCS+i6HMu/XPbrzHjenQ9UVpw/FbIi780aLeVKY6OL+msLcVMYEzPzadPVyq+jk
         YdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352319; x=1774957119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jv4k2NFngBv6AeWEv4O9srLSbI6EPVNmV51Qs0A5klE=;
        b=YBugceMVMv+A4XxYs+OEQ0ctR0XbwSMWeSaGVSUFi7Tc+MrHnbQ1BwBLhwZhR1cRHA
         Wq7yDjxxwdTD+mMoDXmTQsMYmXcqAeMjfZ+OzMJ/hViQ6zEPnSVWtc26e9vDxp0gOL16
         OKo9SrcdBA20nmYzrzCH1xvafr9JzBE3H+TPvwvDov5jhCKSmrKbUENnR71lheS0MTy/
         +9e/3n/OcusRaSUL+kLkewAXarIWpyKuzPLp/utqrsxo++rfg5e/jqnzL8evBdiLdDEP
         OUlfdbTfys/tLt/jHdIH7o7c7lYK1IJDLprL1naKjk6uN2FNNm/Vqs2RqUqvcp5ECydZ
         pHww==
X-Forwarded-Encrypted: i=1; AJvYcCVZnLg8dFim/BIJPjjwPqj4miB4Kl4o8OoOorqf4nf6ANZDSZ0O6mgB9Ljdt7MaOs0ppNUc3pfJIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpV4WeXZWimL2G5R7kRBNucOfMedWQ6HyA1B4lK3edD5l1vPrY
	5Q5g2XYnML4lO5O0rvktRK9fph6Jr/afhAucmhJ6sQYFK5SJ98tjOdaUSxvUJZi850c=
X-Gm-Gg: ATEYQzz7pp0w0QeqydRUbi1rAtvhNvWje2IouY/z3McK/zv0weLmH7VbNF7+xwuK2qJ
	gOxfOizcFeFFBLtMzYSZBngpU9JpaTI59/R+kmOxB9dXwiPomgRoZMwl7jhZ+mnjDHBE8D+ZCMH
	JC9q4QAivr8492h4x/OAVQllgycFAXxZVF9lfx8ZgpiLxttInYyj+EFXZxlQy2hmrR9bDHP/rXu
	D/j8XMel65ppiyD6uDN1lghKmdshCEfz/JUOLoc+43YpZlyt9FxSNzJKs7q53GrYQpt/L5qC3he
	HTSDJTY5JEg98jjke9TbmBs7F4rQYK5FcYY1LLCKkCJaUXdqxFtDon0fulnx508g6ByXLozB+Et
	Xw4ZA4uGev3rA0Y3C+sMkAZq1tlykgv3lYU9Brun8tsq8EfNOsRuUG1ieOBRBkFqNMzJKktulnM
	as5/6YWV3QX//G2SfyeuWTTFQVyf6+QkPQ8XK9jXcHU9o9m1xmhwlprMlOxCuu5amqVo5FInL5i
	F9HQQ==
X-Received: by 2002:a05:600c:3483:b0:485:7f45:f71f with SMTP id 5b1f17b1804b1-486ff0293fdmr223975835e9.32.1774352319384;
        Tue, 24 Mar 2026 04:38:39 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:39 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:11 +0400
Subject: [PATCH v5 06/11] power: supply: bq257xx: Make the default current
 limit a per-chip attribute
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-6-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=alchark@flipper.net;
 h=from:subject:message-id; bh=HoUkMd3aj0s9m5BRWarIKv4NrOIfktIuX7B1xZTtvpY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl8btGJtvBWLs+5ftfIvBW7/dWOn33hixXj2zqLfD
 ReWPrep7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCqLyQxMvzwjds5K2fqu3t/N909rnzDKDHIyNWnxLJnetDE5TN2L7jC8N/pyJX
 Z2xeKmgr/vJ3AHJcjkLOLYfuM2EOfLJmO1hr3zmAEAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add a field for the default current limit to the bq257xx_info structure and
use it instead of the hardcoded value in the probe function.

This prepares the driver for allowing different electrical constraints for
different chip variants.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 7ca4ae610902..39718223c3f9 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -18,6 +18,7 @@ struct bq257xx_chg;
 
 /**
  * struct bq257xx_chip_info - chip specific routines
+ * @default_iindpm_uA: default input current limit in microamps
  * @bq257xx_hw_init: init function for hw
  * @bq257xx_hw_shutdown: shutdown function for hw
  * @bq257xx_get_state: get and update state of hardware
@@ -26,6 +27,7 @@ struct bq257xx_chg;
  * @bq257xx_set_iindpm: set maximum input current (in uA)
  */
 struct bq257xx_chip_info {
+	int default_iindpm_uA;
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
@@ -627,6 +629,7 @@ static const struct power_supply_desc bq257xx_power_supply_desc = {
 };
 
 static const struct bq257xx_chip_info bq25703_chip_info = {
+		.default_iindpm_uA = BQ25703_IINDPM_DEFAULT_UA,
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
@@ -675,7 +678,7 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 				       "input-current-limit-microamp",
 				       &pdata->iindpm_max);
 	if (ret)
-		pdata->iindpm_max = BQ25703_IINDPM_DEFAULT_UA;
+		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
 
 	return 0;
 }

-- 
2.52.0

