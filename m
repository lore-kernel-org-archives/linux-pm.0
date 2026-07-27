Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4D3DE452
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138783; cv=none; b=jy9ivARBTRYGVLKqxmgIKN37qKESjX0RAPnQwRhv15SJGpvGAPSmyWc563FryanYqeSn5m6UyCM0d4pXBXkf3lYsnDQwUKTPa1NWDdjcHhacXcZiC+eam/Fysizv2/AyWPC6YWw/cwM6QnGEkzjhDOdmZTpQYfRMC1m3p3GNlhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138783; c=relaxed/simple;
	bh=9jHIif4kBjuD5OHxib36z30d0hERvbFUsj/nsofcBms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmaFygG8IXRp0MJMu36jDUZW2p6iX7ymHfr3/zlYt3QlspETJHj9oJB51fGGuVVjyzpcbT6gQUslHD2ElTucXLisl3Q4prLxAALWjt+rSP1e3YJ53pd96xZ4ua0YKbj0J734z3xyirJOl5xc5BsqT3KzySW0zVctxAYP5VnSVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=x0GQDkKN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="x0GQDkKN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2009746f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1785138780; x=1785743580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHm7ihSx+92NScJ7QqqG9LrRgrGQfUllgURj8jPf/3I=;
        b=x0GQDkKNfPj3968xVFj2MMGkn0uVaKRD0NdtUFn5QRQXbeDQb1VlqSl5dsz68NyykA
         6VIPmOmxn39igYcYBmOPfR03+z5fEZnGfMHrNc31R8/1UAZhMfQ5nLtf35N97tydAMJv
         bDzA9T3oSoNezL5b3K0ScUBdlV8PJtWKveESSfBqP2OTrIiJiLiK2Y3cuIC65w8s+z4U
         4rvvXeoMnoshGBsc0Vs4bMXnqwXF9HZhFMwKFyN0SaOai8QIX73AXDJfbIiVRhSMCkR+
         xWHKi4uDqA/4j/RgtU7tnjrRalj4KgMvhhULkCczJyeQg4B3iWxgAfVEDTGRZjBXy/Ed
         9o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138780; x=1785743580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XHm7ihSx+92NScJ7QqqG9LrRgrGQfUllgURj8jPf/3I=;
        b=O2QN5ti9EBiKoEf1mu0T01JkvmFRohjh2ZRwYOID/rbiXldo17nf0n8P8kWjxX4yNh
         MmAaCsGlAHwWiYpWEX9FfSZQrE0R5Oh5Epug7lduzr8Zcgj9hNaAn9NfiWDE0csiT1bg
         k8ZUAN9OuVd2pmSc4U5qwKyAoD6m4iV97YRBgwionkke7nzlb56w1o43rS12PW/h0FN+
         qKpN16RxoMthNhsfSDT/JyHMWoq5AVMbO72RtiCRnusSf1YZJ6p4hU9k3EFe3mXZvP5u
         Qic77DHFiws6FcG7lAOR8sHQ8DGZWz6sNNFFQM0pDtUVshHn1qWM4fTq0FvdbrYWjkjy
         +lhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSG9s7sARmRmtbynbwszX6HcZjZobUvLv72vQA+ziU8GZmLPgTWhRilosBkgIbzkouxK8PEz+FwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH53Svz6dWZSqHcOPhzSEniY4pesmy94iJuNFtVZXf7+2UruWw
	ZgGWBmfJVP+vD3xuO6/xg2jkQl/ePFTsWkCOdAhp0iEzT+aiwv9n9dFVvhfmdG8K3go=
X-Gm-Gg: AR+sD11Hjh4wzpSz+C9D6EVH4iED8E2zbIG2v7lvwlbKor7QtLVsNawX/bMMCnwJLyk
	HiEOCPOdn2xUG+SndnTio/eehaqg37nXwx2cSaN+f0aT6u9Jz2QJ2jdgGuSv78diVO53QFEr1lN
	Z0ZSwyJVMxX/eYHE21iMwAjwnAzXKD2D/lWJnmh9ELTDgvo7sN960/zepObPpTBJyohSHm7OOUp
	YKaaXnYbv8HpIIPXBtwdUBwMxcuKaUT4tJp263/+EHGZXXzA+3OH3TFkJHYOxGBdm0lI4uwJgPm
	VNckCqdxC+Ql9D8ntlmC3us4vm0OvofsqTxokY1Gks14un8hJkK+UXDgVkATXw7+U1Y9ioWvWeX
	Cqv7e7evuhbhSHNAFU+ls4FtEdRv6xJzl9tsUEvsz8YKnMGTeZhJIjdjvhCW/0PFfAkLWCrbx5o
	Ta8xwWdxR8BZCDvol74hOMiSI1urXGc7HuNmmcLeDqZXGK5F+25OCX9g==
X-Received: by 2002:a05:6000:46cd:b0:47f:94a8:d6db with SMTP id ffacd0b85a97d-47f9fe98f6fmr5584505f8f.34.1785138780382;
        Mon, 27 Jul 2026 00:53:00 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae. [92.99.174.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531basm50841449f8f.19.2026.07.27.00.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:52:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 27 Jul 2026 11:52:36 +0400
Subject: [PATCH v8 1/2] regulator: bq257xx: Drop the regulator_dev from the
 driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-bq25792-v8-1-c1c70473bbe7@flipper.net>
References: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
In-Reply-To: <20260727-bq25792-v8-0-c1c70473bbe7@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=alchark@flipper.net;
 h=from:subject:message-id; bh=9jHIif4kBjuD5OHxib36z30d0hERvbFUsj/nsofcBms=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSl8wX3LG849fN00Xen7JP+i1TKJlsb7Lr2gnmqbt6iS
 YfYfJ2udUxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDV2V0M/5NynnfoszUc+BPL03z1YX6AqtVNi8zLt1+Xb4yy5lty4R0jw+vUzkY
 nxRO1BpFCV0VP7dQwjfr6PZA7R/e9kX94QlY7KwA=
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
index 577b277efd7f..b8d6d578285c 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 
 struct bq257xx_reg_data {
-	struct regulator_dev *bq257xx_reg;
 	struct gpio_desc *otg_en_gpio;
 	struct regulator_desc desc;
 };
@@ -144,6 +143,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct bq257xx_reg_data *pdata;
 	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
 
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
@@ -162,9 +162,9 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
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
2.54.0

