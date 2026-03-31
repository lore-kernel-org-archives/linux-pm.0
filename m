Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBB41B34D
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971846; cv=none; b=pllFHQHiEf/pineskGPsLU4rXFdqqdRkD2fOJVS+Jb6Mt61rW7u9u3XHtPW/6qWYDPqa6McaiNRn8gNTwDwKKEwMlkIocnbp4HU1TpDdrQsQbDVFO5gi+ojW6wCwYkFJUZPOcLYQ9KL0z9+wDSgrPyKZUBAZ9U14LmHFi764ZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971846; c=relaxed/simple;
	bh=HoUkMd3aj0s9m5BRWarIKv4NrOIfktIuX7B1xZTtvpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwLErubRqiQqdtVqwh07DPBmHRfB12m9SK36X2jvvPabGsKbJ/LbFfvT6y5kum40lqUW4cvN5YO/fCp6wS0RM8l4WA6LWMmQ1OPUNV4YNVtvh3iLQbEdJHEyLiH/Gcd8X7smQAWzBBTbI7u4ybKrvficR7JTkaI0FRxEuQxlY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=IaCwYfwj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="IaCwYfwj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483487335c2so63071225e9.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971843; x=1775576643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv4k2NFngBv6AeWEv4O9srLSbI6EPVNmV51Qs0A5klE=;
        b=IaCwYfwjk+9pZGEcglvLOH5NCVKRXaON3jeepXBRTxclg4znbhHPyNPN5YNXkU7rj1
         XN46uQvriYKCQkHx7nLKAjmdraT7LVfU2Nb1K3rXA/YsSfHp20CPiD2ig2VqI8CbE/og
         k7mJR73eQPKeePq841wwX9a6cYORjmtW2e5OuIDqSMN4qzfNF39i9mB7y+kHOALBKpZF
         03pkeZ7xckk8nhMuS8nbSnbH0++YLb/ZAxDuwZJgDs8+yEPxvMPCz4EcFYPo0PWzbHd6
         75BSOAnoq7Xe8KzZRl86spW45IXM10q7mg9omYNywa1gWvyQx+NdiDxDNa8tuF6w3mqD
         Cqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971843; x=1775576643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jv4k2NFngBv6AeWEv4O9srLSbI6EPVNmV51Qs0A5klE=;
        b=W8aFFkhgVJEMg/UqiZSOZowRXeL2qvQNsysh2yXWFt5chbceGQKO01qvQ0fc+h/aFH
         2/yyS9SoehwAeptUUXIZ7N1vX8xKurRtQkHbTaJ2kKktpLJHz2jhHVojTYOuvk0tteWn
         lz0ROaTso/8EpQ/dyQ0U3LaqmP/1ewMa4jbZ6dkjL6/lmHsrgpK5ORsUG+lvX3fBamiB
         GV7UgcxjwWK2JkFmxUxDlwyUBB9mOmwHW/ZOP57gXGzEv51rz8IKgZINWoTXw8XqS252
         raYJnUjE8ODpexdN6HzVjPrPvwLZtvsA7pxdZ4sC3rYzFhxcUrvhoYNquZR3gNBis8/u
         SxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsP1VjYJX2DGY/Rzn6b2sMreQTQBewxZ5ya5JBUr9LJa/rSQQZU+d4jcdR7ZVOWu54LBicA5ZeBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUFH+v4GyiUEc4K5YIkdzjypsSrOtgaVZN0WPwtMzqHX5m14R
	5z4U/B6QOP2rJNYdIznd7a3wFtGF6OciScWSi7iIpDFn53FKrjZ+ro+Am2rC60Pypu0=
X-Gm-Gg: ATEYQzzHVCv/ammZSPsHdcwGpf1UwR3f9f3PP7PHhjwvBrjELE895Pg/mlz7tYwro69
	0x/xziwraW62h+IUhC7cEw+GBo28Dvw2hQdwkGbI2dPfRt6gmmXTM2Jf1z2EHkzF/qdFu0Wql/L
	LDeQsrXkU7g7N46tW6yJmxgtGpyTvw1yCh39HTt34bRpM/muevcgdkJ1l5N7kk6PGo9+pCH05FD
	Vo/dM0hC8HP02ub/RF924LzAKwDaCuBVb5ntykLR0BMAuciFVopzk+gNzarUCJaN3czOSVk3339
	Rjb+oWfBYk0MbI7RqzkgOPD8esJ10xCROZ8EnUqS1O8Pumg0Fipba0KDx+NYgDOs3VxSd/LrQp6
	ucKiv7dQChENt4JunKMbukQlVqx9doXnjAPgFfplE3sa7ZdADXZZw76D6OPJY8ZXyYqgHmHVpA1
	W8Rbddk4q9sTftvrF2ifk3Ur8x3XbVzZkKGYwbImHdZ9jdtSIxQi4MUq2bpiILleySczjo64mHo
	i+uIw==
X-Received: by 2002:a05:600c:1d1e:b0:486:fc95:1a91 with SMTP id 5b1f17b1804b1-48727f2373dmr287944595e9.12.1774971842949;
        Tue, 31 Mar 2026 08:44:02 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:44:02 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:43 +0400
Subject: [PATCH v6 06/11] power: supply: bq257xx: Make the default current
 limit a per-chip attribute
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-6-0278fba33eb9@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=alchark@flipper.net;
 h=from:subject:message-id; bh=HoUkMd3aj0s9m5BRWarIKv4NrOIfktIuX7B1xZTtvpY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr3ef0ttquypte31uzOPPijUa9PT2HKimnHdZVnRH
 0+ucm5e3zGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBUJxgy/DOYdUY7yz5kzsZgxwXp0/L+vf1w7O3eBSWXNetnxHrc3X2ckWG3ouj
 vM+evmi9YI8x49ceKQKGJWy2m/YnJ+99caDdn9Q1WAA==
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

