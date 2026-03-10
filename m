Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5543E49A
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134958; cv=none; b=YazYgavOFvkaHvdmc9KWwmAYdMO12UieI3/C3Jj/XxSLS6y6Ks+++Xqb4QmvQn0B8smUQAkpI3sTgqVoCU0lejRc6J4KZSDow0NW1BCKsXtAmMCkW31pJtlsc6F/xU9NjA1kzLXlprBE+9t6B5PPbxmLYlEL7OVYvoltu1E08/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134958; c=relaxed/simple;
	bh=1uAjKjH8Mriiu2XHqXVfsDGlgQSHnV96d3u/aQzpXDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuH2GcktzMe2Zd7rChLVkB6N2S/Lese95541C+esL4U5zGHtZQ2C38twTnHzGcbpvs1s4BbyRfEmMqkl1DRaYHhzp3PYw+uErq21mdAlN71irvtJMaBKJrBPWM5BsZLATa79y3kICRB1sg95415CNE4fPHwX2R6f3vOFYje9kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=i4WfYQtr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="i4WfYQtr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534237460so26275225e9.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134955; x=1773739755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=i4WfYQtrTkq6ePczcImq37QLgO77Okbqd7qEBKoWHSM77pRcRfw0i24FaYyN16ju/0
         hBtIYl0Q7Scf4yQ/U6osTc2Rcigu+1Q5xHuG8qtLflrsgrIUrG/+f1VvGbbFivymEtlB
         +aq4THO78NOB77mpZbYgLGAJM7MozvZpUbPdyAhZGyObiymFDPsovWx43MWTHh9PydNB
         hiNuS0oI/Qhvk70isvyTII0O6nkbLV5+Kx3bihFsnXld8iZNRuG0f49lpihvh4dY8TX5
         G64EpXXfWTCVvcVtoBu8aEg6DQjzg/jASOX8+ujmgRZDNc0oaFtSd1OWLf83/7Ickaat
         Kb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134955; x=1773739755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=RhFMQ64zBFtBK1BTXTXuA6N2e8lVIA0Glm/2e/IjuJ5oZANu8EM3Ab45/314GnCgZI
         0CiSmeg2r5XGc1bKRFc+yMtl/CO/owLRVkmq47xajJlTTRavY3aVfsEzJer6+IqiM8wd
         dzzjuCHuN5yHewOEYleR34MQIoCghwfuGYs6cTWZLqWcmy+I+/v4vpqJmxwQ2xbxBlEH
         ezox71amEPatdWl/VvNzLwIvu4vfg5hl8L/SlWkPDaAnRlvpTQmEQVYzPoD8LLyXyVEn
         LNafVBVE0+vA8CjHH996oppZXkI6//7Dk2yylYu5vyA/y5mHUC9ATc2hRm5sgzWdEp1A
         nxJg==
X-Forwarded-Encrypted: i=1; AJvYcCWX8My2tioGr2vBcoPAlke/0pMMpsTx6Z+IkymsMSRfkyBSrOQenA0gl0QUoQ2SWpYRx5tmqfLPAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/DhwClIkpxyB0an2JFWXuf+8rW6baHSHHIHQHoaH4fnEnpYw
	rLK8Td0+4TkqG3QR7TOHM8PmCNdUVuW6VEsaMvAJ+WTpsYpE5KD8FVZEoFxc7jSFDc8=
X-Gm-Gg: ATEYQzw7kGVPjrEZDHWOnuYbweeYwXVtcA2GaUH8NtqkQNiHj4uUoW3Ps/9k6Dw5gCW
	H7vrIA8oSMprM+h1Y17AoS/Rg8rvmdC1dWOXc970ldrLc+/W0F71zQUf5u+K+4iVWpELXx1ZOxi
	xNePudMG4KRKGzCZKUst3Nlzuq95Pu4cFQ8bsIEgjSw+Uvsy4OMyScf118Q9XottG4LXxo1RM+I
	EnilEr5CncsHFOSQcuDzhu+LwJCE/ymGeH/eDZ60us+us/7IKPeEv3si3X97ONM0ea4zVPMTZQt
	Sp3VAzr+NTviWXKhPZ4oURTkvxYGBoz3s7ZsNG8DKskyfref+BX/YrfDhj0BJItJmg0UxbRzcej
	GMrYZCIWJBbOPXCY6MakRo73qWtatYlZ1wQAPpuwgaGbhWPBC0tpfM+8aISouur3Otr4daXWVj6
	VL8fY/QKBUqKIFdGwJV/Sx9e4f8vUn46eo27AMgEcprR6Kb+hCNUGM2Fxw7i+J9MQOx/CTv/hAn
	fqjxGii67aOHr6V
X-Received: by 2002:a05:600c:3e11:b0:485:3a22:69b9 with SMTP id 5b1f17b1804b1-4853a226f66mr110525055e9.29.1773134955154;
        Tue, 10 Mar 2026 02:29:15 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:27 +0400
Subject: [PATCH v3 03/11] regulator: bq257xx: Drop the regulator_dev from
 the driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-3-02f8e232d63b@flipper.net>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
In-Reply-To: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=alchark@flipper.net;
 h=from:subject:message-id; bh=1uAjKjH8Mriiu2XHqXVfsDGlgQSHnV96d3u/aQzpXDo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5L4rq6p4FzKlq514oEcZjcXmf21qOMzd7+dvoox5
 d81ztnBHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEz1HUuG/y4xlhps3pKJenzrdn2653Zzl3FavcHO1bduWysolUy+ZsXwv2bCft2
 FwptPP9e44RDzVWPZk+7dkXPK9S0eHpjTkxO2hgsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The field was not used anywhere in the driver, so just drop it. This helps
further slim down the platform data structure.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 812938e565e3..674dae6109e9 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 
 struct bq257xx_reg_data {
-	struct regulator_dev *bq257xx_reg;
 	struct gpio_desc *otg_en_gpio;
 	struct regulator_desc desc;
 };
@@ -139,6 +138,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
 	pdev->dev.of_node_reused = true;
@@ -159,9 +159,9 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!cfg.regmap)
 		return -ENODEV;
 
-	pdata->bq257xx_reg = devm_regulator_register(dev, &pdata->desc, &cfg);
-	if (IS_ERR(pdata->bq257xx_reg)) {
-		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->bq257xx_reg),
+	rdev = devm_regulator_register(dev, &pdata->desc, &cfg);
+	if (IS_ERR(rdev)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
 				     "error registering bq257xx regulator");
 	}
 

-- 
2.52.0

